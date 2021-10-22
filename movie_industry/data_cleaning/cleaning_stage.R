packages <- c("dplyr", "readr", "stringr", "tidyr")
lapply(packages, library, character.only = T)

original <- read_csv(file = "./movie_industry/csv/original_dataset/movies_original.csv")

head(original)
summary(original)
glimpse(original)

original <- original %>%
    separate(released, c("released.date", "released.country"), " \\(") %>%
    mutate(released.country = str_remove(released.country, "\\)"))

original <- original %>%
    mutate_at(c("rating", "writer", "star", "country", "company", "released.country"),
              ~replace_na(., "unknown"))

original <- mutate_if(original, is.numeric, ~replace_na(., 0))

original <- original %>%
    mutate(released.date = as.Date(released.date, format = "%B %d, %Y")) %>%
    mutate(year = as.factor(format(year, format = "%Y"))) %>%
    mutate(released.country = as.factor(released.country)) %>%
    mutate_at(.vars = c("genre", "rating", "country"), .funs = as.factor) %>%
    mutate_at(.vars = c("votes", "runtime"), .funs = as.integer)

summary(original)
glimpse(original)
colSums(is.na(original))

# check duplicate data
dup_movies_name <- original %>%
    select(name) %>%
    group_by(name) %>%
    filter(n() > 1) %>%
    unique()

# verify these are not a duplicate data
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

write_csv(original, "movies_clean.csv")
# move to csv folder

