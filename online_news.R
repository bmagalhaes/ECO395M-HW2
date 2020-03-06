library(tidyverse)
library(mosaic)
library(class)
library(FNN)
library(foreach)
library(knitr)
library(kableExtra)
library(ggplot2)

dataset = read.csv('https://raw.githubusercontent.com/jgscott/ECO395M/master/data/online_news.csv')

ggplot(data=dataset, aes(x = shares)) +
  geom_histogram(binwidth = 200, fill="lightgray", color="black", alpha=.6) +
  geom_vline(xintercept = 1400 , color="red" , linetype = "dashed") +
  labs(title = 'Shares Histogram', x = "# Shares", y = "Frequency")+
  xlim(0, 10000)+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), panel.grid.major.y = element_line(colour = "grey"))

ggplot(data=dataset, aes(x = log(shares))) +
  geom_histogram(binwidth = 0.275, fill="lightgray", color="black", alpha=.6) +
  geom_vline(xintercept = log(1400) , color="red" , linetype = "dashed") +
  labs(title = 'Log Shares Histogram', x = "Log Shares", y = "Frequency")+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), panel.grid.major.y = element_line(colour = "grey"))

lm1 = lm(log(shares) ~ . - url, data=dataset)
summ(lm1)

news_articles = subset(dataset, select = -c(n_tokens_content, self_reference_max_shares, max_positive_polarity,
                                            min_negative_polarity, weekday_is_sunday, is_weekend, url))
news_articles$shares = log(news_articles$shares)

lm2 = lm(shares ~ . , data=news_articles)
summ(lm2)

lm3 = lm(shares ~ (.)^2, data=news_articles)
summ(lm3)

lm_step = step(lm2, scope=~(.)^2, steps = 10)

# confusion rate
error_rate = function(y, yhat) {
  y_test = ifelse(y>log(1400), 1, 0)
  yh_t = ifelse(yhat>log(1400), 1, 0)
  sum(yh_t != y_test)/length(y)
}  

n = nrow(news_articles)
n_train = round(0.8*n)
n_test = n - n_train

err_vals = do(100)*{
  train_cases = sample.int(n, n_train, replace=FALSE)
  test_cases = setdiff(1:n, train_cases)
  news_articles_train = news_articles[train_cases,]
  news_articles_test = news_articles[test_cases,]
  
  lm1 = lm(shares ~ . , data = news_articles_test)
  
  lm2 =  lm(shares ~ . - n_tokens_content - self_reference_max_shares - weekday_is_saturday
            - weekday_is_sunday - is_weekend - max_negative_polarity - min_negative_polarity, data = news_articles_test)
  
  lm3 =  lm(shares ~ (. - n_tokens_content - self_reference_max_shares - weekday_is_saturday
                      - weekday_is_sunday - is_weekend - max_negative_polarity - min_negative_polarity)^2, data = news_articles_test)
  
  lm4 = lm(formula = shares ~ n_tokens_title + num_hrefs + num_self_hrefs + 
             num_imgs + num_videos + average_token_length + num_keywords + 
             data_channel_is_lifestyle + data_channel_is_entertainment + 
             data_channel_is_bus + data_channel_is_socmed + data_channel_is_tech + 
             data_channel_is_world + self_reference_min_shares + self_reference_avg_sharess + 
             weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
             weekday_is_thursday + weekday_is_friday + global_rate_positive_words + 
             global_rate_negative_words + avg_positive_polarity + min_positive_polarity + 
             max_positive_polarity + avg_negative_polarity + title_subjectivity + 
             title_sentiment_polarity + abs_title_sentiment_polarity + 
             self_reference_min_shares:self_reference_avg_sharess, data=news_articles_test)
  
  yhat_test1 = predict(lm1, news_articles_test)
  yhat_test2 = predict(lm2, news_articles_test)
  yhat_test3 = predict(lm3, news_articles_test)
  yhat_test4 = predict(lm4, news_articles_test)
  
  c(error_rate(news_articles_test$shares, yhat_test1), error_rate(news_articles_test$shares, yhat_test2),
    error_rate(news_articles_test$shares, yhat_test3), error_rate(news_articles_test$shares, yhat_test4)) %>% round(3)
  
}
colMeans(err_vals)

