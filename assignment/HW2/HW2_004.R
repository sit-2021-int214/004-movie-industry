packages <- c("DescTools", "MASS")
lapply(packages, library, character.only = T)

View(survey)
# 1 From the survey table, the number of male and female students that use left and right hands to write
male_wHnd <- table(survey[survey$Sex == "Male", "W.Hnd"])
female_wHnd <- table(survey[survey$Sex == "Female", "W.Hnd"])
df_wHnd <- rbind(male_wHnd, female_wHnd)
total <- colSums(df_wHnd)
df_wHnd <- rbind(df_wHnd, total)

df_wHnd <- as.data.frame(df_wHnd) # matrix -> data frame
df_wHnd <- cbind.data.frame(df_wHnd, rowSums(df_wHnd))

row.names(df_wHnd)[1:2] <- c("male", "female")
colnames(df_wHnd)[length(df_wHnd)] <- "total"

# View(df_wHnd)
print(df_wHnd)

# 2 From the survey table, the percentage of students write with both left and right hands
total_percentage <- round((total/sum(total)) * 100, digits = 2) # "total" from item 1
names(total_percentage) <- c("Left(%)", "Right(%)")

print(total_percentage)

# 3 number of people in each gender
table(survey$Sex)

# 4 Average age for each gender
aggregate(survey$Age, list(survey$Sex), FUN=mean)

# 5 Average Wr.Hand of females
WrF <- sum(survey$Wr.Hnd[which(survey$Sex == "Female")])
AllF <- length(survey$Sex[survey$Sex == "Female"])
mean_WrF <- round(WrF/AllF , digits = 2)
cat("Average Female age:",mean_WrF)

View(cats)
# 1
# code

# 2
# code

# 3 Average body weight of both male and female cats.
avg_bwtm <- round(mean(cats[cats$Sex == "M" , "Bwt"]), digits = 2)
avg_bwtf <- round(mean(cats[cats$Sex == "F" , "Bwt"]), digits = 2)
cat("Average Bwt of Male cats : ", avg_bwtm ,"\n")
cat("Average Bwt of Female cats : ", avg_bwtf)

# 4 From the cats table, the average of female cat heart weight in grams
avg_hwt_f <- mean(cats[cats$Sex == "F", "Hwt"])
print(avg_hwt_f)

# 5 From the cats table, the total weight of female and male cats in kilograms
sum_bwt_female <- sum(cats[cats$Sex == "F", "Bwt"])
sum_bwt_male <- sum(cats[cats$Sex == "M", "Bwt"])
df_sum_bwt <- data.frame(sum_bwt_female, sum_bwt_male)

row.names(df_sum_bwt) <- "total weight"
colnames(df_sum_bwt) <- c("female cats", "male cats")

# View(df_sum_bwt)
print(df_sum_bwt)
