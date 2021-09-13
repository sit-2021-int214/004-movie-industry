packages <- c("dplyr","readr","assertive","stringr")
lapply(packages, library, character.only = T)

SAT_original <- read_csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/SAT_original.csv")
View(SAT_original)

duplicated_data <- as.data.frame(table(SAT_original$school_name)[table(SAT_original$school_name) > 1])
colSums(is.na(SAT_original))

SAT <- glimpse(distinct(SAT_original))

temp <- SAT[!is.na(str_match(SAT$DBN, "/")), ]
temp <- temp %>%
    select(DBN, school_name) %>%
    mutate(DBN = str_split(DBN, "/")) %>%
    mutate(school_name = str_split(school_name, "/"))
temp <- cbind(cbind(unlist(temp$DBN)), unlist(temp$school_name))
colnames(temp) <- c("DBN", "school_name")
temp <- temp %>%
    as.data.frame(temp) %>%
    arrange(DBN)
temp <- cbind(temp, SAT[!is.na(str_match(SAT$DBN, "/")), 3:5])
SAT <- SAT[is.na(str_match(SAT$DBN, "/")), ]
SAT <- SAT %>% 
    rbind(temp) %>% 
    arrange(DBN)
