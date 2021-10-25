# Library
library(dlyr)
library(readr)
library(ggplot2)

prog_book <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

glimpse(prog_book)

prog_book %>% filter(Type == "Hardcover" , Rating >= 4)

prog_book %>% 
  filter(Type == "Hardcover" & Rating >= 4) %>% 
  select(Book_title,Rating) %>% 
  arrange(desc(Rating))