lm_chosen = lm(shares ~ (. - n_tokens_content - self_reference_max_shares - weekday_is_saturday
                         - weekday_is_sunday - is_weekend - max_negative_polarity - min_negative_polarity)^2, data=news_articles)

news_articles$yhat = predict(lm_chosen, news_articles)

news_articles = mutate(news_articles, viral = ifelse(news_articles$share >= log(1400), 1, 0))
news_articles = mutate(news_articles, viral_hat = ifelse(news_articles$yhat >= log(1400), 1, 0))

xtabs(~viral + viral_hat, data=news_articles)

#accuracy rate
(length(which(news_articles$viral == 1 & news_articles$viral_hat == 1))+
    length(which(news_articles$viral == 0 & news_articles$viral_hat == 0))) / nrow(news_articles)
#null model
length(which(news_articles$viral == 1)) / nrow(news_articles)

##GLM models
err_vals_glm = do(100)*{
  train_cases = sample.int(n, n_train, replace=FALSE)
  test_cases = setdiff(1:n, train_cases)
  news_articles_train = news_articles[train_cases,]
  news_articles_test = news_articles[test_cases,]
  
  glm_base = glm(formula = viral ~ n_tokens_title + num_hrefs + num_self_hrefs + 
                   num_imgs + num_videos + average_token_length + num_keywords + 
                   data_channel_is_lifestyle + data_channel_is_entertainment + 
                   data_channel_is_bus + data_channel_is_socmed + data_channel_is_tech + 
                   data_channel_is_world + self_reference_min_shares + self_reference_avg_sharess + 
                   weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + 
                   weekday_is_thursday + weekday_is_friday + global_rate_positive_words + 
                   global_rate_negative_words + avg_positive_polarity + min_positive_polarity + 
                   max_positive_polarity + avg_negative_polarity + title_subjectivity + 
                   title_sentiment_polarity + abs_title_sentiment_polarity + 
                   self_reference_min_shares:self_reference_avg_sharess, data=news_articles_test, family = 'binomial')
  
  #glm_base = glm(viral ~  . , data = news_articles_test, family = 'binomial')
  
  
  # glm_step = glm(formula = viral ~ lm_step, data = news_articles_test, family = 'binomial')
  
  glm_chosen = glm(viral ~ (. - n_tokens_content - self_reference_max_shares - weekday_is_saturday
                            - weekday_is_sunday - is_weekend - max_negative_polarity - min_negative_polarity)^2, 
                   data=news_articles_test, family = 'binomial')
  
  yhat_test1 = predict(glm_base, news_articles_test, type='response')
  #yhat_test2 = predict(glm_step, news_articles_test)
  yhat_test3 = predict(glm_chosen, news_articles_test, type='response')
  
  c(error_rate(news_articles_test$viral, yhat_test1),
    error_rate(news_articles_test$viral, yhat_test3)) %>% round(3)
  
}
colMeans(err_vals_glm)

glm_step = glm(viral ~ . ,step(lm2, scope=~(.)^2, steps=1, data = news_articles_test, family = 'binomial'))
#
news_articles$yhat = predict(glm_step, news_articles)

news_articles = mutate(news_articles_test, viral = ifelse(news_articles$share >= log(1400), 1, 0))
news_articles = mutate(news_articles_test, viral_hat = ifelse(news_articles$yhat >= log(1400), 1, 0))

xtabs(~viral + viral_hat, data=news_articles)

#accuracy rate
(length(which(news_articles$viral == 1 & news_articles$viral_hat == 1))+
    length(which(news_articles$viral == 0 & news_articles$viral_hat == 0))) / nrow(news_articles)

#null model
length(which(news_articles$viral == 1)) / nrow(news_articles)

#knn

online_news = read.csv('https://raw.githubusercontent.com/jgscott/ECO395M/master/data/online_news.csv')
online_news = mutate(online_news, viral = ifelse(online_news$shares > 1400, 1, 0))
prob_viral = length(which(online_news$viral == 1))/nrow(online_news)

