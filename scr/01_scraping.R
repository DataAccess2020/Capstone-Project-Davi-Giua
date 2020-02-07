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

tweets_collection <- search_tweets2(
  "#coronavirus , #fakenews", 
  n = 100000, 
  retryonratelimit = TRUE, 
  parse = FALSE,
  include_rts = FALSE,
  timeout = 60 * 60 * 24 * 7,
  lang = "it"
)
