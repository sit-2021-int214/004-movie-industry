packages <- c("dplyr", "readr")
lapply(packages, library, character.only = T)

movies <- read_csv(file = "./movie_industry/csv/clean_dataset/movies_clean.csv")

head(movies)
glimpse(movies)

colSums(is.na(movies))