X_all = model.matrix(~n_tokens_title + n_tokens_content + num_hrefs + num_self_hrefs +
                       num_imgs + num_videos + average_token_length + num_keywords +
                       data_channel_is_lifestyle + data_channel_is_entertainment +
                       data_channel_is_bus + data_channel_is_socmed + data_channel_is_tech +
                       data_channel_is_world + self_reference_min_shares + self_reference_max_shares +
                       self_reference_avg_sharess + weekday_is_monday + weekday_is_tuesday +
                       weekday_is_wednesday + weekday_is_thursday + weekday_is_friday + weekday_is_saturday +
                       weekday_is_sunday + is_weekend + global_rate_positive_words + global_rate_negative_words +
                       avg_positive_polarity + min_positive_polarity + max_positive_polarity + avg_negative_polarity +
                       min_negative_polarity + max_negative_polarity + title_subjectivity + title_sentiment_polarity +
                       abs_title_sentiment_polarity - 1, data=online_news)
head(X_all)

# standardize the columns of X_all
feature_sd = apply(X_all, 2, sd)
X_std = scale(X_all, scale=feature_sd)

# now use LOOCV across a grid of values for K
k_grid = seq(3, 75, by=1)
N = nrow(online_news)
# loop over the individual data points for leave-one-out
loo_mse2 = foreach(i = 1:50, .combine='rbind') %dopar% {
  X_train = X_std[-i,]
  X_test = X_std[i,]
  y_train = online_news$shares[-i]
  y_test = online_news$shares[i]
  
  # fit the models: loop over k
  knn_reg = foreach(k = k_grid, .combine='c') %do% {
    knn_fit = knn.reg(X_train, X_test, y_train, k)
    knn_testpred = ifelse(knn_fit&pred >= prob_viral, 1, 0)
  }
  
  # return results from the loop over k
  knn_mse_out
}

knn_rmse = sqrt(colMeans(loo_mse2))


















X_all = model.matrix(~n_tokens_title + num_hrefs + num_self_hrefs +
                       num_imgs + num_videos + average_token_length + num_keywords +
                       data_channel_is_lifestyle + data_channel_is_entertainment +
                       data_channel_is_bus + data_channel_is_socmed + data_channel_is_tech +
                       data_channel_is_world + self_reference_min_shares +
                       self_reference_avg_sharess + weekday_is_monday + weekday_is_tuesday +
                       weekday_is_wednesday + weekday_is_thursday + weekday_is_friday + weekday_is_saturday +
                       + global_rate_positive_words + global_rate_negative_words +
                       avg_positive_polarity + min_positive_polarity + max_positive_polarity + avg_negative_polarity +
                       + title_subjectivity + title_sentiment_polarity +
                       abs_title_sentiment_polarity - 1, data=online_news)
head(X_all)

# standardize the columns of X_all
feature_sd = apply(X_all, 2, sd)
X_std = scale(X_all, scale=feature_sd)

# now use LOOCV across a grid of values for K
k_grid = seq(25, 27, by=1)

n = nrow(X_all)
n_train = round(0.8*n)  
n_test = n - n_train

# loop over the individual data points for leave-one-out
boot1 = do(2)*{
  train_cases = sample.int(n, n_train, replace=FALSE)
  test_cases = setdiff(1:n, train_cases)
  
  X_train = X_std[train_cases,]
  X_test = X_std[test_cases,]
  
  y_train = online_news$viral[train_cases]
  y_test = online_news$viral[test_cases]
  
  # fit the models: loop over k
  knn_reg = foreach(k = k_grid, .combine='c') %do% {
    knn_fit = knn.reg(X_train, X_test, y_train, k)
    knn_testpred = ifelse(knn_fit$pred >= prob_viral, 1, 0)
    conf_matrix = table(y = y_test, yhat= knn_testpred)
    accuracy = sum(diag(conf_matrix))/sum(conf_matrix)
    accuracy
  }
  
  # return results from the loop over k
  knn_reg
}

knn_rmse = sqrt(colMeans(loo_mse2))

