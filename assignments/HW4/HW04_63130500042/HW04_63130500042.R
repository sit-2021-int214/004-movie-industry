packages <- c("dplyr","readr","ggplot2","plotly")
lapply(packages, library, character.only = T)

dt <- read_csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

head(dt)
# 2 columns have an inappropriate data type

dbl_col <- c("Reviews", "Number_Of_Pages")
dt <- dt %>%
    mutate_at(.vars = dbl_col, .funs = as.integer) %>%
    mutate(Type = as.factor(Type))

glimpse(dt)
colSums(is.na(dt))
# no N/A value

summary(dt)

# 1
dt %>%
    dplyr::filter(Rating > quantile(dt$Rating, 0.75)) %>%
    dplyr::select(Type) %>%
    dplyr::group_by(Type) %>%
    count(.) %>%
    dplyr::rename(amount = n) %>%
    dplyr::arrange(desc(amount))
    
# 2
dt
    
# 3
# 4
# 5
# 6

hist_p <- dt %>% 
    # filter(Price < 150) %>% 
    ggplot() +
    aes(x = Rating) + 
    geom_histogram(binwidth = 0.2) +
    aes(fill = Type) +
    geom_vline(xintercept = mean(dt$Rating), linetype = "dashed") +
    scale_x_continuous(breaks = seq(min(dt$Rating), max(dt$Rating), 0.2)) +
    scale_y_continuous(breaks = seq(0, 100, 10)) +
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
    scale_x_continuous(breaks = seq(0, 1200, 200)) +
    scale_y_continuous(breaks = seq(0, 150, 10)) +
    stat_ellipse() +
    ggtitle("test") +
    theme_bw()
scatter_p
ggplotly(scatter_p)
