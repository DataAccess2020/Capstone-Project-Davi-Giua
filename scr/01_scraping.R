#This is the file dedicated to the collection of data 

#trying to get tweets that contain both coronavirus and fakenews
tweets_collection <- search_tweets2(
  c("coronavirus , fakenews"), 
  n = 50000, 
  retryonratelimit = TRUE, 
  parse = TRUE,
  include_rts = FALSE,
  lang = "it"
)

save(tweets_collection, file = "tweets_try1.RData")
