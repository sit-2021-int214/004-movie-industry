packages <- c("DescTools", "MASS", "dplyr", "formattable")
lapply(packages, library, character.only = T)

View(survey)
print(colSums(is.na(survey))) # count N/A in each column
# 1 From the survey table, the number of male and female students that use left and right hands to write
male_wHnd <- table(survey[survey$Sex == "Male", "W.Hnd"])
female_wHnd <- table(survey[survey$Sex == "Female", "W.Hnd"])
df_wHnd <- rbind(male_wHnd, female_wHnd)

df_wHnd <- as.data.frame(df_wHnd) # table -> data frame

row.names(df_wHnd) <- c("male", "female")

# View(df_wHnd)
print(df_wHnd)

# Using dplyr
df_wHnd_dplyr <- survey %>% 
    group_by(Sex) %>%
    dplyr::select(Sex, W.Hnd) %>%
    filter(Sex == "Male" | Sex == "Female", W.Hnd == "Left" | W.Hnd == "Right") %>%
    count(W.Hnd) %>%
    dplyr::rename(amount = n)
print(df_wHnd_dplyr)

# 2 From the survey table, the percentage of students write with both left and right hands
total <- colSums(df_wHnd) # "df_wHnd" from item 1
total_percentage <- round((total/sum(total)) * 100, digits = 2)
names(total_percentage) <- c("Left(%)", "Right(%)")

print(total_percentage)

# Using dplyr
df_total_pct <- survey %>%
    filter(!is.na(W.Hnd), !is.na(Sex)) %>%
    group_by(W.Hnd) %>%
    dplyr::select(W.Hnd) %>%
    dplyr::rename(hand = W.Hnd) %>%
    summarise(amount = sum(!is.na(hand))) %>%
    mutate(amount = formattable::percent(amount/sum(amount))) %>%
    dplyr::rename(pct = amount)
print(df_total_pct)

# 3 From the survey table, the number of people in each gender
print(table(survey$Sex))

# Using dplyr
# code here

# 4 From the survey table, the frequency percentage of students who smoke
smoke_df <- as.data.frame(table(survey$Smoke))
colnames(smoke_df) <- c("freq", "percentage")
smoke_df <- smoke_df[order(factor(smoke_df$freq, levels = c("Never", "Occas", "Regul", "Heavy"))), ]
row.names(smoke_df) <- c(1:length(smoke_df$freq))

percentage <- round((smoke_df$percentage/sum(smoke_df$percentage)) * 100, digits = 3)
smoke_df$percentage <- percentage

# View(smoke_df)
print(smoke_df)

# Using dplyr
# code here

# 5 Average Wr.Hand (span of writing hand, in cm) of females
wrF <- mean(survey$Wr.Hnd[which(survey$Sex == "Female")])
mean_WrF <- round(wrF, digits = 2)
cat("Average span of female writing hand, in cm:",mean_WrF)

# Using dplyr
# code here
