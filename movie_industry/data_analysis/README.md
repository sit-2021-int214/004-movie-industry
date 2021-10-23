Data Analysis with Descriptive Statistics
================

### Import nesessary packages

``` r
packages <- c("dplyr", "readr", "scales")
lapply(packages, library, character.only = T)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    ## 
    ## Attaching package: 'scales'

    ## The following object is masked from 'package:readr':
    ## 
    ##     col_factor

    ## [[1]]
    ## [1] "dplyr"     "stats"     "graphics"  "grDevices" "utils"     "datasets" 
    ## [7] "methods"   "base"     
    ## 
    ## [[2]]
    ## [1] "readr"     "dplyr"     "stats"     "graphics"  "grDevices" "utils"    
    ## [7] "datasets"  "methods"   "base"     
    ## 
    ## [[3]]
    ##  [1] "scales"    "readr"     "dplyr"     "stats"     "graphics"  "grDevices"
    ##  [7] "utils"     "datasets"  "methods"   "base"

### Import dataset

``` r
movies <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/004-movie-industry/main/movie_industry/csv/cleaned_dataset/movies_cleaned.csv")
```

    ## Rows: 7668 Columns: 16

    ## -- Column specification --------------------------------------------------------
    ## Delimiter: ","
    ## chr  (9): name, rating, genre, released.country, director, writer, star, cou...
    ## dbl  (6): year, score, votes, budget, gross, runtime
    ## date (1): released.date

    ## 
    ## i Use `spec()` to retrieve the full column specification for this data.
    ## i Specify the column types or set `show_col_types = FALSE` to quiet this message.

### Check data types each variable

``` r
# observe dataset and data type
glimpse(movies)
```

    ## Rows: 7,668
    ## Columns: 16
    ## $ name             <chr> "The Shining", "The Blue Lagoon", "Star Wars: Episode~
    ## $ rating           <chr> "R", "R", "PG", "PG", "R", "R", "R", "R", "PG", "R", ~
    ## $ genre            <chr> "Drama", "Adventure", "Action", "Comedy", "Comedy", "~
    ## $ year             <dbl> 1980, 1980, 1980, 1980, 1980, 1980, 1980, 1980, 1980,~
    ## $ released.date    <date> 1980-06-13, 1980-07-02, 1980-06-20, 1980-07-02, 1980~
    ## $ released.country <chr> "United States", "United States", "United States", "U~
    ## $ score            <dbl> 8.4, 5.8, 8.7, 7.7, 7.3, 6.4, 7.9, 8.2, 6.8, 7.0, 6.1~
    ## $ votes            <dbl> 927000, 65000, 1200000, 221000, 108000, 123000, 18800~
    ## $ director         <chr> "Stanley Kubrick", "Randal Kleiser", "Irvin Kershner"~
    ## $ writer           <chr> "Stephen King", "Henry De Vere Stacpoole", "Leigh Bra~
    ## $ star             <chr> "Jack Nicholson", "Brooke Shields", "Mark Hamill", "R~
    ## $ country          <chr> "United Kingdom", "United States", "United States", "~
    ## $ budget           <dbl> 1.9e+07, 4.5e+06, 1.8e+07, 3.5e+06, 6.0e+06, 5.5e+05,~
    ## $ gross            <dbl> 46998772, 58853106, 538375067, 83453539, 39846344, 39~
    ## $ company          <chr> "Warner Bros.", "Columbia Pictures", "Lucasfilm", "Pa~
    ## $ runtime          <dbl> 146, 104, 124, 88, 98, 95, 133, 129, 127, 100, 116, 1~

### Convert an inappropriate data type

``` r
# convert data type
movies <- movies %>%
    mutate(year = format(year, format = "%Y")) %>%
    mutate(released.country = as.factor(released.country)) %>%
    mutate_at(.vars = c("genre", "rating", "country"), .funs = as.factor) %>%
    mutate_at(.vars = c("votes", "runtime"), .funs = as.integer)
