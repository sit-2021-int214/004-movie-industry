#Thanaphon Sukkasem 63130500048
#Library
library('dplyr','readr','ggplot2')

#Dataset
cs_book <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

# Explore the dataset
cs_book %>% glimpse()
cs_book %>% summary()

is.na(cs_book) %>% table()

# Learning function from Tidyverse & Transform data with dplyr and finding insight the data


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


# Visualization with GGplot2

pricePerType_boxplot <-  ggplot(cs_book, aes(x=Type, y=Price, fill=Type)) + geom_boxplot() 
pricePerType_boxplot

countbyPrice_areaplot <- ggplot(cs_book,aes(x=Price)) +  geom_area(stat = "bin",color = "#e76f51", fill="#ffd7ba", size = 1.5) + geom_vline(aes(xintercept=mean(Price)),color="#ee9b00", linetype="dashed", size=2, alpha = 0.6)
countbyPrice_areaplot