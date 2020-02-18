#Analysis
#Merging datasets
both_keywords_dataset <- rbind(both_keywords, both_keywords_second)
save(both_keywords_dataset, file = "both_keywords_fulldataset.RData")
 