glimpse(movies)
```

    ## Rows: 7,668
    ## Columns: 16
    ## $ name             <chr> "The Shining", "The Blue Lagoon", "Star Wars: Episode~
    ## $ rating           <fct> R, R, PG, PG, R, R, R, R, PG, R, PG, PG, PG, R, R, PG~
    ## $ genre            <fct> Drama, Adventure, Action, Comedy, Comedy, Horror, Act~
    ## $ year             <chr> "1980", "1980", "1980", "1980", "1980", "1980", "1980~
    ## $ released.date    <date> 1980-06-13, 1980-07-02, 1980-06-20, 1980-07-02, 1980~
    ## $ released.country <fct> United States, United States, United States, United S~
    ## $ score            <dbl> 8.4, 5.8, 8.7, 7.7, 7.3, 6.4, 7.9, 8.2, 6.8, 7.0, 6.1~
    ## $ votes            <int> 927000, 65000, 1200000, 221000, 108000, 123000, 18800~
    ## $ director         <chr> "Stanley Kubrick", "Randal Kleiser", "Irvin Kershner"~
    ## $ writer           <chr> "Stephen King", "Henry De Vere Stacpoole", "Leigh Bra~
    ## $ star             <chr> "Jack Nicholson", "Brooke Shields", "Mark Hamill", "R~
    ## $ country          <fct> United Kingdom, United States, United States, United ~
    ## $ budget           <dbl> 1.9e+07, 4.5e+06, 1.8e+07, 3.5e+06, 6.0e+06, 5.5e+05,~
    ## $ gross            <dbl> 46998772, 58853106, 538375067, 83453539, 39846344, 39~
    ## $ company          <chr> "Warner Bros.", "Columbia Pictures", "Lucasfilm", "Pa~
    ## $ runtime          <int> 146, 104, 124, 88, 98, 95, 133, 129, 127, 100, 116, 1~

### Check N/A

``` r
# check N/A
na_col <- colSums(is.na(movies))
na_col[na_col > 0]
```

    ## released.date 
    ##            59

## Analysis section

``` r
# The average profit multiple for each genre of movies from 1980 to 2020, the "Family" genre has the highest average profit multiple at 9.14 times, and the "Western" genre is the lowest at -0.046 times.
movies %>%
    filter(budget != 0 & gross != 0) %>%
    group_by(genre) %>%
    summarise(total.movies = n(), 
              avg.budget = mean(budget),
              avg.profit = mean(gross - budget)) %>%
    mutate(avg.profit.multiple = avg.profit/avg.budget) %>%
    mutate_at(c("avg.budget", "avg.profit"), .funs = dollar)
```

    ## # A tibble: 15 x 5
    ##    genre     total.movies avg.budget  avg.profit   avg.profit.multiple
    ##    <fct>            <int> <chr>       <chr>                      <dbl>
    ##  1 Action            1417 $58,415,253 $109,397,756              1.87  
    ##  2 Adventure          327 $45,958,899 $87,309,333               1.90  
    ##  3 Animation          278 $76,052,410 $204,072,214              2.68  
    ##  4 Biography          312 $25,360,833 $35,846,275               1.41  
    ##  5 Comedy            1496 $22,802,372 $36,365,287               1.59  
    ##  6 Crime              400 $22,571,390 $27,510,892               1.22  
    ##  7 Drama              869 $23,190,840 $37,040,598               1.60  
    ##  8 Family               4 $51,125,000 $467,458,147              9.14  
    ##  9 Fantasy             42 $16,885,714 $22,422,897               1.33  
    ## 10 Horror             254 $13,299,476 $42,850,170               3.22  
    ## 11 Mystery             17 $31,876,471 $86,011,263               2.70  
    ## 12 Romance              5 $24,040,000 $9,535,381                0.397 
    ## 13 Sci-Fi               6 $24,416,667 $13,193,436               0.540 
    ## 14 Thriller             7 $12,742,857 $29,745,284               2.33  
    ## 15 Western              2 $10,500,000 -$487,057                -0.0464

``` r
# The most released movie genre for the first ten years is "Action." After that, until 2020, "Animation" is the most released movie genre.
result <- movies %>%
    group_by(year, genre) %>%
    summarise(total.movies = n(),
              avg.score = mean(score),
              avg.budget = mean(budget),
              avg.gross = mean(gross),
              avg.profit = mean(gross - budget)) %>%
    filter(avg.profit == max(avg.profit)) %>%
    mutate_at(c("avg.budget", "avg.profit", "avg.gross"), .funs = dollar) %>%
    mutate(avg.score = round(avg.score, digits = 2))
