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

### Improt Dataset
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

### Filter prog_book hardcover and has a rating greater than 4
```{R}
prog_book %>% 
  filter(Type == "Hardcover" & Rating >= 4) %>% 
  glimpse()
```
#### Result
```
Rows: 62
Columns: 7
$ Rating          <dbl> 4.17, 4.01, 4.09, 4.15, 4.03, 4.10, 4.13, 4.09, 4.27, 4.08, 4.06, 4.00, 4.28, 4.05, 4.54, 4.40,~
$ Reviews         <chr> "3,829", "1,406", "5,938", "1,817", "160", "2,092", "86", "4", "2,629", "9", "302", "50", "3", ~
$ Book_title      <chr> "The Elements of Style", "The Information: A History, a Theory, a Flood", "Start with Why: How ~
$ Description     <chr> "This style manual offers practical advice on improving writing skills. Throughout, the emphasi~
$ Number_Of_Pages <int> 105, 527, 256, 368, 352, 542, 416, 190, 345, 293, 539, 377, 336, 576, 325, 197, 262, 1506, 386,~
$ Type            <chr> "Hardcover", "Hardcover", "Hardcover", "Hardcover", "Hardcover", "Hardcover", "Hardcover", "Har~
$ Price           <dbl> 9.323529, 11.000000, 14.232353, 14.364706, 15.229412, 17.229412, 21.814706, 23.235294, 24.25882~
```

