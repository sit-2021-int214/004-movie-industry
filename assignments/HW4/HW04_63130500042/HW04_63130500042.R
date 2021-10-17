packages <- c("dplyr","readr","ggplot2","plotly")
lapply(packages, library, character.only = T)

dt <- read_csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

head(dt)
# 2 columns have an inappropriate data type

dbl_col <- c("Reviews", "Number_Of_Pages")
dt <- dt %>%
    dplyr::mutate_at(.vars = dbl_col, .funs = as.integer)

glimpse(dt)
colSums(is.na(dt))
# no N/A value

summary(dt)

# 1
# 2
# 3
# 4
# 5
# 6

hist_p <- dt %>% 
    filter(Price < 150) %>% 
    ggplot() +
    aes(x = Price) + 
    geom_histogram(bins = 10, alpha = 0.7) +
    aes(fill = Type) +
    geom_vline(xintercept = mean(dt$Price), linetype = "dashed") +
    ggtitle("test") +
    theme_bw()
hist_p
ggplotly(hist_p)

scatter_p <- dt %>%
    filter(Number_Of_Pages < 1500 & Price < 150) %>%
    filter(Type == "Hardcover" | Type == "Paperback") %>%
    ggplot() +
    aes(x = Number_Of_Pages, y = Price) +
    aes(color = Rating, size = Reviews) +
    geom_point() + 
    scale_color_distiller(palette = "RdPu") +
    facet_wrap(~Type) +
    geom_hline(yintercept = mean(dt$Price), linetype = "dashed", alpha = 0.5) +
    geom_vline(xintercept = mean(dt$Number_Of_Pages), linetype = "dashed", alpha = 0.5) +
    stat_ellipse() +
    ggtitle("test") +
    theme_bw()
scatter_p
ggplotly(scatter_p)
