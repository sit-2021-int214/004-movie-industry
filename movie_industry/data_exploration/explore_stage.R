packages <- c("dplyr", "readr")
lapply(packages, library, character.only = T)

movies <- read_csv(file = "./movie_industry/csv/cleaned_dataset/movies_cleaned.csv")

glimpse(movies)

# convert data type
movies <- movies %>%
    mutate(year = as.factor(format(year, format = "%Y"))) %>%
    mutate(released.country = as.factor(released.country)) %>%
    mutate_at(.vars = c("genre", "rating", "country"), .funs = as.factor) %>%
    mutate_at(.vars = c("votes", "runtime"), .funs = as.integer)
    
glimpse(movies)
head(movies)
summary(movies)

colSums(is.na(movies))
