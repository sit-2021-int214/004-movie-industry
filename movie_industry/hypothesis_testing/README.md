Hypothesis testing
================

## Prerequisite

### Loading the necessary packages

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

### Import the dataset

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

### Observe the dataset

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

### Convert to the appropriate datatype

``` r
# convert data type
movies <- movies %>%
    mutate(year = format(year, format = "%Y")) %>%
    mutate(released.country = as.factor(released.country)) %>%
    mutate_at(.vars = c("genre", "rating", "country"), .funs = as.factor) %>%
    mutate_at(.vars = c("votes", "runtime"), .funs = as.integer)
```

### Verifying the datatype

``` r
# verify data type
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

### Summary dataset

``` r
summary(movies)
```

    ##      name                 rating           genre          year          
    ##  Length:7668        R        :3697   Comedy   :2245   Length:7668       
    ##  Class :character   PG-13    :2112   Action   :1705   Class :character  
    ##  Mode  :character   PG       :1252   Drama    :1518   Mode  :character  
    ##                     Not Rated: 283   Crime    : 551                     
    ##                     G        : 153   Biography: 443                     
    ##                     unknown  :  77   Adventure: 427                     
    ##                     (Other)  :  94   (Other)  : 779                     
    ##  released.date              released.country     score           votes        
    ##  Min.   :1980-01-18   United States :6735    Min.   :0.000   Min.   :      0  
    ##  1st Qu.:1991-10-04   United Kingdom: 197    1st Qu.:5.800   1st Qu.:   9100  
    ##  Median :2001-04-20   France        : 148    Median :6.500   Median :  33000  
    ##  Mean   :2001-03-16   Australia     :  48    Mean   :6.388   Mean   :  88074  
    ##  3rd Qu.:2010-11-12   Germany       :  46    3rd Qu.:7.100   3rd Qu.:  93000  
    ##  Max.   :2020-12-25   Japan         :  44    Max.   :9.300   Max.   :2400000  
    ##  NA's   :59           (Other)       : 450                                     
    ##    director            writer              star                     country    
    ##  Length:7668        Length:7668        Length:7668        United States :5475  
    ##  Class :character   Class :character   Class :character   United Kingdom: 816  
    ##  Mode  :character   Mode  :character   Mode  :character   France        : 279  
    ##                                                           Canada        : 190  
    ##                                                           Germany       : 117  
    ##                                                           Australia     :  92  
    ##                                                           (Other)       : 699  
    ##      budget              gross             company             runtime     
    ##  Min.   :        0   Min.   :0.000e+00   Length:7668        Min.   :  0.0  
    ##  1st Qu.:        0   1st Qu.:3.861e+06   Class :character   1st Qu.: 95.0  
    ##  Median : 12000000   Median :1.896e+07   Mode  :character   Median :104.0  
    ##  Mean   : 25513504   Mean   :7.657e+07                      Mean   :107.2  
    ##  3rd Qu.: 32000000   3rd Qu.:7.262e+07                      3rd Qu.:116.0  
    ##  Max.   :356000000   Max.   :2.847e+09                      Max.   :366.0  
    ## 

## Prepare for Hypothesis testing

-   Define the problems
-   Define the confidence level for your problems
-   Null hypothesis & Alternative hypothesis

**Problem** <br> The film director claims that making an action movie
can earn $145.51 million or more, but the marketing department
calculates the earnings of 500 random action movies over the years. The
average earned only $129.58 million. The population standard deviation
is $247.52 million. At a significance level of 95%, is it possible that
the marketing department could reject the director from making the
action film?

1.  Count an action movie in dataset

``` r
pop.n <- movies %>%
    filter(gross > 0) %>%
    group_by(genre) %>%
    summarise(count = n()) %>%
    filter(genre == "Action")

pop.n %>%
    mutate(count = scales::comma(count))
```

    ## # A tibble: 1 x 2
    ##   genre  count
    ##   <fct>  <chr>
    ## 1 Action 1,673

``` r
pop.n <- pop.n$count
```

2.  Finding the population mean gross of an action movie

``` r
pop.mean <- movies %>%
    filter(gross > 0) %>%
    group_by(genre) %>%
    summarise(pop.mean.gross = mean(gross)) %>%
    filter(genre == "Action")

pop.mean %>%
    mutate(pop.mean.gross = scales::dollar(pop.mean.gross))
```

    ## # A tibble: 1 x 2
    ##   genre  pop.mean.gross
    ##   <fct>  <chr>         
    ## 1 Action $145,508,581

``` r
pop.mean <- round(pop.mean$pop.mean.gross, 2)
```

3.  Finding the population mean gross of an action movie

``` r
pop.sd <- movies %>%
    filter(gross > 0) %>%
    group_by(genre) %>%
    summarise(pop.sd.gross = sd(gross)) %>%
    filter(genre == "Action")
pop.sd %>%
    mutate(pop.sd.gross = scales::dollar(pop.sd.gross))
```

    ## # A tibble: 1 x 2
    ##   genre  pop.sd.gross
    ##   <fct>  <chr>       
    ## 1 Action $247,515,833

``` r
pop.sd <- round(pop.sd$pop.sd.gross, 2)
```

4.  Define the sample size

``` r
sample.n <- 500
```

5.  Finding the sample mean gross of an action movie

``` r
sample.data <- movies %>%
    filter(gross > 0) %>%
    filter(genre == "Action") %>%
    select(name, gross)

sample.mean <- mean(sample.data$gross[sample(1:nrow(sample.data), sample.n)])
sample.mean <- round(sample.mean, 2)
```

``` r
scales::dollar(sample.mean)
```

    ## [1] "$129,582,717"

6.  Define the confidence level for the hypothesis testing <br> So, we
    will use 95% confidence level

``` r
alpha <- 0.05
```

## Hypothesis testing

1.  State the null and alternative hypothesis from the problem

    -   Ho: u >= $145.51 Million <br>
    -   Ha: u \< $145.51 Million

    this is the left-tailed test

2.  finding the z alpha

``` r
z.alpha <- qnorm(alpha)
z.alpha
```

    ## [1] -1.644854

3.  Calculating the standard error

``` r
SE <- pop.sd/sqrt(sample.n)
SE
```

    ## [1] 11069245

4.  Calculating the z.c

``` r
z.c <- (sample.mean - pop.mean)/SE
z.c
```

    ## [1] -1.438749

5.  Finding the p-value

``` r
p.value <- pnorm(z.c)
p.value
```

    ## [1] 0.07511084

6.  Testing the hypothesis by z-test or p-value

``` r
# by z-test
if (z.c >= z.alpha) {
    print("Failed to reject Ho")
} else {
    print("Reject Ho")
}
```

    ## [1] "Failed to reject Ho"

``` r
# by p-value
if (p.value >= alpha) {
    print("Failed to reject Ho")
} else {
    print("Reject Ho")
}
```

    ## [1] "Failed to reject Ho"

7.  Conclusion

The marketing department cannot refuse a director’s request to make an
action movie.
