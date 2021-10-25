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


```{R}
prog_book %>% 
  filter(Type == "Hardcover" & Rating >= 4) %>% 
  select(-Description,-Number_Of_Pages)
```
#### Result
```
Rating Reviews                                                                                     Book_title
1    4.17   3,829                                                                          The Elements of Style
2    4.01   1,406                                                  The Information: A History, a Theory, a Flood
3    4.09   5,938                              Start with Why: How Great Leaders Inspire Everyone to Take Action
4    4.15   1,817                                 Algorithms to Live By: The Computer Science of Human Decisions
5    4.03     160                                                Sync: The Emerging Science of Spontaneous Order
6    4.10   2,092      The Innovators: How a Group of Hackers, Geniuses and Geeks Created the Digital Revolution
7    4.13      86                     The Cosmic Landscape: String Theory and the Illusion of Intelligent Design
8    4.09       4                                                                         The Connection Machine
9    4.27   2,629                   The Phoenix Project: A Novel About IT, DevOps, and Helping Your Business Win
10   4.08       9                                                         Introduction to Functional Programming
11   4.06     302                           The Strangest Man: The Hidden Life of Paul Dirac, Mystic of the Atom
12   4.00      50   The Shape of Inner Space: String Theory and the Geometry of the Universe's Hidden Dimensions
13   4.28       3                                           Quality Software Management V 1 â€“ Systems Thinking
14   4.05       2                                                                  Best of Game Programming Gems
15   4.54      52            The Elements of Computing Systems: Building a Modern Computer from First Principles
16   4.40     496                                                 The Visual Display of Quantitative Information
17   4.02      13                                                                        Elements of Programming
18   4.62      28                  The Linux Programming Interface: A Linux and Unix System Programming Handbook
19   4.12       9                                            Computational Geometry: Algorithms and Applications
20   4.18     134 Continuous Delivery: Reliable Software Releases Through Build, Test, and Deployment Automation
21   4.25     275                                             Refactoring: Improving the Design of Existing Code
22   4.46     164                                              Structure and Interpretation of Computer Programs
23   4.18     351                                 Design Patterns: Elements of Reusable Object-Oriented Software
24   4.13       5                                                              Object-Oriented Design Heuristics
25   4.37      18                                                                     Mining of Massive Datasets
26   4.21      15     Framework Design Guidelines: Conventions, Idioms, and Patterns for Reusable .NET Libraries
27   4.21      20                                                                               Hacker's Delight
28   4.05      62                                                              Implementing Domain-Driven Design
29   4.00      11                           How to Design Programs: An Introduction to Programming and Computing
30   4.32      39                                                   Advanced Programming in the UNIX Environment
31   4.08      92                                                                   The C++ Programming Language
32   4.00       6                                      Mathematics for 3D Game Programming and Computer Graphics
33   4.31      36                                                   The Protocols (TCP/IP Illustrated, Volume 1)
34   4.15     191                             Domain-Driven Design: Tackling Complexity in the Heart of Software
35   4.13       0                             Communication Networks: Fundamental Concepts and Key Architectures
36   4.41      48                                                                                     Algorithms
37   4.24      11                                                              C++ Templates: The Complete Guide
38   4.33      28                                        Concrete Mathematics: A Foundation for Computer Science
39   4.34      79                                                                    The Algorithm Design Manual
40   4.15      20                                                                               Algorithm Design
41   4.03      10                                                                         Engineering a Compiler
42   4.25      48                                Agile Software Development, Principles, Patterns, and Practices
43   4.14       6                                               3D Math Primer for Graphics and Game Development
44   4.23      66                                                      Introduction to the Theory of Computation
45   4.00       5                                                                          Game Programming Gems
46   4.01       0                                                                        Game Programming Gems 2
47   4.03       0                                                                        Game Programming Gems 5
48   4.33     194                                                                     Introduction to Algorithms
49   4.06       3                Geometric Algebra for Computer Science: An Object-Oriented Approach to Geometry
50   4.37      44                              The Art of Computer Programming, Volume 1: Fundamental Algorithms
51   4.10       7                                   Essential Mathematics for Games and Interactive Applications
52   4.35      21                                                                       Game Engine Architecture
53   4.02      25                                    Introduction to Automata Theory, Languages, and Computation
54   4.03       1                                                          Geometric Tools for Computer Graphics
55   4.42      38                                                   Computer Systems: A Programmer's Perspective
56   4.11      56                                                                       Modern Operating Systems
57   4.13      14                                       Concepts, Techniques, and Models of Computer Programming
58   4.16      16                                             The C++ Standard Library: A Tutorial and Reference
59   4.18     130                                                     Artificial Intelligence: A Modern Approach
60   4.08      56                                                   Compilers: Principles, Techniques, and Tools
61   4.26       5                                             Numerical Recipes: The Art of Scientific Computing
62   4.77       4                                        The Art of Computer Programming, Volumes 1-4a Boxed Set
        Type      Price
1  Hardcover   9.323529
2  Hardcover  11.000000
3  Hardcover  14.232353
4  Hardcover  14.364706
5  Hardcover  15.229412
6  Hardcover  17.229412
7  Hardcover  21.814706
8  Hardcover  23.235294
9  Hardcover  24.258824
10 Hardcover  25.302941
11 Hardcover  25.823529
12 Hardcover  27.941176
13 Hardcover  28.464706
14 Hardcover  33.544118
15 Hardcover  41.252941
16 Hardcover  42.032353
17 Hardcover  42.235294
18 Hardcover  46.358824
19 Hardcover  52.038235
20 Hardcover  52.488235
21 Hardcover  57.152941
22 Hardcover  58.944118
23 Hardcover  60.682353
24 Hardcover  60.682353
25 Hardcover  61.264706
26 Hardcover  61.420588
27 Hardcover  64.232353
28 Hardcover  64.764706
29 Hardcover  66.832353
30 Hardcover  67.835294
31 Hardcover  69.379412
32 Hardcover  69.891176
33 Hardcover  70.758824
34 Hardcover  71.414706
35 Hardcover  75.700000
36 Hardcover  78.608824
37 Hardcover  79.100000
38 Hardcover  79.805882
39 Hardcover  81.920588
40 Hardcover  81.920588
41 Hardcover  83.661765
42 Hardcover  87.285294
43 Hardcover  87.382353
44 Hardcover  90.982353
45 Hardcover  91.047059
46 Hardcover  91.047059
47 Hardcover  91.047059
48 Hardcover  92.255882
49 Hardcover  92.358824
50 Hardcover  93.455882
51 Hardcover  94.785294
52 Hardcover  96.032353
53 Hardcover  97.688235
54 Hardcover  99.829412
55 Hardcover 103.173529
56 Hardcover 103.461765
57 Hardcover 107.747059
58 Hardcover 113.302941
59 Hardcover 115.750000
60 Hardcover 126.579412
61 Hardcover 176.144118
62 Hardcover 220.385294
```
** You can sepearate this part or combine in part of `Transform data with dplyr and finding insight the data`

