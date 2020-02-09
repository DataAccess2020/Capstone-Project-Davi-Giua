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
  c("coronavirus, fakenews"), n = 1800, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it"
)

save(italian_tweets, file = "italian_tweets.RData")

