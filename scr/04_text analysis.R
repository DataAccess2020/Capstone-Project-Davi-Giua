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

