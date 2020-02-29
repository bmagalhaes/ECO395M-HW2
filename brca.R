library(tidyverse)
library(mosaic)

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

ggplot(data = radiologist_long) + 
  geom_bar(mapping = aes(x=reorder(radiologist, -n), y=Value),
           stat='identity', position ='dodge', fill="lightgray", color="black", alpha=.6, width=.5) + 
  facet_wrap(~Stat) + 
  coord_flip() +
  labs(title="Practice", y="Observed rate (in percentage)", x = "") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank()) 

model_recall = glm(recall ~ (. - cancer)^2, data=brca, family=binomial)
coef(model_recall)
