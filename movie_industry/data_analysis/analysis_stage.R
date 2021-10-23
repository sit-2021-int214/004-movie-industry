packages <- c("dplyr", "readr", "scales")
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

# Analysis section

# The average profit multiple for each genre of movies from 1980 to 2020, the "Family" genre has the highest average profit multiple at 9.14 times, and the "Western" genre is the lowest at -0.046 times.
movies %>%
    filter(budget != 0 & gross != 0) %>%
    group_by(genre) %>%
    summarise(total.movies = n(), 
              avg.budget = mean(budget),
              avg.profit = mean(gross - budget)) %>%
    mutate(avg.profit.multiple = avg.profit/avg.budget) %>%
    mutate_at(c("avg.budget", "avg.profit"), .funs = dollar)

# The most released movie genre for the first ten years is "Action." After that, until 2020, "Animation" is the most released movie genre.
result <- movies %>%
    group_by(year, genre) %>%
    summarise(total.movies = n(),
              avg.score = mean(score),
              avg.budget = mean(budget),
              avg.gross = mean(gross),
              avg.profit = mean(gross - budget)) %>%
    filter(avg.profit == max(avg.profit)) %>%
    mutate_at(c("avg.budget", "avg.profit", "avg.gross"), .funs = dollar) %>%
    mutate(avg.score = round(avg.score, digits = 2))

# show the result
result
# View(result)

# count the number of movies in the "result"
total.movies <- table(result$genre)
total.movies[total.movies > 0] %>% sort(decreasing = T)

# Comedy movie genres that are released in the United States have the most average score among all genres at 6.16 
movies %>%
    filter(released.country == "United States") %>% 
    group_by(genre) %>%
    summarise(total.movies = n(),
              avg.score = mean(score)) %>%
    filter(total.movies == max(total.movies))

# James Cameron is the PG-13 director that made the highest average profit among the PG-13 director.
movies %>%
    filter(rating == "PG-13") %>%
    filter(budget != 0 & gross != 0) %>%
    group_by(director) %>%
    summarise(total.movies = n(),
              avg.score = mean(score),
              avg.budget = mean(budget),
              avg.profit = mean(gross - budget)) %>%
    mutate(avg.profit.multiple = avg.profit/avg.budget) %>%
    arrange(desc(avg.profit)) %>%
    mutate_at(c("avg.budget", "avg.profit"), .funs = dollar) %>%
    head(10)

# From 1980 to 2020, Woody Allen had the highest directed movie at 38 movies and made $516 million.
most_directed <- movies %>% 
    group_by(director) %>% 
    summarize(total.budget = sum(budget),
              total.profit = sum(gross - budget),
              directed.movies = n()) %>%
    mutate_at(c("total.budget", "total.profit"), .funs = dollar) %>%
    filter(directed.movies == max(directed.movies))

# show the result
most_directed
# View(most_directed)

# The list of directors that directed their movie and have the most average scores is 8.5
avg_score <- movies %>%
    group_by(director) %>%
    summarise(avg.score = mean(score), 
              total.movies = n()) %>%
    filter(avg.score == max(avg.score))

# show the result
avg_score
# View(avg_score)

# These are the top 5 movies from France with the most votes. According to output, Léon: The Professional has the highest vote at 1.1 million.
top_france <- movies %>%
    filter(country == "France") %>%
    select(name, votes) %>%
    arrange(desc(votes)) %>%
    mutate(votes = scales::comma(votes)) %>%
    head(5)

# show the result
top_france
# View(top_france)

# From 2010 to 2020, the PG-13 makes the highest profit, around $98 billion among all ratings. Apart from that, TV-MA has the highest multiple earnings at 12 times.
top_profit <- movies %>% 
    filter(between(year, 2010, 2020)) %>%
    filter(budget != 0 & gross != 0) %>%
    group_by(rating) %>%
    summarize(total.movies = n(),
              total.budget = sum(budget),
              total.profit = sum(gross - budget)) %>%
    mutate(profit.multiple = total.profit/total.budget) %>%
    arrange(desc(total.profit)) %>%
    mutate_at(c("total.budget", "total.profit"), .funs = dollar)

# show the result
top_profit
# View(top_profit)

# The film company with the most movies in the horror genre is Dimension Films (18 movies), and the average score of films is 5.63
top_company <- movies %>% 
    filter(genre == "Horror") %>%
    group_by(company, genre) %>%
    summarize(avg.score = mean(score),
              total.movies = n()) %>%
    arrange(desc(total.movies)) %>%
    head(10)
    
# show the result
top_company
# View(top_company)

