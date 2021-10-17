packages <- c("dplyr", "readr")
lapply(packages, library, character.only = T)

# original <- read_csv(file = "./movie_industry/csv/original_dataset/movies_original.csv")
movies <- read_csv(file = "./movie_industry/csv/clean_dataset/movies_clean.csv")

head(movies)
summary(movies)
glimpse(movies)

colSums(is.na(movies))
# no N/A

# convert data type
movies <- movies %>%
    mutate(released.date = as.Date(released.date, format = "%m/%d/%Y")) %>%
    mutate(year = as.factor(format(year, format = "%Y"))) %>%
    mutate(released.country = as.factor(released.country)) %>%
    mutate_at(.vars = c("genre", "rating"), .funs = as.factor) %>%
    mutate_at(.vars = c("votes", "runtime"), .funs = as.integer)

head(movies)
summary(movies)
glimpse(movies)

# Data Exploration (5 Pts)
# Data Cleaning and Data Transformation (10 Pts)
# Data Analysis with Descriptive Statistics (15 Pts)
# Other + Document (5 Pts)

