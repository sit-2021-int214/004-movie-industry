# R-Assignment 4

**Created by Thanaphon Sukkasem (ID: 63130500048)**

Choose Dataset:
- Top 270 Computer Science / Programing Books (Data from Thomas Konstantin, [Kaggle](https://www.kaggle.com/thomaskonstantin/top-270-rated-computer-science-programing-books)) >> [Using CSV](https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv)


### Outlines

1. [Explore the dataset](#part-1:-explore-the-dataset)
2. [Learning function from Tidyverse](#part-2-&-part-3-:-learning-function-from-tidyverse-&-Transform-data-with-dplyr-and-finding-insight-the-data)
3. [Transform data with dplyr and finding insight the data](#part-2-&-part-3-:-learning-function-from-tidyverse-&-transform-data-with-dplyr-and-finding-insight-the-data)
4. [Visualization with GGplot2](#part-4:-visualization-with-ggplot2)

## Part 1: Explore the dataset

```
# Library
library(dplyr)
library(readr)
library(ggplot2)

# Dataset
cs_book <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")
```

### ตรวจสอบข้อมูลเบื้องต้น

**1. คำสั่ง `glimpse()`**
```
cs_book %>% glimpse()
```
ได้ผลลัพธ์
```
Rows: 271
Columns: 7
$ Rating          <dbl> 4.17, 4.01, 3.33, 3.97, 4.06, 3.84, 4.09, 4.15, 3.87, 4.62, 4.03, 3.78, 3.73, 3.87, 3.87, 3.95, 3.85, 3.94, 3.75, 4.10,~
$ Reviews         <chr> "3,829", "1,406", "0", "1,658", "1,325", "117", "5,938", "1,817", "2,093", "0", "160", "481", "33", "1,255", "593", "41~
$ Book_title      <chr> "The Elements of Style", "The Information: A History, a Theory, a Flood", "Responsive Web Design Overview For Beginners~
$ Description     <chr> "This style manual offers practical advice on improving writing skills. Throughout, the emphasis is on promoting a plai~
$ Number_Of_Pages <int> 105, 527, 50, 393, 305, 288, 256, 368, 259, 128, 352, 352, 200, 328, 240, 288, 392, 304, 336, 542, 192, 242, 224, 412, ~
$ Type            <chr> "Hardcover", "Hardcover", "Kindle Edition", "Hardcover", "Kindle Edition", "Paperback", "Hardcover", "Hardcover", "Hard~
$ Price           <dbl> 9.323529, 11.000000, 11.267647, 12.873529, 13.164706, 14.188235, 14.232353, 14.364706, 14.502941, 14.641176, 15.229412,~

```
**2. คำสั่ง `summary()`**
```
cs_book %>% summary()
```
ได้ผลลัพธ์
```
     Rating        Reviews           Book_title       
 Min.   :3.000   Length:271         Length:271        
 1st Qu.:3.915   Class :character   Class :character  
 Median :4.100   Mode  :character   Mode  :character  
 Mean   :4.067                                        
 3rd Qu.:4.250                                        
 Max.   :5.000                                        
 Description        Number_Of_Pages      Type          
 Length:271         Min.   :  50.0   Length:271        
 Class :character   1st Qu.: 289.0   Class :character  
 Mode  :character   Median : 384.0   Mode  :character  
                    Mean   : 475.1                     
                    3rd Qu.: 572.5                     
                    Max.   :3168.0                     
     Price        
 Min.   :  9.324  
 1st Qu.: 30.751  
 Median : 46.318  
 Mean   : 54.542  
 3rd Qu.: 67.854  
 Max.   :235.650  
```

### **จากการสำรวจข้อมูลเรียบร้อยแล้วมีข้อมูลทั้งหมด** 

- จำนวนแถว 271 แถว
- จำนวนคอลัมน์ 7 คอลัมน์

ในแต่ละคอลัมน์ประกอบไปด้วยข้อมูล
|      Name       | Datatype| Description              |
|-----------------|---------|--------------------------|
| Rating          |double   |คะแนนที่ผู้อ่านประเมินให้กับหนังสือ|
| Reviews         |character|จำนวนคนรีวิวหนังสือ           |
| Book_title      |character|ชื่อของหนังสือ                |
| Description     |character|รายละเอียดของหนังสือ         |
| Number_Of_Pages |integer  |จำนวนหน้าของหนังสือ         |
| Type            |character|ประเภทของหนังสือ            |
| Price           |double   |ราคาของหนังสือ              |

**ตรวจสอบข้อมูลว่ามีช่องว่างหรือไม่**

```
is.na(cs_book) %>% table()
```
ได้ผลลัพธ์
```
FALSE 
 1897 
```











## Part 2 & Part 3 : Learning function from Tidyverse & Transform data with dplyr and finding insight the data

---

### **1. จัดเรียงประเภทของหนังสือตามคะแนนเฉลี่ยที่ได้รับโดยเรียงจากคะแนนสูงไปต่ำ**

```
top_type <- cs_book %>% 
  select(Type, Rating) %>% 
  group_by(Type) %>% 
  summarise(mean_rating = mean(Rating)) %>% 
  arrange(desc(mean_rating))

top_type
```
**ได้ผลลัพธ์**
```
# A tibble: 6 x 2
  Type                  mean_rating
  <chr>                       <dbl>
1 Boxed Set - Hardcover        4.49
2 ebook                        4.29
3 Paperback                    4.06
4 Hardcover                    4.06
5 Kindle Edition               4.01
6 Unknown Binding              3.99
```
>### Function from **Tidyverse** ในข้อนี้
>
>select() : Select variables by name
>
>summarise() : Reduce multiple values down to a single value
>
>arrange() : Arrange rows by variables

---
### **2. ราคาของหนังสือประเภท paperback ในแต่ละ percentiles**

```
price_paperback <- cs_book %>%
  filter(Type == 'Paperback') %>% 
  select(Price) %>% 
  summary()

price_paperback
```
**ได้ผลลัพธ์**
```
     Price       
 Min.   : 14.19  
 1st Qu.: 30.33  
 Median : 43.34  
 Mean   : 45.77  
 3rd Qu.: 55.22  
 Max.   :212.10  
```
แปลความหมายจากผลลัพธ์ 
- Q0 (min) : ราคา 14.19
- Q1 : ราคา 30.33
- Q2 (median) : ราคา 43.34
- Q3 : ราคา 55.22 
- Q4 (max) : ราคา 212.10
>### Function from **Tidyverse** ในข้อนี้
>
>filter(): Return rows with matching conditions
>
>select() : Select variables by name
>
>

---

### **3. เปอร์เซ็นต์ของประเภทหนังสือแต่ละประเภทต่อจำนวนทั้งหมด**

```
book_totalPercent <- cs_book  %>%
  select(Type) %>%
  group_by(Type) %>%
  summarise(pct = n()) %>%
  mutate(pct = formattable::percent(pct/sum(pct)))
book_totalPercent
```
**ได้ผลลัพธ์**
```
# A tibble: 6 x 2
  Type                  pct       
  <chr>                 <formttbl>
1 Boxed Set - Hardcover 0.37%     
2 ebook                 2.58%     
3 Hardcover             35.06%    
4 Kindle Edition        3.69%     
5 Paperback             57.56%    
6 Unknown Binding       0.74% 
```
>### Function from **Tidyverse** ในข้อนี้
>
>select() : Select variables by name
>
>summarise(): Reduce multiple values down to a single value
>
>mutate(): Create or transform variables

---
### **4. ราคาต่ำสุดและสูงสุดของหนังสือแต่ละประเภท**

```
price_minmax <- cs_book %>%
  select(Type,Price) %>%
  group_by(Type) %>%
  summarise(minPrice = min(Price), maxPrice = max(Price))
price_minmax
```
**ได้ผลลัพธ์**
```
# A tibble: 6 x 3
  Type                  minPrice maxPrice
  <chr>                    <dbl>    <dbl>
1 Boxed Set - Hardcover   220.      220. 
2 ebook                    25.9      83.2
3 Hardcover                 9.32    236. 
4 Kindle Edition           11.3      51.5
5 Paperback                14.2     212. 
6 Unknown Binding          36.1      38.3
```
>### Function from **Tidyverse** ในข้อนี้
>
>select() : Select variables by name
>
>summarise(): Reduce multiple values down to a single value
>
>

---

### **5.รายชื่อและราคาของหนังสือที่ได้เรทติ้งดีที่สุด 10 อันดังแรก**

```
topRating_price <- cs_book %>% 
  select(Book_title,Rating,Price) %>% 
  arrange(desc(Rating)) %>% 
  head(n=10)
topRating_price
```
**ได้ผลลัพธ์**
```
                                                                                                 Book_title Rating     Price
1                                                                                   Your First App: Node.js   5.00  25.85588
2                                                   The Art of Computer Programming, Volumes 1-4a Boxed Set   4.77 220.38529
3  Designing Data-Intensive Applications: The Big Ideas Behind Reliable, Scalable, and Maintainable Systems   4.72  45.56176
4               Build Web Applications with Java: Learn every aspect to build web applications from scratch   4.67  42.27647
5                                                  Fluent Python: Clear, Concise, and Effective Programming   4.67  64.09118
6                                           ZX Spectrum Games Code Club: Twenty fun games to code and learn   4.62  14.64118
7                             The Linux Programming Interface: A Linux and Unix System Programming Handbook   4.62  46.35882
8                                                                          CLR via C# (Developer Reference)   4.58  66.32059
9                       The Elements of Computing Systems: Building a Modern Computer from First Principles   4.54  41.25294
10                                                                 Practical Object Oriented Design in Ruby   4.54  50.09412

```
>### Function from **Tidyverse** ในข้อนี้
>
>select() : Select variables by name
>
>arrange() : Arrange rows by variables
>
>

---
### **6. จำนวนของหนังสือที่มีหน้าน้อยกว่า 200 หน้า**

```
book_pageless200 <- cs_book %>%
  filter(Number_Of_Pages < 200) %>% 
  summarize(num_books = n())
book_pageless200
```
**ได้ผลลัพธ์**
```
  num_books
1        22
```
>### Function from **Tidyverse** ในข้อนี้
>
>summarise(): Reduce multiple values down to a single value
>
>filter(): Return rows with matching conditions
>
>













## Part 4: Visualization with GGplot2
### **1.) กราฟแสดงช่วงราคาของหนังสือแต่ละประเภท**
```
pricePerType_boxplot <-  ggplot(cs_book, aes(x=Type, y=Price, fill=Type)) + geom_boxplot() 
```
Result:

![Graph 1](pricePerType_boxplot.png)

**จากกราฟด้านบนจะเห็นช่วงราคาของหนังสือแต่ละประเภท**
- ประเภท Hardcover มีหนังสือราคาต่ำที่สุด และราคาสูงที่สุดเช่นกัน 
- ประเภท Boxset-Hardcover มีการกระจายของราคาต่ำที่สุด และประเภท Hardcover มีการกระจายของราคามากที่สุด
- ราคาเฉลี่ยของ ebook, Paperback และ Kindle Edition มีราคาใกล้เคียงกัน

---



