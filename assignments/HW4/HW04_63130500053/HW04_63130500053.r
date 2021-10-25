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

## 3.2 

