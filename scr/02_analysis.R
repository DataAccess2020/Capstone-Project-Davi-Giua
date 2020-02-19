#Analysis
#Merging datasets
both_keywords_dataset <- rbind(both_keywords, both_keywords_second)
save(both_keywords_dataset, file = "both_keywords_fulldataset.RData")
#Now I have 658 observation containing the keywords 'coronavirus' and 'fakenews' from Feb the 3rd to Feb 17

#Plotting tweets frequency over the past two weeks (from Feb 3rd to Feb 17th)
ts_plot(both_keywords_dataset, "1 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = "date", y = "Freq.",
    title = "Frequency of both #coronavirus and #fakenews Twitter statuses from Feb 3rd to Feb 17th"
  )
