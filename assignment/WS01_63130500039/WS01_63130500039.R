# 63130500039
# Step 0
library(dplyr)

# Explore

# xxxx


# USEFUL FUNCTION (After finished please remove it) -------------------------
## Stat
sum()
min()
mean()
max()

## Explore
head()      # See 6 observation (rows)
str()       # Structure of object
summary()

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

#-----
library(dplyr)
library(readr)
library(stringr)
library(assertive)

SAT_original <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/SAT_original.csv")

glimpse(SAT_original)
View(SAT_original)

SAT_original %>% duplicated() %>% table()
