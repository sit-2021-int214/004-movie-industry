# Data Cleaning and Data Transformation

### Prerequisite
1. If you don't have these packages, then install it first (But, if you already have these   
packages, you can skip this step)
```R
install.packages(c("dplyr", "readr", "stringr", "tidyr"))
```

2. Load these packages (After loaded, you can run every R script below)
```R
packages <- c("dplyr", "readr", "stringr", "tidyr")
lapply(packages, library, character.only = T)
```

### Import dataset
Prepare for cleaning the dataset
```R
original <- read_csv(file = "./movie_industry/csv/original_dataset/movies_original.csv")
```

### Observe the dataset 
```R
head(original)
summary(original)
glimpse(original)
```

### Cleaning Step
1. Separate the released data into released.date and released.country because the stored data can be divided into date and country,
then remove “)” from data stored in released.country
```R
original <- original %>%
    separate(released, c("released.date", "released.country"), " \\(") %>%
    mutate(released.country = str_remove(released.country, "\\)"))
```

2. Replace null data in column “rating”, “writer”, “star”, “country”, “company”, and “released.country” with “unknown”
```R
original <- original %>%
    mutate_at(c("rating", "writer", "star", "country", "company", "released.country"),
    ~replace_na(., "unknown"))
```

3. Replace numeric data type that’s null with 0 
```R
original <- mutate_if(original, is.numeric, ~replace_na(., 0))
```

4. Format released.date to Date , format year to factor , released.country to factor
genre , rating and country format to factor and votes , runtime format to integer.
```R
original <- original %>%
    mutate(released.date = as.Date(released.date, format = "%B %d, %Y")) %>%
    mutate(year = as.factor(format(year, format = "%Y"))) %>%
    mutate(released.country = as.factor(released.country)) %>%
    mutate_at(.vars = c("genre", "rating", "country"), .funs = as.factor) %>%
    mutate_at(.vars = c("votes", "runtime"), .funs = as.integer)
```

### Check data after doing a cleaning
```R
summary(original)
glimpse(original)
colSums(is.na(original))
```

### Check duplicate data
```R
dup_movies_name <- original %>%
    select(name) %>%
    group_by(name) %>%
    filter(n() > 1) %>%
    unique()
```

### Verify data
These are not a duplicate data
```R
dup_movies <- original[FALSE, ]
for (movie in dup_movies_name$name) {
    result <- original %>%
        filter(name == movie)
    dup_movies <- rbind(dup_movies, result)
    result <- original %>%
        select(name, released.date, director, company, runtime, gross) %>%
        filter(name == movie)
    print(result)
}
View(dup_movies)
```

### Export data
After finishing a cleaning step and checking duplicate, then export the file as .csv format
```R
write_csv(original, "movies_clean.csv")
```
