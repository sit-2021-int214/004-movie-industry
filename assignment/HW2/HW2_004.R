packages <- c("DescTools", "MASS")
lapply(packages, library, character.only = T)

head(survey)
# 1
# code

# 2
# code

# 3
# code

# 4
# code

# 5
# code

head(cats)
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
