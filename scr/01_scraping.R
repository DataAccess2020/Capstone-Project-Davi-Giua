#This is the script dedicated to the collection of data 

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

# this one retrieves 544 observations from 03 Feb to 11 Feb 2020
both_keywords_second <- search_tweets(
  "#coronavirus OR coronavirus, #fakenews OR fakenews OR fake news", 
  n = 50000, 
  retryonratelimit = TRUE, 
  include_rts = FALSE, 
  lang = "it",
  since_id = "1227153622074580993"
)
save(both_keywords_second, file = "both_keywords_second.RData")
#this dataset gets back 114 observations from 11 Feb to 17 Feb 2020













#Downloading a new dataset containing only the word "coronavirus"
#that will be compared to the first dataset with both key words

italian_coronav_tweets <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it"
)
 
save(italian_coronav_tweets, file = "italian_coronav_tweets.RData")
#this retrieves 49757 observations from Feb 02 to Feb 10.


italian_coronav_tweets_second <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it",
  since_id = "1226838890838974464"
)
# new observations from .....[run it and find out or just delete the code and run the following one]
save(italian_coronav_tweets_second, file = "italian_coronav_tweets_second.RData")


#trying to create a loop to repeate the download of data: 

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
