# Data Exploration

### Prerequisite

1. If you don't have these packages, then install it first (But, if you already have these packages, you can skip this step)
```R
install.packages(c("dplyr", "readr"))
```

2. Load these packages (After loaded, you can run every R script below)
```R
packages <- c("dplyr", "readr")
lapply(packages, library, character.only = T)
```

### Import cleaned dataset

For check what happened after cleaning the dataset
```R
movies <- read_csv(file = "./movie_industry/csv/cleaned_dataset/movies_cleaned.csv")
```

### Check the data type

Find an inappropriate data type
```R
glimpse(movies)
```

### Convert an inappropriate data type

```R
movies <- movies %>%
    mutate(year = as.factor(format(year, format = "%Y"))) %>%
    mutate(released.country = as.factor(released.country)) %>%
    mutate_at(.vars = c("genre", "rating", "country"), .funs = as.factor) %>%
    mutate_at(.vars = c("votes", "runtime"), .funs = as.integer)
```

### Explore the dataset

checking and exploring a summary of dataset
```R
glimpse(movies)
head(movies)
summary(movies)
```

### Check N/A value

check N/A value each column
```R
colSums(is.na(movies))
```

### N/A value in "released.date"

Because the data type of this column is a date, we want to simplify, which means that no other data can be replaced for understanding other than the date data type.
So we still keep the N/A value.

