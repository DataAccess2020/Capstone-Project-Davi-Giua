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
<<<<<<< HEAD

# this one retrieves 544 observations from 03 Feb to 11 Feb 2020
=======
# this one retrieves 544 observations from 03 Feb to 11 Feb 2020

>>>>>>> 9883922e8262a6739a5898b87b08a4a0a6106601
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

<<<<<<< HEAD












#Downloading a new dataset containing only the word "coronavirus"
#that will be compared to the first dataset with both key words
=======
# We notice that there isn't the amount of material that we thought we could find. 
# So we download a new dataset, containing italian tweets with the word "coronavirus" in them. 
#That will be compared to the first dataset with both keywords
>>>>>>> 9883922e8262a6739a5898b87b08a4a0a6106601

italian_coronav_tweets <- search_tweets2(
  c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it"
)
 
save(italian_coronav_tweets, file = "italian_coronav_tweets.RData")
#this retrieves 49757 observations from Feb 02 to Feb 10.

<<<<<<< HEAD

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
=======
#Now we want to repeat the download after some days, to expand our time series. 
# We do that by selecting the most recent tweet in the previous dataset, and asking R to retrieve
#only tweets that were written in the following days.

max_id_coronav_tweets <- max(italian_coronav_tweets$status_id)

italian_coronav_tweets1_1802 <- search_tweets2(
   c("coronavirus"), n = 50000, 
  retryonratelimit = TRUE,
  include_rts = FALSE, 
  lang = "it",
   since_id = max_id_coronav_tweets
)

#Then we save the new dataset. 
save(italian_coronav_tweets1_1802, file = "italian_coronav_tweets1_1802.RData")
#retrieved 35727 observations from 10/02 at 10.34 to 18/02 at 10.49

>>>>>>> 9883922e8262a6739a5898b87b08a4a0a6106601
