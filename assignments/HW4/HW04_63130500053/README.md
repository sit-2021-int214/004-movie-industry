# R-Assignment 4

**Created by Name-Surname (ID: 63130500053)**

Choose Dataset:
- Top 270 Computer Science / Programing Books (Data from Thomas Konstantin, [Kaggle](https://www.kaggle.com/thomaskonstantin/top-270-rated-computer-science-programing-books)) >> [Using CSV](https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv)


### Outlines

1. Explore the dataset
2. Learning function from Tidyverse
3. Transform data with dplyr and finding insight the data
4. Visualization with GGplot2

## Part 1: Explore the dataset

```{R}
library(dplyr)
library(readr)
library(ggplot2)
```

### Import Dataset
```{R}
prog_book <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")
```
### Explore Dataset
```{R}
glimpse(prog_book)
```
#### Result
```
Rows: 271
Columns: 7
$ Rating          <dbl> 4.17, 4.01, 3.33, 3.97, 4.06, 3.84, 4.09, 4.15, 3.87, 4.62, 4.03, 3.78, 3.~
$ Reviews         <chr> "3,829", "1,406", "0", "1,658", "1,325", "117", "5,938", "1,817", "2,093",~
$ Book_title      <chr> "The Elements of Style", "The Information: A History, a Theory, a Flood", ~
$ Description     <chr> "This style manual offers practical advice on improving writing skills. Th~
$ Number_Of_Pages <int> 105, 527, 50, 393, 305, 288, 256, 368, 259, 128, 352, 352, 200, 328, 240, ~
$ Type            <chr> "Hardcover", "Hardcover", "Kindle Edition", "Hardcover", "Kindle Edition",~
$ Price           <dbl> 9.323529, 11.000000, 11.267647, 12.873529, 13.164706, 14.188235, 14.232353~
```

In this dataset has 271 Rows and 7 Columns
- Rating : เรียงลำดับ ผู้ใช้ให้คะแนนหนังสือ คะแนนเรตติ้งอยู่ระหว่าง 0 ถึง 5
- Reviews : จำนวนบทวิจารณ์ที่พบในหนังสือเล่มนี้
- Book_title : ชื่อหนังสือ
- Description : คำอธิบายสั้น ๆ ของหนังสือ
- Number_Of_Pages : จำนวนหน้าในเล่ม
- Type : ประเภทของหนังสือ ความหมาย คือ หนังสือปกแข็ง หรือ ebook หรือ Kindle book เป็นต้น
- Price : ราคาเฉลี่ยของหนังสือในสกุลเงิน USD โดยที่ค่าเฉลี่ยคำนวณจากแหล่งที่มาของเว็บทั้ง 5 แห่ง

## Part 2: Learning function from Tidyverse

- Function `filter()` from package [dplyr](https://dplyr.tidyverse.org/reference/filter.html). It using to subset a data frame, retaining all rows that satisfy your conditions.
- Function `select()` from package [dplyr](https://dplyr.tidyverse.org/articles/dplyr.html#select-columns-with-select). It using for select columns

#### Filter hardcover prog_book with a score greater than 4 without Description and Number_Of_Pages columns.
#### Code
```{R}
prog_book %>% 
  filter(Type == "Hardcover" & Rating >= 4) %>% 
  select(-Description,-Number_Of_Pages) %>%
  glimpse()
```
#### Result
```
Rows: 62
Columns: 5
$ Rating     <dbl> 4.17, 4.01, 4.09, 4.15, 4.03, 4.10, 4.13, 4.09, 4.27, 4.08, 4.06, 4.00, 4.28, 4.05, 4.54, 4.40, 4.02~
$ Reviews    <chr> "3,829", "1,406", "5,938", "1,817", "160", "2,092", "86", "4", "2,629", "9", "302", "50", "3", "2", ~
$ Book_title <chr> "The Elements of Style", "The Information: A History, a Theory, a Flood", "Start with Why: How Great~
$ Type       <chr> "Hardcover", "Hardcover", "Hardcover", "Hardcover", "Hardcover", "Hardcover", "Hardcover", "Hardcove~
$ Price      <dbl> 9.323529, 11.000000, 14.232353, 14.364706, 15.229412, 17.229412, 21.814706, 23.235294, 24.258824, 25~
```

## Part 3: Transform data with dplyr and finding insight the data

### 3.1 Displays the top 10 books of the books with the highest rating.

#### Code
```{R}
prog_book %>%
  select(Rating,Book_title) %>%
  arrange(desc(Rating)) %>%
  top_n(10) 
```

#### Result
```
Selecting by Book_title
   Rating                                                                             Book_title
1    5.00                                                                Your First App: Node.js
2    4.62                        ZX Spectrum Games Code Club: Twenty fun games to code and learn
3    4.27                                                                        Unity in Action
4    4.15                       What Is Life? with Mind and Matter and Autobiographical Sketches
5    4.14                                                   Working Effectively with Legacy Code
6    3.94                                             xUnit Test Patterns: Refactoring Test Code
7    3.88                   Think Like a Programmer: An Introduction to Creative Problem Solving
8    3.87 Weapons of Math Destruction: How Big Data Increases Inequality and Threatens Democracy
9    3.79                  UML Distilled: A Brief Guide to the Standard Object Modeling Language
10   3.37                                                         Unity Virtual Reality Projects
```
แสดงหนังสือ 10 อันดับแรกของหนังสือที่มีคะแนน Rating สูงสุด โดยแสคงเเค่ Rating เเละ Book_title

### 3.2 Displays the price of books with the highest and lowest ratings.

#### Code
```{R}
prog_book %>%
  filter(Rating == max(prog_book$Rating)| Rating == min(prog_book$Rating)) %>%
  select(Rating,Book_title,Price)
```

#### Result
```
  Rating                                                                                Book_title    Price
1      5                                                                   Your First App: Node.js 25.85588
2      3                                       Advanced Game Programming: A Gamedev.Net Collection 59.08235
3      3 Cross-Platform Game Programming (Game Development) (Charles River Media Game Development) 60.39118
4      3                                   Lambda-Calculus, Combinators and Functional Programming 61.16765
```
แสดงราคาของหนังสือที่มีคะแนน Rating สูงสุดเเละต่ำสุด โดยเเสดงเเค่ Rating, Book_title เเละ Price

### 3.3 Displays How many types of books are there? And how many books are there in each type

#### Code
```{R}
prog_book %>% count(Type)
```

#### Result
```
                   Type   n
1 Boxed Set - Hardcover   1
2                 ebook   7
3             Hardcover  95
4        Kindle Edition  10
5             Paperback 156
6       Unknown Binding   2
```
มีประเภทของหนังสืออยู่ทั้งหมด 6 ประเภท
- Boxed Set - Hardcover มี 1 เล่ม
- ebook มี 7 เล่ม
- Hardcover มี 95 เล่ม
- Kindle Edition มี 10 เล่ม
- Paperback มี 156 เล่ม
- Unknown Binding มี 2 เล่ม

### 3.4 Displays titles and descriptions of books that are type as Boxed Set - Hardcover.

#### Code
```{R}
prog_book %>% 
  filter(Type == "Boxed Set - Hardcover") %>% 
  select(Book_title, Description) %>% glimpse()
```

#### Result
```
Rows: 1
Columns: 2
$ Book_title  <chr> "The Art of Computer Programming, Volumes 1-3 Boxed Set"
$ Description <chr> "Knuth's classic work has been widely acclaimed as one of the most influential works in the field of c~
```
- มีหนังสือประเภท Boxed Set - Hardcover อยู่ 1 เล่ม
- หนังสือชื่อ "The Art of Computer Programming, Volumes 1-3 Boxed Set"

### 3.5 Displays the cheapest and most expensive prices of Paperback books.

#### Code
```{R}
prog_book %>%
  filter(Type == "Paperback") %>%
  summarise(most_expensive = max(Price),most_cheapest = min(Price))
```

#### Result
```
  most_expensive most_cheapest
1       212.0971      14.18824
```
แสดงราคาที่ถูกที่สุดเเละเเพงที่สุดของหนังสือประเภท Paperback 

### 3.6 Displays books type Kindle Edition  that are rating above average by descending order

#### Code
```{R}
prog_book %>% summarise(mean(Rating))

prog_book %>% select(Book_title,Rating,Type) %>%
  filter(Rating > mean(Rating) & Type == "Kindle Edition") %>%
  arrange(desc(Rating))
```

#### Result
```
  mean(Rating)
1     4.067417
```
ค่าเฉลี่ยคะเเนน Rating ของหนังสือประเภท Kindle Edition คือ 4.067417
```
                                                                   Book_title Rating           Type
1                                The Principles of Object-Oriented JavaScript   4.35 Kindle Edition
2                    Simulation of Digital Communication Systems using Matlab   4.34 Kindle Edition
3                                                Make Your Own Neural Network   4.34 Kindle Edition
4 Make Your Own Neural Network: An In-depth Visual Introduction For Beginners   4.15 Kindle Edition
```
หนังสือที่มีคะแนน Rating มากกว่าค่าเฉลี่ยมี 4 เล่ม
- The Principles of Object-Oriented JavaScript มี 4.35 คะแนน
- Simulation of Digital Communication Systems using Matlab มี 4.34 คะแนน
- Make Your Own Neural Network มี 4.34 คะแนน
- Make Your Own Neural Network: An In-depth Visual Introduction For Beginners มี 4.15 คะแนน