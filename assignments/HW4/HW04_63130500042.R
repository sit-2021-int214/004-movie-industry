packages <- c("dplyr","readr","ggplot2","plotly")
lapply(packages, library, character.only = T)

dt <- read_csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

glimpse(dt)

print(colSums(is.na(dt)))
# no N/A value

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
    aes(x = Price, y = Number_Of_Pages) +
    aes(color = Rating, size = Reviews) +
    geom_point() + 
    scale_color_distiller(palette = "RdPu") +
    facet_wrap(~Type, scales = "free") +
    geom_vline(xintercept = mean(dt$Price), linetype = "dashed") +
    geom_hline(yintercept = mean(dt$Number_Of_Pages), linetype = "dashed") +
    ggtitle("test") +
    theme_bw()
scatter_p
ggplotly(scatter_p)
