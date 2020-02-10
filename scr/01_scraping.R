#This is the file dedicated to the collection of data 

#trying to get tweets that contain both coronavirus and fakenews
tweets_collection <- search_tweets2(
  c("coronavirus , fakenews"), 
  n = 18000, 
  parse = TRUE,
  include_rts = FALSE,
  lang = "it"
)

save(tweets_collection, file = "tweets_try1.RData")

#trying to see what happens with the stream function 
streamingtweets <- stream_tweets("coronavirus, fakenews", timeout = 30, parse = TRUE, include_rts = FALSE,
                                 lang = "it")

keywords <- "coronavirus,fakenews"
streamtime <- 60*5
stream2 <- stream_tweets(q = keywords, 
                         timeout = streamtime, 
                         parse = TRUE) 
save(stream2, file = "streamedtweets.RData")

#new try with searchtweets
italian_tweets <- search_tweets2(
  c("coronavirus, fakenews"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it"
)

save(italian_tweets, file = "italian_tweets.RData")

english_tweets <- search_tweets2(
  c("coronavirus, fakenews"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "en"
)
# this retrieves 621 observations (as of 10/02)
save(english_tweets, file = "english_tweets.RData")

italian_coronav_tweets <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it"
)
#this retrieves 51462 observations 

save(italian_coronav_tweets, file = "italian_coronav_tweets.RData")

italian_hashtags_tweets <- search_tweets2(
  c("#coronavirus, #fakenews"), n = 500, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it"
)
save(italian_hashtags_tweets, file = "italian_hasthag_tweets.RData")
#this retrieves 235 observations

italian_tweets2 <- search_tweets2(
  c("coronavirus, fake, news"), n = 18000, 
  retryonratelimit = TRUE, 
  include_rts = FALSE, 
  lang = "it"
)
save(italian_tweets2, file = "italian_tweets2.RData")

#this retrieves 579 observations 