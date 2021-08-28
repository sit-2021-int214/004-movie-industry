packages <- c("DescTools", "MASS")
lapply(packages, library, character.only = T)

View(survey)
print(colSums(is.na(survey))) # count N/A in each column
# 1 From the survey table, the number of male and female students that use left and right hands to write
male_wHnd <- table(survey[survey$Sex == "Male", "W.Hnd"])
female_wHnd <- table(survey[survey$Sex == "Female", "W.Hnd"])
df_wHnd <- rbind(male_wHnd, female_wHnd)
total <- colSums(df_wHnd)
df_wHnd <- rbind(df_wHnd, total)

df_wHnd <- as.data.frame(df_wHnd) # table -> data frame
df_wHnd <- cbind.data.frame(df_wHnd, rowSums(df_wHnd))

row.names(df_wHnd)[1:2] <- c("male", "female")
colnames(df_wHnd)[length(df_wHnd)] <- "total"

# View(df_wHnd)
print(df_wHnd)

# 2 From the survey table, the percentage of students write with both left and right hands
total_percentage <- round((total/sum(total)) * 100, digits = 2) # "total" from item 1
names(total_percentage) <- c("Left(%)", "Right(%)")

print(total_percentage)

# 3 From the survey table, the number of people in each gender
print(table(survey$Sex))

# 4 From the survey table, the frequency percentage of students who smoke
smoke_df <- as.data.frame(table(survey$Smoke))
colnames(smoke_df) <- c("freq", "percentage")
smoke_df <- smoke_df[order(factor(smoke_df$freq, levels = c("Never", "Occas", "Regul", "Heavy"))), ]
row.names(smoke_df) <- c(1:length(smoke_df$freq))

percentage <- round((smoke_df$percentage/sum(smoke_df$percentage)) * 100, digits = 3)
smoke_df$percentage <- percentage

# View(smoke_df)
print(smoke_df)

# 5 Average Wr.Hand (span of writing hand, in cm) of females
wrF <- mean(survey$Wr.Hnd[which(survey$Sex == "Female")])
mean_WrF <- round(wrF, digits = 2)
cat("Average span of female writing hand, in cm:",mean_WrF)

View(cats)
print(colSums(is.na(cats))) # count N/A in each column
# 1 From the cats table, max and min heart weight of cats gender.
maxCatM <- max(cats[cats$Sex == 'M',"Hwt"])
maxCatF <- max(cats[cats$Sex == 'F',"Hwt"])
minCatM <- min(cats[cats$Sex == 'M',"Hwt"])
minCatF <- min(cats[cats$Sex == 'F',"Hwt"])

maxHW <- c(maxCatM,maxCatF)
minHW <- c(minCatM,minCatF)

catHW <- cbind(maxHW,minHW)
row.names(catHW) <- c("Male","Female")
catHW <- as.data.frame(catHW)

# View(catHW)
print(catHW)

# 2 From the cats table, the percentage of cats gender with both male and female
allMaleCat <- table(cats[cats$Sex == "M", "Sex"])
allFemaleCat <- table(cats[cats$Sex == "F", "Sex"])
allCat <- rbind(allMaleCat,allFemaleCat)

allCat <- colSums(allCat)

totalCatPercent <- round((allCat/sum(allCat)) * 100, digits = 2 )
names(totalCatPercent) <- c("Female%", "Male%")
totalCatPercent <- sort(totalCatPercent, decreasing = T)

print(totalCatPercent)

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