```

``` r
# show the result
result
```

    ## # A tibble: 41 x 7
    ## # Groups:   year [41]
    ##    year  genre     total.movies avg.score avg.budget  avg.gross    avg.profit  
    ##    <chr> <fct>            <int>     <dbl> <chr>       <chr>        <chr>       
    ##  1 1980  Action              14      6.18 $16,642,857 $71,407,274  $54,764,416 
    ##  2 1981  Action              17      6.54 $10,605,882 $42,460,636  $31,854,754 
    ##  3 1982  Family               1      7.8  $10,500,000 $792,910,554 $782,410,554
    ##  4 1983  Action              31      5.5  $10,509,903 $33,992,856  $23,482,953 
    ##  5 1984  Action              31      6.25 $11,662,903 $53,427,677  $41,764,774 
    ##  6 1985  Biography            9      7.11 $6,222,222  $34,270,044  $28,047,822 
    ##  7 1986  Action              46      5.63 $9,545,682  $32,144,466  $22,598,784 
    ##  8 1987  Biography            7      7.24 $7,757,143  $32,969,695  $25,212,552 
    ##  9 1988  Animation            5      7.6  $23,440,000 $104,305,884 $80,865,884 
    ## 10 1989  Animation            4      6.77 $22,200,000 $60,777,722  $38,577,722 
    ## # ... with 31 more rows

``` r
# count the number of movies in the "result"
total.movies <- table(result$genre)
total.movies[total.movies > 0] %>% sort(decreasing = T)
```

    ## 
    ## Animation    Action Adventure   Mystery Biography    Family 
    ##        23         8         3         3         2         2

``` r
# Comedy movie genres that are released in the United States have the most average score among all genres at 6.16 
movies %>%
    filter(released.country == "United States") %>% 
    group_by(genre) %>%
    summarise(total.movies = n(),
              avg.score = mean(score)) %>%
    filter(total.movies == max(total.movies))
```

    ## # A tibble: 1 x 3
    ##   genre  total.movies avg.score
    ##   <fct>         <int>     <dbl>
    ## 1 Comedy         2021      6.16

``` r
# James Cameron is the PG-13 director that made the highest average profit among the PG-13 director.
movies %>%
    filter(rating == "PG-13") %>%
    filter(budget != 0 & gross != 0) %>%
    group_by(director) %>%
    summarise(total.movies = n(),
              avg.score = mean(score),
              avg.budget = mean(budget),
              avg.profit = mean(gross - budget)) %>%
    mutate(avg.profit.multiple = avg.profit/avg.budget) %>%
    arrange(desc(avg.profit)) %>%
    mutate_at(c("avg.budget", "avg.profit"), .funs = dollar) %>%
    head(10)
```

    ## # A tibble: 10 x 6
    ##    director        total.movies avg.score avg.budget avg.profit avg.profit.mult~
    ##    <chr>                  <int>     <dbl> <chr>      <chr>                 <dbl>
    ##  1 James Cameron              3      7.7  $169,000,~ $1,543,96~             9.14
    ##  2 Anthony Russo              5      7.58 $230,200,~ $1,138,64~             4.95
    ##  3 Shane Black                1      7.1  $200,000,~ $1,014,81~             5.07
    ##  4 Jon Watts                  2      7.45 $167,500,~ $838,547,~             5.01
    ##  5 Joss Whedon                3      7.7  $169,666,~ $817,690,~             4.82
    ##  6 Sam Mendes                 2      7.25 $222,500,~ $772,125,~             3.47
    ##  7 Colin Trevorrow            2      6.8  $80,000,0~ $757,556,~             9.47
    ##  8 Ruben Fleischer            1      6.7  $100,000,~ $756,085,~             7.56
    ##  9 George Lucas               1      7.5  $113,000,~ $755,390,~             6.68
    ## 10 Patty Jenkins              1      7.4  $149,000,~ $673,824,~             4.52

``` r
# From 1980 to 2020, Woody Allen had the highest directed movie at 38 movies and made $516 million.
most_directed <- movies %>% 
    group_by(director) %>% 
    summarize(total.budget = sum(budget),
              total.profit = sum(gross - budget),
              directed.movies = n()) %>%
    mutate_at(c("total.budget", "total.profit"), .funs = dollar) %>%
    filter(directed.movies == max(directed.movies))

