library(dplyr, readr, ggplot2)

ComSci_book <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

View(ComSci_book)

#Part A
#1. Explore the dataset
glimpse(ComSci_book)

#2. Transform data with dplyr and finding insight the data

##Average rating of each book type

ComSci_rating_type <- ComSci_book %>% 
  select(Type, Rating) %>% 
  group_by(Type) %>% 
  summarise(Rating = mean(Rating, na.rm = T))

ComSci_rating_type

##Most type of top 270 book
ComSci_most_type <- ComSci_book %>% 
  group_by(Type) %>% 
  summarise(most_type = n()) %>%
  filter(most_type == max(most_type))
            
ComSci_most_type

##Type of book that rating has under overall average
avgRating <- ComSci_book %>%
  summarise(avg_rating = mean(Rating, na.rm = T))

ComSci_avg_rating <- ComSci_book %>% 
  select(Type, Rating) %>%
  group_by(Type) %>%
  summarise(avg_Rtype = mean(Rating, na.rm = T)) %>%
  filter(avg_Rtype < avgRating$avg_rating)

ComSci_avg_rating

##Price at quantile 25% of each type except type "Boxed Set - Hardcover" 

ComSci_quantile_price <- ComSci_book %>% 
  select(Type, Price) %>% 
  group_by(Type) %>% 
  summarise(q_price = quantile(Price,0.25)) %>%
  filter(Type != "Boxed Set - Hardcover")
  
ComSci_quantile_price

##Amount of book type and total price of each type
ComSci_amount_type <- ComSci_book %>% 
  group_by(Type) %>%
  summarise(Amount_type = n(), Price = round(sum(Price), digits = 0))

ComSci_amount_type

##Overall average rating and overall average pages
rating_pages_avg <- ComSci_book %>% 
  summarise(Avg_rating = round(mean(Rating), digits = 0), Avg_pages = round(mean(Number_Of_Pages), digits = 0))

rating_pages_avg

#scatter plot of rating and price.

sc <- ComSci_book %>%
  ggplot(aes(x = Rating, y = Number_Of_Pages)) + 
  geom_point(aes(color = Type)) +
  xlab("Rating") +
  ylab("Pages") +
  ggtitle("Correlation of Rating and Price")

sc+geom_smooth()          

#pie chart of amount of type
pie <- ComSci_book %>% 
  ggplot(aes(x = "" , fill = factor(Type))) +
  geom_bar(width = 1) +
  theme(axis.line = element_blank(), 
        plot.title = element_text(hjust=0.5)) + 
  labs(fill="Type", 
       x=NULL, 
       y=NULL, 
       title="Amount of Type")

pie + coord_polar(theta = "y", start=0)
