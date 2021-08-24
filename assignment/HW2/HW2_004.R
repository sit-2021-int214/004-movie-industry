packages <- c("DescTools", "MASS")
lapply(packages, library, character.only = T)

View(survey)
# 1 find something ... i don't know ha ha
male_wHnd <- table(survey[survey$Sex == "Male", "W.Hnd"])
female_wHnd <- table(survey[survey$Sex == "Female", "W.Hnd"])
df_wHnd <- rbind(male_wHnd, female_wHnd)
total <- colSums(df_wHnd)
df_wHnd <- rbind(df_wHnd, total)
df_wHnd <- as.data.frame(df_wHnd)
df_wHnd <- cbind.data.frame(df_wHnd, rowSums(df_wHnd))
row.names(df_wHnd)[1:2] <- c("male", "female")
colnames(df_wHnd)[length(df_wHnd)] <- "total"
total_percentage <- round((total/sum(total)) * 100, digits = 2)
print(df_wHnd)
cat("total Left(%):", total_percentage["Left"])
cat("total Right(%):", total_percentage["Right"])

# 2F
# code

# 3
# code

# 4
# code

# 5
# code

View(cats)
# 1
# code

# 2
# code

# 3
# code

# 4 mean Hwt
avg_hwt_f <- mean(cats[cats$Sex == "F", "Hwt"])
print(avg_hwt_f)

# 5 sum weight of female and male cats
sum_bwt_female <- sum(cats[cats$Sex == "F", "Bwt"])
sum_bwt_male <- sum(cats[cats$Sex == "M", "Bwt"])
df_sum_bwt <- data.frame(sum_bwt_female, sum_bwt_male)
row.names(df_sum_bwt) <- "Sum of weight"
colnames(df_sum_bwt) <- c("female", "male")
print(df_sum_bwt)