# show the result
most_directed
```

    ## # A tibble: 1 x 4
    ##   director    total.budget total.profit directed.movies
    ##   <chr>       <chr>        <chr>                  <int>
    ## 1 Woody Allen $564,250,000 $516,679,312              38

``` r
# The list of directors that directed their movie and have the most average scores is 8.5
avg_score <- movies %>%
    group_by(director) %>%
    summarise(avg.score = mean(score), 
              total.movies = n()) %>%
    filter(avg.score == max(avg.score))

# show the result
avg_score
```

    ## # A tibble: 3 x 3
    ##   director              avg.score total.movies
    ##   <chr>                     <dbl>        <int>
    ## 1 Anurag Kashyap              8.5            1
    ## 2 Marco Tullio Giordana       8.5            1
    ## 3 Olivier Nakache             8.5            1

``` r
# These are the top 5 movies from France with the most votes. According to output, Léon: The Professional has the highest vote at 1.1 million.
top_france <- movies %>%
    filter(country == "France") %>%
    select(name, votes) %>%
    arrange(desc(votes)) %>%
    mutate(votes = scales::comma(votes)) %>%
    head(5)

# show the result
top_france
```

    ## # A tibble: 5 x 2
    ##   name                   votes      
    ##   <chr>                  <chr>      
    ## 1 Léon: The Professional 1,100,000.0
    ## 2 The Intouchables       785,000.0  
    ## 3 Amélie                 717,000.0  
    ## 4 Taken                  575,000.0  
    ## 5 Lucy                   460,000.0

``` r
# From 2010 to 2020, the PG-13 makes the highest profit, around $98 billion among all ratings. Apart from that, TV-MA has the highest multiple earnings at 12 times.
top_profit <- movies %>% 
    filter(between(year, 2010, 2020)) %>%
    filter(budget != 0 & gross != 0) %>%
    group_by(rating) %>%
    summarize(total.movies = n(),
              total.budget = sum(budget),
              total.profit = sum(gross - budget)) %>%
    mutate(profit.multiple = total.profit/total.budget) %>%
    arrange(desc(total.profit)) %>%
    mutate_at(c("total.budget", "total.profit"), .funs = dollar)

# show the result
top_profit
```

    ## # A tibble: 9 x 5
    ##   rating    total.movies total.budget    total.profit    profit.multiple
    ##   <fct>            <int> <chr>           <chr>                     <dbl>
    ## 1 PG-13              604 $40,408,730,000 $98,464,857,713           2.44 
    ## 2 PG                 210 $16,708,400,000 $44,616,448,685           2.67 
    ## 3 R                  675 $18,129,700,000 $36,959,572,585           2.04 
    ## 4 G                   12 $1,356,000,000  $3,979,962,158            2.94 
    ## 5 TV-MA                2 $54,000,000     $646,083,289             12.0  
    ## 6 Not Rated           17 $206,271,228    $555,836,527              2.69 
    ## 7 NC-17                1 $6,500,000      $12,623,767               1.94 
    ## 8 unknown              2 $4,000,000      -$3,099,181              -0.775
    ## 9 Unrated              1 $11,000,000     -$6,366,332              -0.579

``` r
# The film company with the most movies in the horror genre is Dimension Films (18 movies), and the average score of films is 5.63
top_company <- movies %>% 
    filter(genre == "Horror") %>%
    group_by(company, genre) %>%
    summarize(avg.score = mean(score),
              total.movies = n()) %>%
    arrange(desc(total.movies)) %>%
    head(10)
```

``` r
# show the result
top_company
```

    ## # A tibble: 10 x 4
    ## # Groups:   company [10]
    ##    company                   genre  avg.score total.movies
    ##    <chr>                     <fct>      <dbl>        <int>
    ##  1 Dimension Films           Horror      5.63           18
    ##  2 New Line Cinema           Horror      6.04           17
    ##  3 Universal Pictures        Horror      6.04           17
    ##  4 Paramount Pictures        Horror      5.65           11
    ##  5 Warner Bros.              Horror      5.26            8
    ##  6 Columbia Pictures         Horror      5.8             6
    ##  7 Screen Gems               Horror      4.92            6
    ##  8 Lionsgate                 Horror      5.54            5
    ##  9 Metro-Goldwyn-Mayer (MGM) Horror      5.96            5
    ## 10 Twentieth Century Fox     Horror      5.72            5
