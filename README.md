# Capstone Project Davi-Giua
# The spreading of fear through social media: #fakenews and #coronavirus

## Introduction
This is the repository for the capstone project of Valentina Davì and Federica Giua, the final assignment for the Data Access II Module exam. We are from the DAPS&Co program, University of Milan new master's degree and we are learning how to scrape data from the web, and to conduct text and sentiment analyses. This project is also a way to show what we have learned in class and also to improve our skills.

## What the research is about
In the last weeks there has been a growing attention towards the phenomenon of coronavirus, and this has led to growing concerns among the population, sometimes becoming pure panic. In fact, this panic is also fueled by the fact that information about the virus is scarce, and not always well communicated. This also leaves space to the spreading of fake news, incorrect informations and, later on, fear among people. For this reason, we decided to focus our attention on the italian population toughts shared on the social platform Twitter. We collected the tweets that contain both the hashtags "coronavirus" and "fakenews" and all the other tweets that contain only the word "coronavirus". So, we have two different datasets on which we are doing the text and sentiment analyses. 

## Our goals
We are going to:

- collect a sample of the tweets written about these two hashtags. We are limiting the collection to tweets written in Italian, for homogeneity and interpretation reasons; 

- visualize the trend of these hasthags of both datasets, to see whether the public attention has changed during the days we collect the data, or if it's concentrated in some particular moments;

- visualize what are the words that are most used in these tweets, to try and develop some understanding of what the public thinks about the combination of these two phenomena;

- perform a sentiment analysis;

- compare the two datasets.

## Collecting data
First of all, we collected the first dataset of tweets containing #coronavirus and #fakenews from February the 3rd to Feb the 17th, then we scraped the second dataset of tweets containing only the word "coronavirus" from Feb the 2nd to Feb the 18th. Both the dataset include only italian tweets. 



## Packages used
rtweet, rbind, dplyr, tidytext, stringr, SnowballC, wordcloud, RColorBrewer, textmining


