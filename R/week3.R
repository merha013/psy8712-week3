# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Data Import and Cleaning
raw_df <- read.csv("../data/week3.csv", header=TRUE)
raw_df$timeStart <- as.POSIXct(raw_df$timeStart) #I don't think this actually did anything as the time was already in this format.
raw_df$timeEnd <- as.POSIXct(raw_df$timeEnd) #I don't think this actually did anything as the time was already in this format.
clean_df <- subset(raw_df, raw_df$timeStart>"2017-06-30 23:59:59")
clean_df <- subset(clean_df, clean_df$q6==1)

# Analysis
clean_df$timeSpent <- difftime(time1 = clean_df$timeEnd, time2 = clean_df$timeStart, units = "secs") 
hist(as.numeric(clean_df$timeSpent), main = "Histogram of Time Spent", xlab = "Time Spent")
frequency_tables_list <- lapply()
     