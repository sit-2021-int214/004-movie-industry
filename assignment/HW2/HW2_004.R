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
cat_sex <- data.frame(cats[cats$Sex == "F",])
mean(cat_sex$Hwt)
mean(cat_sex$Hwt)
# 5 sum weight of female and male cats
cat_female <- sum(cats[cats$Sex == "F", "Bwt"])
cat_male <- sum(cats[cats$Sex == "M", "Bwt"])
df <- data.frame(cat_female,cat_male)
row.names(df) <- "Sum of weight"
colnames(df) <- c("female","male")
df
