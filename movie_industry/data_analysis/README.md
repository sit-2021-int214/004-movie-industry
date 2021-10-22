Data Analysis with Descriptive Statistics
================

### Import nesessary packages

``` r
packages <- c("dplyr", "readr")
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

    ## [[1]]
    ## [1] "dplyr"     "stats"     "graphics"  "grDevices" "utils"     "datasets" 
    ## [7] "methods"   "base"     
    ## 
    ## [[2]]
    ## [1] "readr"     "dplyr"     "stats"     "graphics"  "grDevices" "utils"    
    ## [7] "datasets"  "methods"   "base"

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
    mutate(year = as.factor(format(year, format = "%Y"))) %>%
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
    ## $ year             <fct> 1980, 1980, 1980, 1980, 1980, 1980, 1980, 1980, 1980,~
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
