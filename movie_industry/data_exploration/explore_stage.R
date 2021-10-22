packages <- c("dplyr", "readr")
lapply(packages, library, character.only = T)

movies <- read_csv(file = "./movie_industry/csv/cleaned_dataset/movies_cleaned.csv")

# observe dataset and data type
glimpse(movies)

# convert data type
movies <- movies %>%
    mutate(year = format(year, format = "%Y")) %>%
    mutate(released.country = as.factor(released.country)) %>%
    mutate_at(.vars = c("genre", "rating", "country"), .funs = as.factor) %>%
    mutate_at(.vars = c("votes", "runtime"), .funs = as.integer)

# explore section
glimpse(movies)

# check the top of dataset
head(movies)

# summary all of data
summary(movies)

# check N/A
colSums(is.na(movies))
