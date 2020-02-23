#setting up 
library(rtweet)
library(tidyverse)
library(tidytext)
library(wordcloud)
library(quanteda)
library(xml2)
library(timeSeries)









globale <- ggplot(visual0220, aes(visual0220$Giorno)) +                    
  geom_line(aes(y=visual0220$Sessioni), colour="blue")+
  geom_line(aes(y=visual0220$Visualizzazioni), colour="darkorange")+ 
  scale_x_datetime(date_minor_breaks = "1 day", date_breaks = "1 month")+
  xlab("06/02/19-08/02/20")+
  ylab("Numero di visualizzazioni") +
  labs(title="Numero di visualizzazioni YouTube (arancio) e sito (blu)")+
  theme_minimal()


