packages <- c("DescTools", "MASS", "dplyr", "formattable")
lapply(packages, library, character.only = T)

View(cats)
print(colSums(is.na(cats))) # count N/A in each column
# 1 From the cats table, max and min heart weight of cats gender.
maxCatM <- max(cats[cats$Sex == 'M', "Hwt"])
maxCatF <- max(cats[cats$Sex == 'F', "Hwt"])
minCatM <- min(cats[cats$Sex == 'M', "Hwt"])
minCatF <- min(cats[cats$Sex == 'F', "Hwt"])

maxHW <- c(maxCatM, maxCatF)
minHW <- c(minCatM, minCatF)

catHW <- cbind(maxHW, minHW)
row.names(catHW) <- c("Male", "Female")
catHW <- as.data.frame(catHW)

# View(catHW)
print(catHW)

# Using dplyr
df_catHW <- cats %>%
  dplyr::select(Sex,Hwt) %>%
  group_by(Sex) %>%
  filter(Sex == "F" | Sex == "M") %>%
  summarise(maxHWT = max(Hwt),minHWT = min(Hwt))
print(df_catHW)

# 2 From the cats table, the percentage of cats gender with both male and female
allMaleCat <- table(cats[cats$Sex == "M", "Sex"])
allFemaleCat <- table(cats[cats$Sex == "F", "Sex"])
allCat <- rbind(allMaleCat, allFemaleCat)

allCat <- colSums(allCat)

totalCatPercent <- round((allCat / sum(allCat)) * 100, digits = 2)
names(totalCatPercent) <- c("Female%", "Male%")
totalCatPercent <- sort(totalCatPercent, decreasing = T)

print(totalCatPercent)

# Using dplyr
df_totalCatPercent <- cats %>%
  dplyr::select(Sex) %>%
  group_by(Sex) %>%
  filter(Sex == "F" | Sex == "M") %>%
  summarise(pct = n()) %>%
  mutate(pct = formattable::percent(pct/sum(pct)))
print(df_totalCatPercent)

# 3 Average body weight of both male and female cats.
avg_bwtm <- round(mean(cats[cats$Sex == "M" , "Bwt"]), digits = 2)
avg_bwtf <- round(mean(cats[cats$Sex == "F" , "Bwt"]), digits = 2)
cat("Average Bwt of Male cats : ", avg_bwtm , "\n")
cat("Average Bwt of Female cats : ", avg_bwtf)
#Using dplyr
cats %>% filter(Sex == "M") %>% summarise(Sex = "Male", Bwt = mean(Bwt)) 
cats %>% filter(Sex == "F") %>% summarise(Sex = "Female" , Bwt = round(mean(Bwt), digits = 2))

# 4 From the cats table, the average of female cat heart weight in grams
avg_hwt_f <- mean(cats[cats$Sex == "F", "Hwt"])
print(avg_hwt_f)

# Using dplyr
cats %>% filter(Sex == "F") %>% summarise(Hwt_F_Avg = mean(Hwt))

# 5 From the cats table, the total weight of female and male cats in kilograms
sum_bwt_female <- sum(cats[cats$Sex == "F", "Bwt"])
sum_bwt_male <- sum(cats[cats$Sex == "M", "Bwt"])
df_sum_bwt <- data.frame(sum_bwt_female, sum_bwt_male)

row.names(df_sum_bwt) <- "total weight"
colnames(df_sum_bwt) <- c("female cats", "male cats")

# View(df_sum_bwt)
print(df_sum_bwt)

# Using dplyr
cats %>% group_by(Sex) %>% summarise(Weight_Sum = sum(Bwt))
