library(tidyverse)
library(dummies)
library(margins)
library(dplyr)
library(kableExtra)
library(sjPlot)

#library(pander)
#library(knitr)
#library(sjmisc)
#library(mosaic)


brca = read.csv(url("https://raw.githubusercontent.com/bmagalhaes/ECO395M-HW2/master/brca.csv"))

recall_rate = brca %>%
  group_by(radiologist)  %>%
  summarize(A.recallrate = length(which(recall == 1)) / (length(which(recall == 1))
            + length(which(recall == 0))))

recall_rate = recall_rate[order(-recall_rate$A.recallrate),c(1,2)]
recall_rate = mutate(recall_rate, n = row_number())

cancer_rate = brca %>%
  group_by(radiologist)  %>%
  summarize(B.cancerrate = length(which(recall == 1 & cancer == 1)) / (length(which(recall == 1 & 
            cancer == 1)) + length(which(recall == 1 & cancer == 0))))

error_rate = brca %>%
  group_by(radiologist)  %>%
  summarize(C.error = length(which(recall == 0 & cancer == 1)) / (length(which(recall == 0 & 
            cancer == 1)) + length(which(recall == 0 & cancer == 0))))

radiologist = left_join(recall_rate, cancer_rate, by = "radiologist")
radiologist = left_join(radiologist, error_rate, by = "radiologist")

radiologist_long = radiologist %>%
  gather("Stat", "Value", -radiologist, -n)
radiologist_long = mutate(radiologist_long, Value = Value*100)

radiologist_89 = radiologist_long[which(radiologist_long$n==1), ]

ggplot(data = radiologist_long) + 
  geom_bar(mapping = aes(x=reorder(radiologist, -n), y=Value),
           stat='identity', position ='dodge', fill="lightgray", color="black", alpha=.6, width=.5) + 
  facet_wrap(~Stat) + 
  coord_flip() +
  labs(title="Practice", y="Observed rate (in percentage)", x = "") +
  geom_hline(data= radiologist_89, aes(yintercept=Value), color="red" , linetype = "dashed") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank()) 

brca2 = brca
brca2$radiologist = str_replace(brca2$radiologist, "radiologist","")
brca2$age = str_replace(brca2$age, "age","")
brca2$menopause = str_replace(brca2$menopause, "meno","")
brca2$density = str_replace(brca2$density, "density","")

brca_new = dummy.data.frame(brca2, names = c("radiologist", "age","menopause", "density") , sep = ".")
brca_new = subset(brca_new, select = -c(radiologist.13, age.4049,menopause.postHT, density.1))


model_1 = glm(recall ~ . - cancer, data=brca_new, family=binomial)
ame_11 = summary(margins(model_1, variables = list("radiologist.34", "radiologist.66", "radiologist.89", "radiologist.95")))
ame_12 = summary(margins(model_1, at = list(history = 0, symptoms = 0, age.5059 = 0, age.6069 = 0,age.70plus = 0,
                           menopause.pre = 0,menopause.postunknown = 0,menopause.postNoHT = 0,
                           density.2 = 1), variables = list("radiologist.34", "radiologist.66",
                                                            "radiologist.89", "radiologist.95")))

model_2 = glm(recall ~ (. - cancer)^2, data=brca_new, family=binomial)
ame_21 = summary(margins(model_2, variables = list("radiologist.34", "radiologist.66", "radiologist.89", "radiologist.95"), vce = "bootstrap"))
ame_22 = summary(margins(model_2, at = list(history = 0, symptoms = 0, age.5059 = 0, age.6069 = 0,age.70plus = 0,
                           menopause.pre = 0,menopause.postunknown = 0,menopause.postNoHT = 0,
                           density.2 = 1), variables = list("radiologist.34", "radiologist.66",
                                                            "radiologist.89", "radiologist.95"), vce = "bootstrap"))

ame_11 = select(ame_11,-c(4:7))
ame_12 = select(ame_12,-c(2:10,13:16))
ame_21 = select(ame_21,-c(4:7))
ame_22 = select(ame_22,-c(2:10,13:16))

ame = left_join(ame_11, ame_12, by = "factor")
ame = left_join(ame, ame_21, by = "factor")
ame = left_join(ame, ame_22, by = "factor")
colnames(ame) <- c("","AME","se","AME","se","AME","se","AME","se")

kable(ame) %>%
  kable_styling("striped") %>%
  add_header_above(c(" " = 1, "AME" = 2, "AME at x*" = 2, "AME" = 2, "AME at x*" = 2)) %>%
  add_header_above(c(" ", "Model 1" = 4, "Model 2" = 4))

###
prob_cancer = sum(brca$cancer == 1)/nrow(brca)

model_cancer = glm(cancer ~ recall, data=brca, family=binomial)
coef(model_cancer)
yhat = predict(model_cancer, brca, type="response")
yhat_test = ifelse(yhat >= prob_cancer, 1, 0)
table(y=brca$cancer, yhat=yhat_test)

model_cancer2 = glm(cancer ~ recall + history, data=brca, family=binomial)
coef(model_cancer2)
yhat_2 = predict(model_cancer2, brca, type="response")
yhat_test2 = ifelse(yhat_2 >= prob_cancer, 1, 0)
table(y=brca$cancer, yhat=yhat_test2)

model_cancer3 = glm(cancer ~ recall + age, data=brca, family=binomial)
coef(model_cancer3)
yhat_3 = predict(model_cancer3, brca, type="response")
yhat_test3 = ifelse(yhat_3 >= prob_cancer, 1, 0)
table(y=brca$cancer, yhat=yhat_test3)

model_cancer4 = glm(cancer ~ recall + symptoms, data=brca, family=binomial)
coef(model_cancer4)
yhat_4 = predict(model_cancer4, brca, type="response")
yhat_test4 = ifelse(yhat_4 >= prob_cancer, 1, 0)
table(y=brca$cancer, yhat=yhat_test4)

model_cancer5 = glm(cancer ~ recall + menopause, data=brca, family=binomial)
coef(model_cancer5)
yhat_5 = predict(model_cancer5, brca, type="response")
yhat_test5 = ifelse(yhat_5 >= prob_cancer, 1, 0)
table(y=brca$cancer, yhat=yhat_test5)

model_cancer6 = glm(cancer ~ recall + density, data=brca, family=binomial)
coef(model_cancer6)
yhat_6 = predict(model_cancer6, brca, type="response")
yhat_test6 = ifelse(yhat_6 >= prob_cancer, 1, 0)
table(y=brca$cancer, yhat=yhat_test6)

model_cancer7 = glm(cancer ~ recall + age + density, data=brca, family=binomial)
coef(model_cancer7)
yhat_7 = predict(model_cancer7, brca, type="response")
yhat_test7 = ifelse(yhat_7 >= 0.04, 1, 0)
table(y=brca$cancer, yhat=yhat_test7)

tab_model(model_cancer, model_cancer2, model_cancer3, model_cancer4, model_cancer5,
          model_cancer6, show.ci = FALSE, show.p = TRUE,
          dv.labels = c("Baseline Model", "+ History", "+ Age", "+Symptoms",
                        "+Menopause", "+ Density"))

rmse(brca$cancer, yhat)

xtabs(~cancer + recall, data=brca)
