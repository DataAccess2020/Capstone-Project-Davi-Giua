#trying to get tweets that contain both coronavirus and fakenews
tweets_collection <- search_tweets2(
  c("#coronavirus , #fakenews"), 
  n = 18000, 
  parse = TRUE,
  include_rts = FALSE,
  lang = "it"
)

save(tweets_collection, file = "tweets_try1.RData")


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

#new tests
#1
coronavirus_tweets <- search_tweets2(q = "#coronavirus , #fakenews")
save(coronavirus_tweets, file = "coronavirus_tweets.RData")
#100 obs 



#2
coronav_tweets <- search_tweets(
  "#coronavirus, #fakenews", n = 18000, include_rts = FALSE
)
save(coronav_tweets, file = "coronav_tweets.RData")
#972 obs

#3
coronav_tweets1 <- search_tweets(
  "#coronavirus, #fakenews", n = 250000, retryonratelimit = TRUE,
  lang = "it",
  include_rts = FALSE
)
save(coronav_tweets1, file = "coronav_tweets1.RData")
#231 obs

#4
coronav_tweets2 <- search_tweets(
  "#coronavirus, #fakenews", n = 1000000, retryonratelimit = TRUE,
  lang = "it",
  include_rts = FALSE
)
save(coronav_tweets2, file = "coronav_tweets2.RData")
#231 obs

whatsthis <- search_tweets2(
  c("#coronavirus, #fakenews"),
  n = 50000,
  retryonratelimit = TRUE,
  include_rts = FALSE,
  lang = "it"
)

save(whatsthis, file = "whatsthis.RData")
#232 obs



#downloading the last piece of data on 18/02: 
max_id_coronav_tweets2 <- max(italian_coronav_tweets2$status_id)

italian_coronav_tweets3 <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it",
  since_id = max_id_coronav_tweets2
)

save(italian_coronav_tweets3, file = "italian_coronav_tweets3.RData")
#retrieved 14970 observations as of 18.02 at 10.58
#italian_coronav_tweets3 -> scraped on 18/02, collecting tweets from 14/02 at 10.34 to 18/02 at 10.59 

italian_coronav_tweets_second <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it",
  since_id = "1226838890838974464"
)
# new observations from .....[run it and find out or just delete the code and run the following one]
save(italian_coronav_tweets_second, file = "italian_coronav_tweets_second.RData")


min_id_prev_run <- min(italian_coronav_tweets$status_id)

italian_coronav_tweets2 <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it",
  since_id = min_id_prev_run
)

#found 39723 new results from Feb 5 to Feb 14 (run it again(sovrascrivilo che tanto queste date già ce le abbiamo))
#saving them: 
save(italian_coronav_tweets2, file ="italian_coronav_tweets2.RData")
