#Analysis
#Merging datasets
both_keywords_dataset <- rbind(both_keywords, both_keywords_second)
save(both_keywords_dataset, file = "both_keywords_fulldataset.RData")
#Now I have 658 observation containing the keywords 'coronavirus' and 'fakenews' from Feb 2 to Feb 17

#Plotting tweets frequency over the past two weeks
ts_plot(both_keywords_dataset, "3 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = "date", y = "Freq.",
    title = "Frequency of both #coronavirus and #fakenews Twitter statuses from Feb 2nd to Feb 17th"
  )
