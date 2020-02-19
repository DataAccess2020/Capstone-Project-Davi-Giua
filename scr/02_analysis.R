#Analysis
#Merging datasets
both_keywords_dataset <- rbind(both_keywords, both_keywords_second)
save(both_keywords_dataset, file = "both_keywords_fulldataset.RData")
#Now I have 658 observation containing the keywords 'coronavirus' and 'fakenews' from Feb the 3rd to Feb 17

#Plotting tweets frequency over the past two weeks (from Feb 3rd to Feb 17th)
cv_fk_plot <- ts_plot(both_keywords_dataset, "1 hours") +
  ggplot2::theme_minimal() +
  scale_x_datetime(date_minor_breaks = "1 day", date_breaks = "1 day", date_labels = "%b %d")+
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = "Date", y = "Freq.",
    title = "Frequency of both #coronavirus and #fakenews Twitter statuses from Feb 3rd to Feb 17th 2020"
  )
cv_fk_plot

#saving the plot
ggsave(cv_fk_plot, filename = "BothKeywords_Freq_plot.png",
        width = 10, height = 4)

#Now I'm starting the text analysis
#removing http elements manually
both_keywords_dataset$stripped_text <- gsub("http\\S+", "", both_keywords_dataset$text)

#Then I use the unnest_tokens() function to convert to lowercase, remove punctuation, and add id for each tweet
both_keywords_dataset1 <- both_keywords_dataset %>% 
 select(stripped_text) %>% 
 unnest_tokens(word, stripped_text)

#I'm removing stopwords from my new list of words
unnecessary_words <- c("yt", "ps")

cleaned_tweets_bothkeywords <- both_keywords_dataset1 %>% 
  anti_join(get_stopwords(language = "it", source= "stopwords-iso")) %>%
  anti_join(get_stopwords(language = "it", source= "snowball")) %>%
  filter(!str_detect(word, '\\d+')) %>%
  filter(!str_detect(word, '[[:punct:]]')) %>% 
  filter(!str_detect(word, unnecessary_words)) 



#Finding the top 10 commonly used words among the tweets
Top_10_words_plot <- cleaned_tweets_bothkeywords %>% 
  count(word, sort = TRUE) %>% 
  top_n(10) %>% 
  mutate(word = reorder(word, n)) %>% 
  ggplot(aes(x=word, y=n)) +
  geom_col() +
  xlab (NULL) +
  coord_flip() +
  theme_classic() +
  labs(x = "Count",
       y = "Unique words",
       title = "Top 10 words found in #coronavirus #fakenews tweets")
       
#saving the horizontal barplot
ggsave(Top_10_words_plot, filename = "Top_10_words_plot.png",
        width = 10, height = 4)

#creating the Word Cloud

cleaned_tweets_bothkeywords %>% 
  count(word) %>% 
  with(wordcloud(word, n, max.words = 50, scale=c(2.2,0.70),(min.freq=5), colors=brewer.pal(8, "Dark2"),
                 random.color=T, random.order=F))




