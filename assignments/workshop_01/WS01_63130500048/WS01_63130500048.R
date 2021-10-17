# 63130500048
# Step 0
library("dplyr","readr","assertive","stringr")

sat_score <- read_csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/SAT_original.csv")
View(sat_score)
# Explore

# xxxx

#Define a question
#1. How many observation of this dataset (before cleaning) ?

#2. Are there duplicate data sets ? (If have duplicate data, list the data that duplicate)

#3. How many distinct school in this dataset ? (Know after drop duplicate data)

#4. What is min, max, average, quartile of each part in SAT ?

#5. What is min, max, average, quartile of total score in SAT ?

#6. Which school is get highest SAT score ?




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