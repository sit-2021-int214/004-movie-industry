packages <- c("dplyr", "readr", "ggplot2", "scales", "stringr")
lapply(packages, library, character.only = T)

dt <- read_csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

head(dt)
# 2 columns have an inappropriate data type

dt <- dt %>%
    mutate_at(.vars = c("Reviews", "Number_Of_Pages"), 
              .funs = as.integer) %>%
    mutate(Type = as.factor(Type))

# verify & explore
glimpse(dt)

# check N/A value
colSums(is.na(dt))

# explore & summary
summary(dt)

# 1
result <- dt %>%
    filter(Rating < quantile(Rating, 0.1)) %>%
    group_by(Type) %>%
    summarise(amount = n(),
              avg.rating = mean(Rating),
              avg.price = mean(Price)) %>%
    arrange(desc(amount))

# view
result %>% mutate(avg.price = scales::dollar(avg.price))

# output
result %>% summarise(total = sum(amount))

# 2
cplus_table <- dt %>%
    filter(str_detect(Book_title, pattern = "(C|c)\\+\\+")) %>%
    select(-Description, -Reviews, -Type) %>%
    mutate(price.per.page = Price/Number_Of_Pages) %>%
    arrange(price.per.page)

# view
cplus_table %>% mutate(Price = scales::dollar(Price))

# output
cplus_table %>% 
    mutate(Price = scales::dollar(Price)) %>%
    filter(price.per.page == min(price.per.page))

# 3
py_table <- dt %>%
    filter(str_detect(Book_title, pattern = "(P|p)ython")) %>%
    select(-Description, -Reviews, -Type) %>%
    arrange(desc(Rating))

# view
py_table %>% mutate(Price = scales::dollar(Price))

# output
py_table %>% 
    filter(Rating < quantile(Rating, 0.25)) %>%
    mutate(Price = scales::dollar(Price)) %>%
    arrange(Rating)

# 4
game_table <- dt %>%
    filter(str_detect(Book_title, pattern = "(G|g)ame")) %>%
    select(-Description, -Reviews) %>%
    arrange(desc(Price))

# view
game_table %>% mutate(Price = scales::dollar(Price))

# output
game_table %>%
    filter(boxplot.stats(game_table$Price)$out == Price) %>%
    mutate(Price = scales::dollar(Price))

# 5
algo_table <- dt %>%
    filter(str_detect(Book_title, pattern = "(A|a)lgorithm")) %>%
    select(-Description, -Reviews) %>%
    group_by(Type) %>%
    summarise(amount = n(),
              avg.rating = mean(Rating),
              avg.price = mean(Price))

# view
algo_table %>% mutate(avg.price = scales::dollar(avg.price))

# output
algo_table %>%
    filter(amount == max(amount)) %>%
    mutate(avg.price = scales::dollar(avg.price))

# 6
dt %>%
    select(-Reviews, -Description) %>%
    filter(Price > quantile(Price, 0.9)) %>%
    group_by(Type) %>%
    summarise(amount = n(),
              avg.rating = mean(Rating),
              avg.price = mean(Price)) %>%
    arrange(desc(amount)) %>%
    mutate(avg.price = scales::dollar(avg.price))
    
# plot 1
hist_p <- dt %>% 
    ggplot(aes(x = Rating)) + 
    geom_histogram(binwidth = 0.2) +
    aes(fill = Type) +
    geom_vline(xintercept = mean(dt$Rating), linetype = "dashed") +
    scale_x_continuous(breaks = seq(3, 5, 0.2)) +
    scale_y_continuous(breaks = seq(0, 100, 10)) +
    labs(title = "Frequency of books in rating",
         caption = "dashed line = mean line",
         tag = "Fig. 1") +
    theme_bw()

# view
hist_p

# plot 2
scatter_p <- dt %>%
    filter(Number_Of_Pages < 1500 & Price < 150) %>%
    filter(Type == "Hardcover" | Type == "Paperback") %>%
    ggplot(aes(x = Number_Of_Pages, y = Price)) +
    aes(color = Rating, size = Reviews) +
    geom_point() + 
    scale_color_distiller(palette = "RdPu") +
    facet_wrap(~Type) +
    geom_hline(yintercept = mean(dt$Price), linetype = "dashed", alpha = 0.5) +
    geom_vline(xintercept = mean(dt$Number_Of_Pages), linetype = "dashed", alpha = 0.5) +
    scale_x_continuous(breaks = seq(0, 1200, 200)) +
    scale_y_continuous(breaks = seq(0, 150, 10)) +
    stat_ellipse() +
    labs(title = "The correlation of Price and Number of Pages", 
         subtitle = "Comparison between the correlation of Price and Number of Pages in Hardcover and Paperback",
         caption = "dashed line = mean line",
         tag = "Fig. 2") +
    theme_bw()

# view view
scatter_p
