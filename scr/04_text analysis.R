#Let's try and do some text analysis on the tweets relating to coronavirus. 

save(italian_coronavirus_dataset, file = "italian_coroonavirus_dataset_json.json")

install.packages("quanteda")

# First, removing the http elements

italian_coronavirus_dataset$stripped_text <- gsub("http\\S+", "", italian_coronavirus_dataset$text)


#Then bring to lowercase, erase punctuation, and add id for each tweet

italian_coronavirus_dataset_new <- italian_coronavirus_dataset %>% 
  
  select(stripped_text) %>% 
  
  unnest_tokens(word, stripped_text)


#Remove stopwords 

unnecessary_words <- c("yt", "ps")


cleaned_coronavirus <- italian_coronavirus_dataset_new %>% 
  
  anti_join(get_stopwords(language = "it", source= "stopwords-iso")) %>%
  
  anti_join(get_stopwords(language = "it", source= "snowball")) %>%
  
  filter(!str_detect(word, '\\d+')) %>%
  
  filter(!str_detect(word, '[[:punct:]]')) %>% 
  
  filter(!str_detect(word, unnecessary_words)) 

#Now saving the cleaned dataset 

save(cleaned_coronavirus, file = "cleaned_coronavirus.RData")

# Now we want to visualize the ten most used words 


Top_10_words_plot_coronavirus <- cleaned_coronavirus %>% 
  
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
       
       title = "10 most used words found in tweets relating to Coronavirus")
Top_10_words_plot

#saving the plot

ggsave(Top_10_words_plot_coronavirus, filename = "Top_10_words_plot_coronavirus.png",
       
       width = 10, height = 4)

# Visualizing a wordcloud 

wordcloud_coronavirus <- cleaned_coronavirus %>% 
  
  count(word) %>% 
  
  with(wordcloud(word, n, max.words = 50, scale = c(2.2,0.70),(min.freq=5), colors=brewer.pal(8, "Dark2"),
                 
                 random.color=T, random.order=F))


#Sentiment analysis
VUSentimentLexicon/IT-lexicon/it-sentiment_lexicon.lmf

# Read file and find the nodes

opeNER_xml <- read_xml("./lexicon/it-sentiment_lexicon.lmf.xml")

entries <- xml_find_all(opeNER_xml, ".//LexicalEntry")

lemmas <- xml_find_all(opeNER_xml, ".//Lemma")

confidence <- xml_find_all(opeNER_xml, ".//Confidence")

sentiment <- xml_find_all(opeNER_xml, ".//Sentiment")