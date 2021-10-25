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

## 3.1 Show the top 10 books according to the book rating.
prog_book %>% select(Rating,Book_title,Price) %>% arrange(Rating) %>% head(3)

prog_book %>%
  select(Rating,Book_title,Type) %>%
  arrange(desc(Rating)) %>%
  top_n(5) 

