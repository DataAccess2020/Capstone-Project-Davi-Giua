#This is the file dedicated to the collection of data 

#We want to download tweets that contain both the word "coronavirus" and "fake news", that could be 
#written in different ways: 
both_keywords <- search_tweets(
  "#coronavirus OR coronavirus, #fakenews OR fakenews OR fake news", 
  n = 18000, 
  retryonratelimit = TRUE, 
  include_rts = FALSE, 
  lang = "it"
)
save(both_keywords, file = "both_keywords_ita.RData")
# this one retrieves 544 observations from 02-02 to 11-02 (ran at 11.20 of 11/02.)


italian_coronav_tweets <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it"
)
#this retrieves 49757 observations. 

save(italian_coronav_tweets, file = "italian_coronav_tweets.RData")

italian_coronav_tweets1 <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it",
  since_id = "1226838889387757570"
)
#16115 new observations from 11-02 to 13-02 h 10.38
save(italian_coronav_tweets1, file = "italian_coronav_tweets1.RData")




