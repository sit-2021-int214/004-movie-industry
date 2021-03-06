# R Assignment 4
Created By Thanakrit Paithun (ID: 63130500046)

Choose Dataset: Top 270 Computer Science / Programing Books (Data from Thomas Konstantin, [Kaggle](https://www.kaggle.com/thomaskonstantin/top-270-rated-computer-science-programing-books)) >> [Using CSV](https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv)


## Outlines

1.Explore the dataset

2.Learning function from Tidyverse

3.Transform data with dplyr and finding insight the data

4.Visualization with GGplot2


## Part 0: Import library and dataset.

```R
library(dplyr , readr , ggplot2)
library(tidyverse)

CSBooks <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

View(CSBooks)
str(CSBooks)
```

## Part 1: Explore the dataset

```R
glimpse(CSBooks)

str(CSBooks)
```
  In this dataset has 7 columns are Rating, Reviews, Book_title, Description, Number_of_pages, Type and Price and there are 271 rows.
  
## Part 2: Learning function from Tidyverse
- Function `summarise()` is typically used on grouped data created by `group_by()`from package [dplyr](https://dplyr.tidyverse.org/articles/dplyr.html#select-columns-with-select)). The output will have one row for each group.

```R
  starwars %>% group_by(gender) %>% summarise(avg_height = mean(height, na.rm =T))

```
## Part 3: Transform data with dplyr and finding insight the data

  3.1) All book type and average price each one of them.  
```R
avg_price_each <- CSBooks %>% group_by(Type) %>% select(Price) %>% summarise(Price = mean(Price , na.rm = T))

avg_price_each

```
Result:
```R
  Type                  Price
  <chr>                 <dbl>
1 Boxed Set - Hardcover 220. 
2 ebook                  51.4
3 Hardcover              70.1
4 Kindle Edition         32.4
5 Paperback              45.8
6 Unknown Binding        37.2
```
  3.2) The highest rating of Hardcover book type and title.
```R
mr_hardcover <- CSBooks %>% select(Book_title, Type , Rating) %>% filter(Type =="Hardcover") %>% filter(Rating == max(Rating)) 

cat("The Hardcover book type that has highest rating is" , mr_hardcover$Book_title,"and rating is",mr_hardcover$Rating)
```
Result:
```R
The Hardcover book type that has highest rating is The Art of Computer Programming, Volumes 1-4a Boxed Set and rating is 4.77
```
  3.3) The higest rating of book each type.
```R
CSBooks %>% select(Book_title, Type , Rating) %>% group_by(Type) %>% summarise(Rating = max(Rating))
```
Result:
```R
  Type                  Rating
  <chr>                  <dbl>
1 Boxed Set - Hardcover   4.49
2 ebook                   5   
3 Hardcover               4.77
4 Kindle Edition          4.35
5 Paperback               4.72
6 Unknown Binding         4.11
```
  3.4) Type of book that have average number of pages above overall average.
```R
overall_avg <- CSBooks %>% summarise(Overall_avg = mean(Number_Of_Pages , na.rm = T))
overall_avg
  
avg_page <- CSBooks %>% select(Type ,Number_Of_Pages) %>% group_by(Type) %>% 
            summarise(avg_pages = mean(Number_Of_Pages , na.rm = T)) %>%
            filter(avg_pages > overall_avg$Overall_avg)

cat("Type of book that have average number of pages above overall average are" , avg_page$Type)
```
Result:
```R
Type                  avg_pages
  <chr>                     <dbl>
1 Boxed Set - Hardcover      896 
2 Hardcover                  614.
```
  3.5) non- Boxed set book with highest number of pages.
```R
CSBooks %>% filter(Type != "Boxed Set") %>% select(Book_title , Type , Number_Of_Pages , Price) %>%
        filter(Number_Of_Pages == max(Number_Of_Pages))
```
Result:
```R
Book_title      Type Number_Of_Pages    Price
1 The Art of Computer Programming, Volumes 1-4a Boxed Set Hardcover            3168 220.3853
```
  3.6) 2 Book with the price nearest left side and right side of the median price.
```R
#find median price
median <- CSBooks %>% summarise(median = median(Price , na.rm =T))

left_side <- CSBooks %>% select(Price)%>% filter(Price < median$median)
right_side <- CSBooks %>% select(Price)%>% filter(Price > median$median)

nearest_ls <- CSBooks %>% select(Book_title , Price) %>% filter(Price == max(left_side$Price))
nearest_rs <- CSBooks %>% select(Book_title , Price) %>% filter(Price == max(right_side$Price))     
cat("Book title with the nearest price to median from left side is:" , 
    nearest_ls$Book_title ,"and right side is:" , nearest_rs$Book_title)

```
Result:
```R
Book title with the nearest price to median from left side is: Programming Ruby: The Pragmatic Programmers' Guide 
and right side is: A Discipline for Software Engineering
```
## Part 4: Visualization with GGplot2

  1).show scatter plot of price and number of pages.

```R
Scatter1 <- CSBooks %>% filter(Number_Of_Pages < 1500) %>% 
            ggplot(aes(x = Number_Of_Pages , y = Price)) +
            geom_point(aes(color = Type)) + xlab("Number of pages") + ggtitle("Correlation of Number of pages and Price")
            
Scatter1+geom_smooth(method="lm")

```
Result:




![scatter1](./images/scatterplot1.png)



  2).show barplot of average price each type of book.
  
```R
Barplot <- ggplot(avg_price_each , aes(x = Type,y = Price)) + 
           geom_bar(stat = 'identity', fill = "steelblue") + ggtitle("Average price each type")

```
Result:




![barplot1](./images/barplot.png)

