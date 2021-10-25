# Library
library(dlyr)
library(readr)
library(ggplot2)

prog_book <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

glimpse(prog_book)

prog_book %>% 
  filter(Type == "Hardcover" & Rating >= 4) %>% 
  select(-Description,-Number_Of_Pages) %>%
  glimpse()

prog_book %>% 
  filter(Type == "Hardcover" & Rating >= 4) %>% 
  select(Book_title,Rating) %>% 
  arrange(desc(Rating))

## 3.1 Displays the top 10 books of the books with the highest rating.
prog_book %>%
  select(Rating,Book_title) %>%
  arrange(desc(Rating)) %>%
  top_n(10) 

## 3.2 Displays the price of books with the highest and lowest ratings.
prog_book %>%
  filter(Rating == max(prog_book$Rating)| Rating == min(prog_book$Rating)) %>%
  select(Rating,Book_title,Price)

## 3.3 Display How many types of books are there? And how many books are there in each type
prog_book %>% count(Type)

## 3.4 Displays titles and descriptions of books that are type as Boxed Set - Hardcover.
prog_book %>% 
  filter(Type == "Boxed Set - Hardcover") %>% 
  select(Book_title, Description) %>% glimpse()

##3.5 Displays the cheapest and most expensive prices of Paperback books.
prog_book %>%
  filter(Type == "Paperback") %>%
  summarise(most_expensive = max(Price),most_cheapest = min(Price))

##3.6 
prog_book %>% select(Book_title,Rating) %>%
  filter(Rating < mean(Rating)) %>%
  arrange(desc(Rating))
