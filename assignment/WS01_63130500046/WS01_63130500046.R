
# 63130500046
# Step 0
library(dplyr)
sat_score <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/SAT_original.csv")

## Explore
sat_score %>% head()      # See 6 observation (rows)
sat_score %>% str()       # Structure of object
sat_score %>% summary()

## dplyr package
glimpse()
select()
filter()
arrange()
mutate()
group_by()
summarise()
count()

## Cleaning
as.vector()
as.numeric()
na.omit()
is.na()
replace()
distinct()
duplicated()

#assertive package
assert_is_numeric()
assert_all_are_in_closed_range()

#1.How many observation of this dataset (before cleaning) ?
sat_score %>% str()
#Ans. there are 485 observation in this dataset. Variables are DBN , school_name , math_score , reading_score , writing_score

#2.Are there duplicate data sets ? (If have duplicate data, list the data that duplicate)
sat_score %>% duplicated() %>% summary()
#Yes there are duplicate data.
sat_score %>% filter(duplicated(sat_score))

#3.How many distinct school in this dataset ? (Know after drop duplicate data)
#4.What is min, max, average, quartile of each part in SAT ?
#5.What is min, max, average, quartile of total score in SAT ?
#6.Which school is get highest SAT score ?