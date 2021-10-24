# R-Assignment 4

**Created by Name-Surname (ID: xxxxxxxxxx)**

Choose Dataset:
- Top 270 Computer Science / Programing Books (Data from Thomas Konstantin, [Kaggle](https://www.kaggle.com/thomaskonstantin/top-270-rated-computer-science-programing-books)) >> [Using CSV](https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv)


### Outlines
1. Explore the dataset
2. Learning function from Tidyverse
3. Transform data with dplyr and finding insight the data
4. Visualization with GGplot2

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
ด้วยคำสั่ง `glimpse()`
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

#### 1. NULL

```
```



















## Part 4: Visualization with GGplot2
### 1.) Graph show relation between height and mass
```
scat_plot <- starwars %>% filter(mass<500) %>% ggplot(aes(x=height,y=mass))+
  geom_point(aes(color=gender))

scat_plot+geom_smooth()
```
Result:

![Graph 1](graph1.png)

**Guideline:
Embed Image by using this syntax in markdown file
````
![Name](imageFile)
````
