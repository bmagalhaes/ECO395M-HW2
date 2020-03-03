library(tidyverse)
library(mosaic)
library(class)
library(FNN)
library(foreach)
library(knitr)
library(kableExtra)
library(ggplot2)

dataset = read.csv('https://raw.githubusercontent.com/jgscott/ECO395M/master/data/online_news.csv')
summary(dataset)
# Total observations: 39,644. Total variables: 36 (except URL)

#let's clean the data out. Since we don't need the variable 'url' we will take it out. 
#We will remove the average length of the words in the content ('average_token_length) that is zero, as there should be some words in the article.
#We will also remove variables like number of words in the article ('n_tokens_content') for the same reason
news_articles = subset(dataset, select = -c(url))
summary(news_articles$n_tokens_content)
news_zero_content = news_articles[which(news_articles$n_tokens_content==0),]
summary(news_zero_content)
news_articles = news_articles[-which(news_articles$n_tokens_content==0),]
summary(news_articles)

#Now we are left with 38,463 observations.
#Now since the data is uniformly distributed, we take log scale of shares (log(shares)) for our linear and logit regression
hist(news_articles$shares, xlim=c(1,10000), breaks=5000) ; abline(v=1400, col='blue')
hist(log(news_articles$shares), breaks=50) ; abline(v=log(1400), col='blue')
summary(news_articles$shares)

#using mutate to create a new variable, log of shares in the dataset
news_articles = mutate(news_articles, logshares = log(shares))

##Analysing the data
#Our goal is to find a worthwhile relationship between logshares and other variables

##Modelling 
#We will test the model by utilising the confusion matrix 
#As we are doing random sampling, results may vary every time.
#We will loop this stage 250 times and average the test results.


##Linear model
# Let's split the data for training and testing. Like always we use 80% of the data to build a model by training 
#Similarly, 20% data for testing
n = nrow(news_articles)
n_train = round(0.8*n)  # round to nearest integer
n_test = n - n_train

#Let's build a linear regression model by hand build and trial
#We first use the overall error rate to find the best linear model


## linear model - We will try 3 linear models and use the overall error rate as the metric to find the best model
# Model 3 is the primary model to check the performance of the hand-build model
# By assessing the relationship of variables, building the model and testing it, we make the second model
#Lastly, we build the linear model 1 by deleting the variables which have low p-values.


err_vals = do(250)*{
  
  train_cases = sample.int(n, n_train, replace=FALSE)
  test_cases = setdiff(1:n, train_cases)
  news_articles_train = news_articles[train_cases,]
  news_articles_test = news_articles[test_cases,]
  
  lm1 = lm(logshares ~ num_hrefs + n_tokens_content + num_self_hrefs + average_token_length + 
             num_keywords + data_channel_is_lifestyle + 
             num_imgs * (data_channel_is_bus + data_channel_is_socmed + data_channel_is_world) +
             num_videos * (data_channel_is_entertainment + data_channel_is_bus + 
                        data_channel_is_socmed + data_channel_is_tech + data_channel_is_world) +
             self_reference_avg_sharess * weekday_is_saturday + 
             is_weekend + global_rate_positive_words * is_weekend + 
             title_subjectivity + title_sentiment_polarity, data = n_train)
  
  lm2 =  lm(logshares ~ n_tokens_title + n_tokens_content + num_hrefs + num_self_hrefs + 
              average_token_length + num_keywords + (num_videos + num_imgs) * 
              (data_channel_is_lifestyle + data_channel_is_entertainment +
                 data_channel_is_bus + data_channel_is_socmed +
                 data_channel_is_tech + data_channel_is_world) +
              self_reference_avg_sharess * (self_reference_min_shares + 
              self_reference_max_shares) + weekday_is_monday + 
              global_rate_positive_words * avg_positive_polarity + 
              global_rate_negative_words * avg_negative_polarity + title_subjectivity +
              title_sentiment_polarity, data = n_train, weekday_is_friday = binomial)
  
  lm3 = lm(logshares ~ (n_tokens_title + n_tokens_content + num_hrefs + 
                      num_self_hrefs + num_imgs + num_videos + 
                      average_token_length + num_keywords + data_channel_is_lifestyle + 
                      data_channel_is_entertainment + data_channel_is_bus + 
                      + data_channel_is_socmed + data_channel_is_tech + 
                      data_channel_is_world + self_reference_avg_sharess + 
                      weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                      weekday_is_thursday + weekday_is_friday + weekday_is_saturday)^2, data=OnlineNews_train)
  
  yhat_test1 = predict(lm1, news_articles_test)
  yhat_test2 = predict(lm2, news_articles_test)
  yhat_test3 = predict(lm3, news_articles_test)
  
  # confusion rate
conf_rate = function(y, yhat) {
    y_test = ifelse(y>log(1400), 1, 0)
    yh_t = ifelse(yhat>log(1400), 1, 0)
    sum(yh_t != y_test)/length(y)
  }  

  c(conf_rate(news_articles_test$logshares, yhat_test1), conf_rate(news_test$logshares, yhat_test2),
    conf_rate(news_articles_test$logshares, yhat_test3)) %>% round(3)
  
}
colMeans(err_vals)

