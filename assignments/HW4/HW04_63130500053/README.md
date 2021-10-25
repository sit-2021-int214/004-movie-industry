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

### 3.6

#### Code
```{R}
prog_book %>% select(Book_title,Rating) %>%
  filter(Rating < mean(Rating)) %>%
  arrange(desc(Rating))
```

#### Result
```
                                                                                                                                   Book_title
1                                                                                                                            How Google Works
2                                         A Smarter Way to Learn JavaScript: The new approach that uses technology to cut your effort in half
3                                                                        The Strangest Man: The Hidden Life of Paul Dirac, Mystic of the Atom
4                                                             Geometric Algebra for Computer Science: An Object-Oriented Approach to Geometry
5                                                                                                               Best of Game Programming Gems
6                                                                                                  The Goal: A Process of Ongoing Improvement
7                                                                                                           Implementing Domain-Driven Design
8                                                                                                                            Machine Learning
9                                                                         The Pattern on the Stone: The Simple Ideas that Make Computers Work
10                                                                                                                    Computability and Logic
11                                                                                     The Mythical Man-Month: Essays on Software Engineering
12                                                                                            Sync: The Emerging Science of Spontaneous Order
13                                                                                                                        The Society of Mind
14                                                                                         Programming Ruby: The Pragmatic Programmers' Guide
15                                                                                                                     Engineering a Compiler
16                                                                                                                    Game Programming Gems 5
17                                                                                                      Geometric Tools for Computer Graphics
18                                                                                          Does God Play Dice?: The New Mathematics of Chaos
19                                                                                                                    Elements of Programming
20                                                                                            Practical Foundations for Programming Languages
21                                                                                Introduction to Automata Theory, Languages, and Computation
22                                                                                              The Information: A History, a Theory, a Flood
23                                                           Data and Goliath: The Hidden Battles to Collect Your Data and Control Your World
24                                                                                                                Chaos: Making a New Science
25                                                                                                                    Game Programming Gems 2
26                                     Python Programming Books Set: Python Programming for Beginners & Complete Guide for Python Programming
27                                               The Shape of Inner Space: String Theory and the Geometry of the Universe's Hidden Dimensions
28                                                                                                            Building an FPS Game with Unity
29                                                                                       Beginning Game Programming: A Gamedev.Net Collection
30                                                                       How to Design Programs: An Introduction to Programming and Computing
31                                                                                  Mathematics for 3D Game Programming and Computer Graphics
32                                                                                                                      Game Programming Gems
33                                                                                   The Hidden Connections: A Science for Sustainable Living
34                                                                                                                              Learning Perl
35                                                                        Ghost in the Wires: My Adventures as the World's Most Wanted Hacker
36                                                                                 How to Create a Mind: The Secret of Human Thought Revealed
37                                                                                                             Seven Languages in Seven Weeks
38                                                                                                         Programming in Lua, Fourth Edition
39                                                                                        Fearless Change: Patterns for Introducing New Ideas
40                                                                                                        Essentials of Programming Languages
41                                                                                                            Computability and Unsolvability
42                                                                                        PHP and MySQL Web Development (Developer's Library)
43                                                                                                                            Learning Python
44                                                                                   Pro TypeScript: Application-Scale JavaScript Development
45                                                                                                           Structured Computer Organization
46                                                                Kingpin: How One Hacker Took Over the Billion-Dollar Cybercrime Underground
47                                                                                                                            Programming PHP
48                          Linked: How Everything Is Connected to Everything Else and What It Means for Business, Science, and Everyday Life
49                                                                                                 xUnit Test Patterns: Refactoring Test Code
50                                                                                                        An Introduction to Database Systems
51                                                                                              Agile Retrospectives: Making Good Teams Great
52                                                                                    Data Science from Scratch: First Principles with Python
53                                                                                                Design and Validation of Computer Protocols
54                                                                                                             Data Structures and Algorithms
55                                                         The Calculus of Computation: Decision Procedures with Applications to Verification
56                                                                                      Object-Oriented Analysis and Design with Applications
57                                                                                                Six Degrees: The Science of a Connected Age
58                                                              Python Programming For Beginners: Quick And Easy Guide For Python Programmers
59                                                                                              Effective Programming: More Than Writing Code
60                                                                                                      Elements of the Theory of Computation
61                                                                                                      Computational Science and Engineering
62                                                                            Think Complexity: Complexity Science and Computational Modeling
63                                                                                          Soft Skills: The Software Developer's Life Manual
64                                                                       Think Like a Programmer: An Introduction to Creative Problem Solving
65                                                     Weapons of Math Destruction: How Big Data Increases Inequality and Threatens Democracy
66                                                                                              Superintelligence: Paths, Dangers, Strategies
67                                                  The Art of the Start: The Time-Tested, Battle-Hardened Guide for Anyone Starting Anything
68                                                                                                                  Learn Python The Hard Way
69                                                                                                                  Domain-Specific Languages
70                                                                                      File Structures: An Object-Oriented Approach with C++
71                                                  Nine Algorithms That Changed the Future: The Ingenious Ideas That Drive Today's Computers
72                                                                                                          Making Games with Python & Pygame
73                                                                                                                   Computational Complexity
74                                                                         The Quark and the Jaguar: Adventures in the Simple and the Complex
75                                                                                                                           The Meme Machine
76                                                                                        Agile Web Development with Rails: A Pragmatic Guide
77                                                                                                      A Discipline for Software Engineering
78                                                                                       Automate This: How Algorithms Came to Rule Our World
79                                                           The Scrumban [R]Evolution: Getting the Most Out of Agile, Scrum, and Lean Kanban
80                                                                                                                              The Rails Way
81                                                                                                                         Basic Proof Theory
82                                                                                      REST in Practice: Hypermedia and Systems Architecture
83                                                                  Big Data: Principles and best practices of scalable realtime data systems
84                                                                                                                    Game Programming Gems 6
85                                                                                                                    Game Programming Gems 3
86                                                                      UML Distilled: A Brief Guide to the Standard Object Modeling Language
87                                                The Master Algorithm: How the Quest for the Ultimate Learning Machine Will Remake Our World
88                                                                                                                  How Google Tests Software
89                                                                                      Functional Programming Application and Implementation
90                                                                                           Lambda-Calculus and Combinators: An Introduction
91                                                                                                                   Database System Concepts
92                                                                                                                    Game Programming Gems 4
93                                                                           Learn Java the Easy Way : A Hands-On Introduction to Programming
94  3D Game Engine Architecture: Engineering Real-Time Applications with Wild Magic (The Morgan Kaufmann Series in Interactive 3d Technology)
95                                                                  Our Final Invention: Artificial Intelligence and the End of the Human Era
96                                                                                     The Design of Design: Essays from a Computer Scientist
97                                                                                                                                   Ship It!
98                                                                                                               Machine Learning for Hackers
99                                                                    Big Data: A Revolution That Will Transform How We Live, Work, and Think
100                                                                                                                        Doing Data Science
101                                                                                                Augmented Reality: Principles and Practice
102                                                                                                             Manage Your Project Portfolio
103                                                                                                     Sams Teach Yourself MySQL in 24 Hours
104                                                                                              The Architecture of Open Source Applications
105                                                                                                                 Managing Data Using Excel
106                                                                                                                        Game Engine Gems 1
107                                                                97 Things Every Programmer Should Know: Collective Wisdom from the Experts
108                                                                               The Golden Ticket: P, Np, and the Search for the Impossible
109                                                                          Genetic Programming II: Automatic Discovery of Reusable Programs
110                                                                                                                             Learning Ruby
111                                                                                                                   The Boost C++ Libraries
112                                                                                                  The Unified Modeling Language User Guide
113                                                                                              Haskell: The Craft of Functional Programming
114                                                                               Optimized C++: Proven Techniques for Heightened Performance
115      3D Game Engine Design: A Practical Approach to Real-Time Computer Graphics (The Morgan Kaufmann Series in Interactive 3D Technology)
116                                                                                                      Sams Teach Yourself Perl in 24 Hours
117                                                                                                            Unity Virtual Reality Projects
118                                                                                              Responsive Web Design Overview For Beginners
119                                                                                                Sams Teach Yourself JavaScript in 24 Hours
120                                                                                                                          Beginning Java 2
121                                                                                                             Game Programming Golden Rules
122                                                                                       Advanced Game Programming: A Gamedev.Net Collection
123                                                 Cross-Platform Game Programming (Game Development) (Charles River Media Game Development)
124                                                                                   Lambda-Calculus, Combinators and Functional Programming
    Rating
1     4.06
2     4.06
3     4.06
4     4.06
5     4.05
6     4.05
7     4.05
8     4.05
9     4.04
10    4.04
11    4.04
12    4.03
13    4.03
14    4.03
15    4.03
16    4.03
17    4.03
18    4.02
19    4.02
20    4.02
21    4.02
22    4.01
23    4.01
24    4.01
25    4.01
26    4.00
27    4.00
28    4.00
29    4.00
30    4.00
31    4.00
32    4.00
33    3.98
34    3.98
35    3.97
36    3.97
37    3.97
38    3.97
39    3.97
40    3.97
41    3.96
42    3.96
43    3.96
44    3.96
45    3.96
46    3.95
47    3.95
48    3.94
49    3.94
50    3.94
51    3.93
52    3.93
53    3.93
54    3.93
55    3.92
56    3.92
57    3.91
58    3.91
59    3.91
60    3.91
61    3.90
62    3.89
63    3.88
64    3.88
65    3.87
66    3.87
67    3.87
68    3.87
69    3.87
70    3.87
71    3.86
72    3.86
73    3.86
74    3.85
75    3.84
76    3.84
77    3.84
78    3.83
79    3.83
80    3.83
81    3.83
82    3.82
83    3.82
84    3.82
85    3.82
86    3.79
87    3.78
88    3.78
89    3.78
90    3.78
91    3.77
92    3.77
93    3.76
94    3.76
95    3.75
96    3.75
97    3.73
98    3.73
99    3.71
100   3.70
101   3.70
102   3.68
103   3.68
104   3.67
105   3.67
106   3.67
107   3.65
108   3.60
109   3.59
110   3.58
111   3.58
112   3.56
113   3.52
114   3.48
115   3.45
116   3.38
117   3.37
118   3.33
119   3.32
120   3.22
121   3.20
122   3.00
123   3.00
124   3.00
```
