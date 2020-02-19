#working on Coronavirus

#Merging datasets
italian_coronavirus_dataset <- rbind(italian_coronav_tweets, italian_coronav_tweets1_1802)
save(italian_coronavirus_dataset, file = "italian_coronavirus_fulldataset.RData")

#plotting the frequencies of the tweets
library(ggplot2)
