# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # rstudioapi won't be loaded, only this feature. Set's the location of the working directory to the location of the active R file. Check with getwd()

# Data Import and Cleaning
raw_df <- read.csv("../data/week3.csv", header=TRUE)
raw_df$timeStart <- as.POSIXct(raw_df$timeStart, tz = "GMT", format = "%Y-%m-%d %H:%M:%S") 
raw_df$timeEnd <- as.POSIXct(raw_df$timeEnd, tz = "GMT", format = "%Y-%m-%d %H:%M:%S")
clean_df <- subset(raw_df, raw_df$timeStart>"2017-06-30 23:59:59")
clean_df <- subset(clean_df, clean_df$q6==1)

# Analysis
clean_df$timeSpent <- difftime(time1 = clean_df$timeEnd, time2 = clean_df$timeStart, units = "secs") 
hist(as.numeric(clean_df$timeSpent), main = "Histogram of Time Spent", xlab = "Time Spent (in seconds)")
frequency_tables_list <- lapply(clean_df[,5:14], table)
lapply(frequency_tables_list, barplot) 
nrow(subset(clean_df, ((clean_df$q1>=clean_df$q2) & (clean_df$q2 != clean_df$q3))))
for (i in frequency_tables_list)
  barplot(i)


# Alternatives
clean_df2 <- subset(raw_df, subset=!raw_df$timeStart <= "2017-06-30")
clean_df3 <- raw_df[raw_df$timeStart >= "2017-07-01 00:00:00" | raw_df$timeStart < "2017-06-01 00:00:00", ]
clean_df4 <- raw_df[raw_df$timeStart >= "2017-07-01 00:00:00",]

# new total time calculation
# clean_df$timeSpent <- (clean_df$timeStart-clean_df$timeEnd)*60
# for barplot
barplot(frequency_tables_list[[1]])
sum(clean_df$q1 >= clean_df$q2 & clean_df$q2 != clean_df$q3)