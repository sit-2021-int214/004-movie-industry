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
glimpse(movies)

# check N/A
na_col <- colSums(is.na(movies))
na_col[na_col > 0]

# analysis section


