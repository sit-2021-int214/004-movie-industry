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

### 3.1 Show the top 10 books according to the book rating.

```{R}
prog_book %>%
  select(Rating,Book_title,Type) %>%
  arrange(desc(Rating)) %>%
  top_n(10) 
```

#### Result

```
Selecting by Type
    Rating
1     4.72
2     4.67
3     4.67
4     4.62
5     4.58
6     4.54
7     4.50
8     4.50
9     4.49
10    4.46
11    4.43
12    4.42
13    4.40
14    4.40
15    4.40
16    4.39
17    4.37
18    4.37
19    4.37
20    4.35
21    4.35
22    4.34
23    4.33
24    4.33
25    4.33
26    4.32
27    4.31
28    4.30
29    4.30
30    4.29
31    4.29
32    4.29
33    4.28
34    4.28
35    4.28
36    4.28
37    4.27
38    4.27
39    4.25
40    4.25
41    4.25
42    4.25
43    4.25
44    4.24
45    4.23
46    4.23
47    4.23
48    4.23
49    4.23
50    4.23
51    4.22
52    4.22
53    4.22
54    4.22
55    4.21
56    4.21
57    4.21
58    4.20
59    4.20
60    4.20
61    4.20
62    4.20
63    4.19
64    4.18
65    4.18
66    4.18
67    4.17
68    4.16
69    4.16
70    4.15
71    4.15
72    4.15
73    4.15
74    4.14
75    4.14
76    4.13
77    4.12
78    4.12
79    4.11
80    4.11
81    4.11
82    4.11
83    4.11
84    4.11
85    4.11
86    4.10
87    4.10
88    4.09
89    4.08
90    4.08
91    4.08
92    4.05
93    4.05
94    4.04
95    4.04
96    4.04
97    4.03
98    4.03
99    4.02
100   4.01
101   4.01
102   4.00
103   4.00
104   4.00
105   3.98
106   3.98
107   3.97
108   3.97
109   3.96
110   3.96
111   3.96
112   3.96
113   3.95
114   3.94
115   3.94
116   3.93
117   3.93
118   3.93
119   3.91
120   3.91
121   3.91
122   3.89
123   3.88
124   3.88
125   3.87
126   3.87
127   3.86
128   3.86
129   3.85
130   3.84
131   3.84
132   3.83
133   3.82
134   3.82
135   3.79
136   3.78
137   3.75
138   3.73
139   3.73
140   3.70
141   3.70
142   3.68
143   3.68
144   3.67
145   3.67
146   3.65
147   3.58
148   3.58
149   3.52
150   3.48
151   3.38
152   3.37
153   3.32
154   3.22
155   3.20
156   3.00
157   3.00
158   3.00
                                                                                                           Book_title
1            Designing Data-Intensive Applications: The Big Ideas Behind Reliable, Scalable, and Maintainable Systems
2                         Build Web Applications with Java: Learn every aspect to build web applications from scratch
3                                                            Fluent Python: Clear, Concise, and Effective Programming
4                                                     ZX Spectrum Games Code Club: Twenty fun games to code and learn
5                                                                                    CLR via C# (Developer Reference)
6                                                                            Practical Object Oriented Design in Ruby
7                                                                                 High Performance Browser Networking
8                                                                                                         C# in Depth
9                                                                                           Game Programming Patterns
10                Structure and Interpretation of Computer Programs (MIT Electrical Engineering and Computer Science)
11                                                                                    Functional Programming in Scala
12                                                                                         The C Programming Language
13                                                        Code: The Hidden Language of Computer Hardware and Software
14                                                             Clean Code: A Handbook of Agile Software Craftsmanship
15                                        The It Handbook for Business: Managing Information Technology Support Costs
16                                                                      Blueprints Visual Scripting for Unreal Engine
17                                                                                            Adventures in Minecraft
18                                                                                       Dependency Injection in .NET
19              A First Course in Logic: An Introduction to Model Theory, Proof Theory, Computability, and Complexity
20                                         Python Crash Course: A Hands-On, Project-Based Introduction to Programming
21                                                                                   Microsoft Visual C# Step by Step
22                                                        Practical SQL: A Beginner's Guide to Storytelling with Data
23                                  Beginners Guide On PHP Programming: Quick And Easy Guide To Learn PHP With My-SQL
24                                                                                                 More Effective C++
25                                                                              Android NDK Game Development Cookbook
26                                                                               Expert C Programming: Deep C Secrets
27                                                            Learn You a Haskell for Great Good!: A Beginner's Guide
28                                          Effective JavaScript: 68 Specific Ways to Harness the Power of JavaScript
29         Introduction to Game Design, Prototyping, and Development: From Concept to Playable Game with Unity and C#
30                                                          Effective Python: 59 Specific Ways to Write Better Python
31                                                                                                      A Tour of C++
32                                                                                                      Code Complete
33                                   The Code Book: The Science of Secrecy from Ancient Egypt to Quantum Cryptography
34                                                                                                 The Little Schemer
35                                                    The Clean Coder: A Code of Conduct for Professional Programmers
36                                                                                         Head First Design Patterns
37                                   Automate the Boring Stuff with Python: Practical Programming for Total Beginners
38                                                                                                    Unity in Action
39                                                                                            Coding Games in Scratch
40                                   Release It!: Design and Deploy Production-Ready Software (Pragmatic Programmers)
41                                                                                     The Sciences of the Artificial
42                                                                                                     Reviewing Java
43                                                                                        Inside the C++ Object Model
44                                                 Modern C++ Design: Generic Programming and Design Patterns Applied
45                                                                                         JavaScript: The Good Parts
46                                                           Introduction to Computation and Programming Using Python
47                              More Exceptional C++: 40 New Engineering Puzzles, Programming Problems, and Solutions
48                             Exceptional C++ Style: 40 New Engineering Puzzles, Programming Problems, and Solutions
49                                                                                    Feynman Lectures On Computation
50                                                                                   The UNIX Programming Environment
51              Debugging: The 9 Indispensable Rules for Finding Even the Most Elusive Software and Hardware Problems
52                               Effective STL: 50 Specific Ways to Improve Your Use of the Standard Template Library
53                                                                                    Assembly Language: Step-By-Step
54                                                                                                         C++ Primer
55                                                                                Help Your Kids with Computer Coding
56                                                 DIV, Grad, Curl, and All That: An Informal Text on Vector Calculus
57                                       Exceptional C++: 47 Engineering Puzzles, Programming Problems, and Solutions
58                                                                                     Scrum and XP from the Trenches
59                                                                                                      Reviewing C++
60                                             Cryptography Engineering: Design Principles and Practical Applications
61                                                                                                 Programming Pearls
62                              C++ Coding Standards: 101 Rules, Guidelines, and Best Practices (C++ in Depth Series)
63                                                                  Growing Object-Oriented Software, Guided by Tests
64                                                                                        Real-World Machine Learning
65                                                                                                 The Joy of Clojure
66                                                             Building Microservices: Designing Fine-Grained Systems
67                                                                          Peopleware: Productive Projects and Teams
68                                                                                                            Pro Git
69                                                                                              C: A Reference Manual
70                                                   What Is Life? with Mind and Matter and Autobiographical Sketches
71                                                  An Introduction to Functional Programming Through Lambda Calculus
72                                                          Eloquent JavaScript: A Modern Introduction to Programming
73                                                                                 Quantum Computing Since Democritus
74                                               Essential Scrum: A Practical Guide to the Most Popular Agile Process
75                                                                               Working Effectively with Legacy Code
76                                                                                           Python for Data Analysis
77                                              Apprenticeship Patterns: Guidance for the Aspiring Software Craftsman
78                                                                                                      C Primer Plus
79                                                            Invent Your Own Computer Games with Python, 3rd Edition
80                                                                                                   Joel on Software
81                                                                                            CSS: The Missing Manual
82                                                       How to Think Like a Computer Scientist: Learning with Python
83                                         The Practice of Programming (Addison-Wesley Professional Computing Series)
84                                                                             The Psychology of Computer Programming
85                                                                              Modern Operating Systems, 4th Edition
86                                                                                                 API Design for C++
87                                                                     Computer Architecture: A Quantitative Approach
88                                          Accelerate: Building and Scaling High-Performing Technology Organizations
89                                                      Extreme Programming Explained: Embrace Change (The XP Series)
90                                                                                Test Driven Development: By Example
91                                                                  Accelerated C++: Practical Programming by Example
92                                                                         The Goal: A Process of Ongoing Improvement
93                                                                                                   Machine Learning
94                                                The Pattern on the Stone: The Simple Ideas that Make Computers Work
95                                                                                            Computability and Logic
96                                                             The Mythical Man-Month: Essays on Software Engineering
97                                                                                                The Society of Mind
98                                                                 Programming Ruby: The Pragmatic Programmers' Guide
99                                                                  Does God Play Dice?: The New Mathematics of Chaos
100                                  Data and Goliath: The Hidden Battles to Collect Your Data and Control Your World
101                                                                                       Chaos: Making a New Science
102            Python Programming Books Set: Python Programming for Beginners & Complete Guide for Python Programming
103                                                                                   Building an FPS Game with Unity
104                                                              Beginning Game Programming: A Gamedev.Net Collection
105                                                          The Hidden Connections: A Science for Sustainable Living
106                                                                                                     Learning Perl
107                                                                                    Seven Languages in Seven Weeks
108                                                                                Programming in Lua, Fourth Edition
109                                                                                   Computability and Unsolvability
110                                                               PHP and MySQL Web Development (Developer's Library)
111                                                                                                   Learning Python
112                                                          Pro TypeScript: Application-Scale JavaScript Development
113                                                                                                   Programming PHP
114 Linked: How Everything Is Connected to Everything Else and What It Means for Business, Science, and Everyday Life
115                                                                               An Introduction to Database Systems
116                                                                     Agile Retrospectives: Making Good Teams Great
117                                                                       Design and Validation of Computer Protocols
118                                                                                    Data Structures and Algorithms
119                                                                       Six Degrees: The Science of a Connected Age
120                                     Python Programming For Beginners: Quick And Easy Guide For Python Programmers
121                                                                             Elements of the Theory of Computation
122                                                   Think Complexity: Complexity Science and Computational Modeling
123                                                                 Soft Skills: The Software Developer's Life Manual
124                                              Think Like a Programmer: An Introduction to Creative Problem Solving
125                                                                                         Learn Python The Hard Way
126                                                             File Structures: An Object-Oriented Approach with C++
127                                                                                 Making Games with Python & Pygame
128                                                                                          Computational Complexity
129                                                The Quark and the Jaguar: Adventures in the Simple and the Complex
130                                                                                                  The Meme Machine
131                                                               Agile Web Development with Rails: A Pragmatic Guide
132                                                                                                     The Rails Way
133                                                             REST in Practice: Hypermedia and Systems Architecture
134                                         Big Data: Principles and best practices of scalable realtime data systems
135                                             UML Distilled: A Brief Guide to the Standard Object Modeling Language
136                                                                                         How Google Tests Software
137                                                            The Design of Design: Essays from a Computer Scientist
138                                                                                                          Ship It!
139                                                                                      Machine Learning for Hackers
140                                                                                                Doing Data Science
141                                                                        Augmented Reality: Principles and Practice
142                                                                                     Manage Your Project Portfolio
143                                                                             Sams Teach Yourself MySQL in 24 Hours
144                                                                      The Architecture of Open Source Applications
145                                                                                         Managing Data Using Excel
146                                        97 Things Every Programmer Should Know: Collective Wisdom from the Experts
147                                                                                                     Learning Ruby
148                                                                                           The Boost C++ Libraries
149                                                                      Haskell: The Craft of Functional Programming
150                                                       Optimized C++: Proven Techniques for Heightened Performance
151                                                                              Sams Teach Yourself Perl in 24 Hours
152                                                                                    Unity Virtual Reality Projects
153                                                                        Sams Teach Yourself JavaScript in 24 Hours
154                                                                                                  Beginning Java 2
155                                                                                     Game Programming Golden Rules
156                                                               Advanced Game Programming: A Gamedev.Net Collection
157                         Cross-Platform Game Programming (Game Development) (Charles River Media Game Development)
158                                                           Lambda-Calculus, Combinators and Functional Programming
               Type
1         Paperback
2         Paperback
3         Paperback
4         Paperback
5         Paperback
6         Paperback
7         Paperback
8         Paperback
9         Paperback
10        Paperback
11        Paperback
12        Paperback
13        Paperback
14        Paperback
15        Paperback
16        Paperback
17        Paperback
18        Paperback
19        Paperback
20        Paperback
21        Paperback
22        Paperback
23        Paperback
24        Paperback
25        Paperback
26        Paperback
27        Paperback
28        Paperback
29        Paperback
30        Paperback
31        Paperback
32        Paperback
33        Paperback
34        Paperback
35        Paperback
36        Paperback
37        Paperback
38        Paperback
39        Paperback
40        Paperback
41        Paperback
42        Paperback
43        Paperback
44        Paperback
45        Paperback
46        Paperback
47        Paperback
48        Paperback
49        Paperback
50        Paperback
51        Paperback
52        Paperback
53        Paperback
54        Paperback
55        Paperback
56        Paperback
57        Paperback
58        Paperback
59        Paperback
60        Paperback
61        Paperback
62        Paperback
63        Paperback
64        Paperback
65        Paperback
66        Paperback
67        Paperback
68        Paperback
69        Paperback
70        Paperback
71        Paperback
72        Paperback
73        Paperback
74        Paperback
75        Paperback
76        Paperback
77        Paperback
78        Paperback
79        Paperback
80        Paperback
81        Paperback
82  Unknown Binding
83        Paperback
84        Paperback
85        Paperback
86        Paperback
87        Paperback
88        Paperback
89        Paperback
90        Paperback
91        Paperback
92        Paperback
93        Paperback
94        Paperback
95        Paperback
96        Paperback
97        Paperback
98        Paperback
99        Paperback
100       Paperback
101       Paperback
102       Paperback
103       Paperback
104       Paperback
105       Paperback
106       Paperback
107       Paperback
108       Paperback
109       Paperback
110       Paperback
111       Paperback
112       Paperback
113       Paperback
114       Paperback
115       Paperback
116       Paperback
117       Paperback
118       Paperback
119       Paperback
120       Paperback
121       Paperback
122       Paperback
123       Paperback
124       Paperback
125 Unknown Binding
126       Paperback
127       Paperback
128       Paperback
129       Paperback
130       Paperback
131       Paperback
132       Paperback
133       Paperback
134       Paperback
135       Paperback
136       Paperback
137       Paperback
138       Paperback
139       Paperback
140       Paperback
141       Paperback
142       Paperback
143       Paperback
144       Paperback
145       Paperback
146       Paperback
147       Paperback
148       Paperback
149       Paperback
150       Paperback
151       Paperback
152       Paperback
153       Paperback
154       Paperback
155       Paperback
156       Paperback
157       Paperback
158       Paperback
```
//Explain

- list 1
- list 2