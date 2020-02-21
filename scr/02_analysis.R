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

#Saving the new cleaned dataset
save(cleaned_tweets_bothkeywords, file = "cleaned_tweets_bothkeywords.RData")

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

#creating the bag of words

cleaned_tweets_bothkeywords %>% 
  count(word) %>% 
  with(wordcloud(word, n, max.words = 50, scale=c(2.2,0.70),(min.freq=5), colors=brewer.pal(8, "Dark2"),
                 random.color=T, random.order=F))

#Sentiment analysis

# Read file and find the nodes
opeNER_xml <- read_xml("./lexicon/it-sentiment_lexicon.lmf.xml")
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
opeNER_df$polarity <- ifelse(opeNER_df$polarity == "neutral", 
                             "neutral", opeNER_df$polarity)

# Make quanteda dictionary: 
opeNER_dict <- quanteda::dictionary(with(opeNER_df, split(lemma, polarity)))

# Saving it locally: 
write.csv(opeNER_df, file = "opeNER_df.csv")

# Import it: 
opeNER <- rio::import("./lexicon/opeNER_df.csv")
head(opeNER)

# Words without polarity: 
table(opeNER$polarity, useNA = "always")
opeNER <- opeNER %>%
  filter(polarity != "")

# Depeche Mood: 
dpm <- rio::import("./lexicon/DepecheMood_italian_token_full.tsv")
head(dpm)


#Sentiment analysis
opeNERdict <- quanteda::dictionary(
  split(opeNER$lemma, opeNER$polarity)
)
lengths(opeNERdict)

# Create the a dataset with the text (as character) and the section(filtered)
corona_sentiment <-  both_keywords_dataset %>% 
  select(text) 

#Creating corpus with quanteda package

corpus_tweets <- corpus(corona_sentiment)
summary(corpus_tweets)
names(corpus_tweets)

# create the DFM for the sentiment analysis: 
corona_dfm <- dfm(
  corpus_tweets,
  tolower = T,
  dictionary = opeNERdict
) 

head(corona_dfm)

# SENTIMENT GRAPH --> cercare su internet
#quanteda plot
 
  


## SENTIMENT WITH CONTINOUS CATEGORIES: analysis of the emotions
# Creating vectors for each categories of the DPM, each is weighted:
# saving the words from DPM in a vector: 
dpm_words <- dpm$V1

# Creating vectors for each categories of the DPM, each is weighted:
# 1. Indignato / Outrage: 
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

# creating a DFM: 
cv_fn_sentiment <- dfm(
  corpus_tweets,
  tolower = T,
  select = dpm_words
)
cv_fn_sentiment

# 1. Indignato
cv_fn_indignato <- cv_fn_sentiment %>%
  dfm_weight(scheme = "prop") %>%
  dfm_weight(weights = dpm_ind) %>%
  rowSums() %>%
  as.data.frame() %>%
  rename(Indignato = ".")
  

# 2. Preoccupato
cv_fn_preoccupato <- cv_fn_sentiment %>%
  dfm_weight(scheme = "prop") %>%
  dfm_weight(weights = dpm_pre) %>%
  rowSums() %>%
  as.data.frame() %>%
  rename(Preoccupato = ".")

# 3. Triste
cv_fn_triste <- cv_fn_sentiment %>%
  dfm_weight(scheme = "prop") %>%
  dfm_weight(weights = dpm_sad) %>%
  rowSums() %>%
  as.data.frame() %>%
  rename(Triste = ".")

# 4. Divertito
cv_fn_divertito <- cv_fn_sentiment %>%
  dfm_weight(scheme = "prop") %>%
  dfm_weight(weights = dpm_div) %>%
  rowSums() %>%
  as.data.frame() %>%
  rename(Divertito = ".")

# 5. Soddisfatto
cv_fn_soddisfatto <- cv_fn_sentiment %>%
  dfm_weight(scheme = "prop") %>%
  dfm_weight(weights = dpm_sat) %>%
  rowSums() %>%
  as.data.frame() %>%
  rename(Soddisfatto = ".")

# grouping emotion together: 
cv_fk_emotions <- bind_cols(
  cv_fn_indignato, cv_fn_preoccupato, cv_fn_triste, cv_fn_divertito, cv_fn_soddisfatto 
)
cv_fk_emotions

#Graph Emotions --> cercare su internet