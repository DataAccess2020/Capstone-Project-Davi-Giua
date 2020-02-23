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

#Plot of the sentiment 

#The following plot shows the frequency of positive, neutral or negative words in the tweets

Sentiment_plot_coronavirus <- barplot(colSums(coronavirus_dfm),  col = c("gray20", "gray50", "gray80"),
                          
                          ylab = "Counts",
                          
                          main = "Frequency of positive, neutral or negative words in the tweets about coronavirus")

#Saving the plot 

save(Sentiment_plot_coronavirus, file = "Sentiment_plot_coronavirus.png")

#Emotion Analysis: sentiment with continuos categories

#Saving the words from DPM in a vector: 

dpm_words <- dpm$V1



#Generating vectors for each categories of the DPM, each is weighted:

# 1. Indignato / Outraged: 

dpm_ind <- dpm$INDIGNATO

names(dpm_ind) <- dpm_words



# 2. Preoccupato / Worried:

dpm_pre <- dpm$PREOCCUPATO

names(dpm_pre) <- dpm_words



# 3. Triste / Sad: 

dpm_sad <- dpm$TRISTE

names(dpm_sad) <- dpm_words



# 4. Divertito / Entertained: 

dpm_div <- dpm$DIVERTITO

names(dpm_div) <- dpm_words



# 5. Soddisfatto / Pleased: 

dpm_sat <- dpm$SODDISFATTO

names(dpm_sat) <- dpm_words


# Now creating a DFM: 

coronavirus_sentiment_dfm <- dfm(
  
  corpus_tweets_coronavirus,
  
  tolower = T,
  
  select = dpm_words
  
)

coronavirus_sentiment_dfm

#Represented emotions 
# 1. Indignato

coronav_indignato <- coronavirus_sentiment_dfm %>%
  
  dfm_weight(scheme = "prop") %>%
  
  dfm_weight(weights = dpm_ind) %>%
  
  rowSums() %>%
  
  as.data.frame() %>%
  
  rename(Indignato = ".")

# 2. Preoccupato

coronav_preoccupato <- coronavirus_sentiment_dfm %>%
  
  dfm_weight(scheme = "prop") %>%
  
  dfm_weight(weights = dpm_pre) %>%
  
  rowSums() %>%
  
  as.data.frame() %>%
  
  rename(Preoccupato = ".")

# 3. Triste

coronav_triste <- coronavirus_sentiment_dfm %>%
  
  dfm_weight(scheme = "prop") %>%
  
  dfm_weight(weights = dpm_sad) %>%
  
  rowSums() %>%
  
  as.data.frame() %>%
  
  rename(Triste = ".")

# 4. Divertito

coronav_divertito <- coronavirus_sentiment_dfm %>%
  
  dfm_weight(scheme = "prop") %>%
  
  dfm_weight(weights = dpm_div) %>%
  
  rowSums() %>%
  
  as.data.frame() %>%
  
  rename(Divertito = ".")



# 5. Soddisfatto

coronav_soddisfatto <- coronavirus_sentiment_dfm %>%
  
  dfm_weight(scheme = "prop") %>%
  
  dfm_weight(weights = dpm_sat) %>%
  
  rowSums() %>%
  
  as.data.frame() %>%
  
  rename(Soddisfatto = ".")

#Grouping emotions together: 

coronav_emotions <- bind_cols(
  
  coronav_indignato, coronav_preoccupato, coronav_triste, coronav_divertito, coronav_soddisfatto 
  
)

coronav_emotions

#Emotions barplot 

#Showing the amount of times each emotion is expressed in the tweets containing coronavirus


emotions_plot_coronav <- barplot(colSums(coronav_emotions),  col = c("red", "darkseagreen2", "steelblue", "darkorange", "darkslategray1"),
        
        ylab = "Counts",
        
        main = "Number of times each emotion is expressed in the tweets about coronavirus")

#Saving the plot
 
save(emotions_plot_coronav, file = "Emotions_plot_coronavirus.PDF")     