# Confusion matrix 
confusion_matrix = table(y_test, yhat_test)
confusion_matrix


## Classification model - Second approach
# We now build a logit model for classification as the dependent variable here (viral or not) is a binary
# Independent variables would be the same as for a linear model
# 
news_articles = mutate(news_articles, viral = ifelse(shares > 1400,1,0))
errs_vals = do(250) * {
  train_cases = sample.int(n, n_train, replace=FALSE)
  test_cases = setdiff(1:n, train_cases)
  news_train = news_articles[train_cases,]
  news_test = news_articles[test_cases,]
  
  logit_model = glm(viral ~  n_tokens_content + num_hrefs + num_self_hrefs + average_token_length + 
                  num_keywords + data_channel_is_lifestyle + num_videos * 
                  (data_channel_is_bus + data_channel_is_socmed + data_channel_is_world) + video * 
                  (data_channel_is_entertainment + weekday_is_monday +
                     data_channel_is_tech + data_channel_is_world) + self_reference_max_shares + is_weekend + global_rate_positive_words * 
                  avg_positive_polarity + avg_negative_polarity +
                  title_subjectivity + title_sentiment_polarity, data = news_train, family = 'binomial')
  phat_logit = predict(logit_m, news_test, type = 'response')
  yhat_logit = ifelse(phat_logit>0.5, 1, 0)
  ct_lg = table(news_test$viral, yhat_logit)
  
  # linear
  finalin = lm(logshares ~ n_tokens_content + num_hrefs + num_self_hrefs + average_token_length + 
             num_keywords + data_channel_is_lifestyle + num_imgs * 
             (data_channel_is_bus + data_channel_is_socmed + data_channel_is_world) + video * 
             (data_channel_is_entertainment + global_rate_positive_words + global_rate_negative_words + data_channel_is_socmed +
                data_channel_is_tech + data_channel_is_world) +  self_reference_avg_sharess * 
             self_reference_max_shares + is_weekend + global_rate_positive_words * 
             avg_positive_polarity + avg_negative_polarity +
             title_subjectivity + title_sentiment_polarity, data = news_train)
  yhatF = predict(lmF, news_test)
  ct_lm = conf_table(news_test$logshares, yhatF)
  
  # result
  c((1-sum(diag(ct_lg))/sum(ct_lg)), (1-sum(diag(ct_lm))/sum(ct_lm)),
    ct_lg[2,2]/sum(ct_lg[2,]), ct_lm[2,2]/sum(ct_lm[2,]),
    ct_lg[1,2]/sum(ct_lg[1,]), ct_lm[1,2]/sum(ct_lm[1,]))
} 
errMean = colMeans(errs_vals) %>% round(3)
err = matrix(errMean, nrow = 2, dimnames = 
               list(c("Classification Model", "Linear Model"), 
                    c("Overall Error", "True Positive", "False Positive"))) 

kable(err) %>% kable_styling("striped")

##
#  Root mean-squared prediction error
rmse = function(y, yhat) {
sqrt( mean( (y - yhat)^2 ) )
}
rmse(news_test$shares, yhat_test1)


##
KNN_result <- data.frame(K=c(), rsme=c())
k_grid = seq(3, 150, by=20)
for(v in k_grid){
  avgrmse = KNN_C_error(data_X = X,data_y = Y, K = v,Ntimes = 5)
  KNN_result <- rbind(KNN_result,c(v,avgrmse))
}
colnames(KNN_result) <- c("K","AVG_RMSE")
ggplot(data = KNN_result, aes(x = K, y = AVG_RMSE)) + 
  geom_point(shape = "O") +
  geom_line(col = "red")


obj_Y = subset(news_articles,select = c(viral))

KNN_result <- data.frame(K=c(), rsme=c())
k_grid = seq(53, 250, by=30)
for(v in k_grid){
  avgrmse = KNN_C_error_linear(data_X = x,data_y = Y,obj_y = obj_Y, K = v,threshold = 1400,Ntimes = 5)
  KNN_result <- rbind(KNN_result,c(v,avgrmse))
}
colnames(KNN_result) <- c("K","AVG_RMSE")
ggplot(data = KNN_result, aes(x = K, y = AVG_RMSE)) + 
  geom_point(shape = "O") +
  geom_line(col = "red")

###
#In-sample accuracy
probhat_test = predict(finalin, news_test=spamtest)
yhat_train = ifelse(predict(finalin) >= 0.75, 1, 0)
table(y=news_test$logshares, yhat=yhatF)

# Confusion matrix of our best model
confusion = table(y = n_train$viral, yhat_train)
confusion

# Confusion matrix of logit_m
confusion_logit_m = table(y = news_articles$viral, yhat = logit_m)
confusion_logit_m

##

#So we can see that the Oveall Error rate for Classification model