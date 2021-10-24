install.packages("tidyverse")
library(dplyr , readr , ggplot2)
library(tidyverse)

CSBooks <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

View(CSBooks)
str(CSBooks)

#Part A

# 1. Explore the dataset that you have select.

glimpse(CSBooks)

str(CSBooks)

# 2. Transform data with dplyr and finding insight the data at least 6 issues. Show your code, result and summary in form of sentence/paragraphs.

#2.1 All book type and average price each one of them.  
avg_price_each <- CSBooks %>% group_by(Type) %>% select(Price) %>% summarise(Price = mean(Price , na.rm = T))

avg_price_each

# 2.2 The highest rating of Hardcover book type and title.

mr_hardcover <- CSBooks %>% select(Book_title, Type , Rating) %>% filter(Type =="Hardcover") %>% filter(Rating == max(Rating)) 

cat("The Hardcover book type that has highest rating is" , mr_hardcover$Book_title,"and rating is",mr_hardcover$Rating)


# 2.3 The higest rating of book each type.
CSBooks %>% select(Book_title, Type , Rating) %>% group_by(Type) %>% summarise(Rating = max(Rating))


# 2.4 Type of book that have average number of pages above overall average.

overall_avg <- CSBooks %>% summarise(Overall_avg = mean(Number_Of_Pages , na.rm = T))
overall_avg
  
avg_page <- CSBooks %>% select(Type ,Number_Of_Pages) %>% group_by(Type) %>% summarise(avg_pages = mean(Number_Of_Pages , na.rm = T)) %>%
   filter(avg_pages > overall_avg$Overall_avg)

cat("Type of book that have average number of pages above overall average are" , avg_page$Type)

 
# 2.5 non- Boxed set book with highest number of pages.

CSBooks %>% filter(Type != "Boxed Set") %>% select(Book_title , Type , Number_Of_Pages , Price) %>%
        filter(Number_Of_Pages == max(Number_Of_Pages))

# 2.6 2 Book with the price nearest left side and right side of the median price.
#find median price
median <- CSBooks %>% summarise(median = median(Price , na.rm =T))
median
left_side <- CSBooks %>% select(Price)%>% filter(Price < median$median)
right_side <- CSBooks %>% select(Price)%>% filter(Price > median$median)
right_side
nearest_ls <- CSBooks %>% select(Book_title , Price) %>% filter(Price == max(left_side$Price))
nearest_rs <- CSBooks %>% select(Book_title , Price) %>% filter(Price == max(right_side$Price))     

cat("Book title with the nearest price to median from left side is:" , nearest_ls$Book_title ,"and right side is:" , nearest_rs$Book_title)



# ggplot2

# show scatter plot of price and number of pages.
Scatter1 <- CSBooks %>% filter(Number_Of_Pages < 1500) %>% 
  ggplot(aes(x = Number_Of_Pages , y = Price)) +
  geom_point(aes(color = Type)) + xlab("Number of pages") + ggtitle("Correlation of Number of pages and Price")


# show bar plot of average price each type of book.

Barplot <- ggplot(avg_price_each , aes(x = Type,y = Price)) + geom_bar(stat = 'identity') + ggtitle("Average price each type")
Barplot

