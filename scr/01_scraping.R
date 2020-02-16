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
# this one retrieves 330 observations from 02-02 to 12-02 (ran at 11.20 of 11/02.)

both_keywords1 <- search_tweets(
  "#coronavirus OR coronavirus, #fakenews OR fakenews OR fake news", 
  n = 18000, 
  retryonratelimit = TRUE, 
  include_rts = FALSE, 
  lang = "it",
  since_id = "1227637473427283969"
)
save(both_keywords1, file = "both_keywords1_ita.RData")
#14 new observations from 12-02 to 13-02 h 10.28

#Trying to download the first dataset we didn't save "both_keywords_ita"

both_keywords_old <- search_tweets(
  "#coronavirus OR coronavirus, #fakenews OR fakenews OR fake news", 
  n = 18000, 
  retryonratelimit = TRUE, 
  include_rts = FALSE, 
  lang = "it",
  max_id = "1227637473427283969"
)
save(both_keywords_old, file = "both_keywords_ita_old.RData")









italian_coronav_tweets <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it"
)
 
save(italian_coronav_tweets, file = "italian_coronav_tweets.RData")
#this retrieves 49757 observations from 02-02 to 10-02.


italian_coronav_tweets1 <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it",
  since_id = "1226838889387757570"
)
#16115 new observations from 11-02 to 13-02 h 10.38
save(italian_coronav_tweets1, file = "italian_coronav_tweets1.RData")


#trying to create a loop to repeate the download of data: 

min_id_prev_run <- min(italian_coronav_tweets$status_id)

italian_coronav_tweets2 <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it",
  since_id = min_id_prev_run
)

#found 39723 new results
#saving them: 
save(italian_coronav_tweets2, file ="italian_coronav_tweets2.RData")
