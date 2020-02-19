#working on Coronavirus

#Merging datasets
italian_coronavirus_dataset <- rbind(italian_coronav_tweets, italian_coronav_tweets1_1802)
save(italian_coronavirus_dataset, file = "italian_coronavirus_fulldataset.RData")

#plotting the frequencies of the tweets
library(ggplot2)


frequencies_plot <- ggplot(italian_coronavirus_dataset)) +                    
  geom_line(aes(y=italian_coronavirus_dataset$status_id), colour="blue")+
    scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 day")+
  xlab("02/02/20-18/02/20")+
  ylab("Number of italian tweets about coronavirus") +
  labs(title="Italian tweets about coronavirus")+
  theme_minimal()