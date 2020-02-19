#working on Coronavirus

#Merging datasets
italian_coronavirus_dataset <- rbind(italian_coronav_tweets, italian_coronav_tweets1_1802)
save(italian_coronavirus_dataset, file = "italian_coronavirus_fulldataset.RData")

#plotting the frequencies of the tweets
library(ggplot2)

frequency_plot <- ts_plot(italian_coronavirus_dataset, "1 hour") +
  ggplot2::theme_minimal() +
  scale_x_datetime(date_minor_breaks = "1 day", date_breaks = "1 day", date_labels = "%b %d")+
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = "Date", y = "Frequency",
    title = "Frequency of italian tweets relating to coronavirus from Feb 2nd to Feb 18th"
  )

ggsave(frequency_plot, filename = "Frequency plot for coronavirus.pdf",
       device = cairo_pdf, width = 10, height = 4)