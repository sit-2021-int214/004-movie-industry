
#Library
library('dplyr','readr','ggplot2')

#Dataset
cs_book <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

#Explore the dataset
cs_book %>% glimpse()
cs_book %>% summary()

is.na(cs_book) %>% table()

#Learning function from Tidyverse

#1.
top_type <- cs_book %>% 
  select(Type, Rating) %>% 
  group_by(Type) %>% 
  summarise(mean_rating = mean(Rating)) %>% 
  arrange(desc(mean_rating))

#2.
price_paperback <- cs_book %>%
  filter(Type == 'Paperback') %>% 
  select(Price) %>% 
  summary()

price_paperback

#3.
book_totalPercent <- cs_book  %>%
  select(Type) %>%
  group_by(Type) %>%
  summarise(pct = n()) %>%
  mutate(pct = formattable::percent(pct/sum(pct)))
book_totalPercent

#4.
price_minmax <- cs_book %>%
  select(Type,Price) %>%
  group_by(Type) %>%
  summarise(minPrice = min(Price), maxPrice = max(Price))
price_minmax

#5.
topRating_price <- cs_book %>% 
  select(Book_title,Rating,Price) %>% 
  arrange(desc(Rating)) %>% 
  head(n=10)
topRating_price

#6.

book_pageless200 <- cs_book %>%
  filter(Number_Of_Pages < 200) %>% 
  summarize(num_books = n())
book_pageless200
