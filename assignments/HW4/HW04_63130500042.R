packages <- c("dplyr","readr","ggplot2")
lapply(packages, library, character.only = T)

dt <- read_csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

View(dt)
glimpse(dt)

print(colSums(is.na(dt)))
# no N/A value

dt %>% filter(Number_Of_Pages < 1500 & Price < 150) %>% 
    ggplot() +
    aes(x = Number_Of_Pages, y = Price) + 
    geom_point(size = 2) + 
    aes(color = Rating) + 
    facet_wrap("Type")

dt %>% filter(Number_Of_Pages < 1500 & Price < 150) %>% 
    ggplot() +
    aes(x = Number_Of_Pages, y = Price) + 
    geom_point() + 
    aes(color = Type)
