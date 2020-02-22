#Let's try and do some text analysis on the tweets relating to coronavirus. 

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

opeNER_xml <- read_xml("it-sentiment_lexicon.lmf.xml")

entries <- xml_find_all(opeNER_xml, ".//LexicalEntry")

lemmas <- xml_find_all(opeNER_xml, ".//Lemma")

confidence <- xml_find_all(opeNER_xml, ".//Confidence")

sentiment <- xml_find_all(opeNER_xml, ".//Sentiment")

# Parse and put in a data frame

opeNER_df <- data.frame(
  
  id = xml_attr(entries, "id"),
  
  lemma = xml_attr(lemmas, "writtenForm"),
  
  partOfSpeech = xml_attr(entries, "partOfSpeech"),
  
  confidenceScore = as.numeric(xml_attr(confidence, "score")),
  
  method = xml_attr(confidence, "method"),
  
  polarity = as.character(xml_attr(sentiment, "polarity")),
  
  stringsAsFactors = F
  
)


# Fix a mistake

opeNER_df$polarity <- ifelse(opeNER_df$polarity == "nneutral", 
                             
                             "neutral", opeNER_df$polarity)



# Make quanteda dictionary: 

opeNER_dict <- quanteda::dictionary(with(opeNER_df, split(lemma, polarity)))



# Saving it locally: 

write.csv(opeNER_df, file = "opeNER_df.csv")

# Import it: 

opeNER <- rio::import("opeNER_df.csv")

head(opeNER)



# Words without polarity: 

table(opeNER$polarity, useNA = "always")

opeNER <- opeNER %>%
  
  filter(polarity != "")

# Depeche Mood: 

dpm <- rio::import("DepecheMood_italian_token_full.tsv")

head(dpm)

#Sentiment analysis

opeNERdict <- quanteda::dictionary(
  
  split(opeNER$lemma, opeNER$polarity)
  
)

lengths(opeNERdict)



# We need to create a dataset with the text (as character) and the section(filtered)

coronavirus_sentiment <-    italian_coronavirus_dataset%>%
  
  select(text) 

#Creating corpus with the quanteda package

corpus_tweets_coronavirus <- corpus(coronavirus_sentiment)

summary(corpus_tweets_coronavirus)

names(corpus_tweets_coronavirus)

# create the DFM for the sentiment analysis: 

coronavirus_dfm <- dfm(
  
  corpus_tweets_coronavirus,
  
  tolower = T,
  
  dictionary = opeNERdict
  
) 


head(coronavirus_dfm)

