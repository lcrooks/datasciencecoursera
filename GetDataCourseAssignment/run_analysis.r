## Getting Data: Course Assignment
## Louise Crooks, 11/18/2014
## Run Analysis
## Goals: 
## 1) Merge training and test sets to create one data set
## 2) Extract only the measure on the mean and stdev for each signal
## 3) Use descriptive activity names
## 4) Label the dataset with descriptive variable names
## 5) From the dataset, create second independent data set with the average 
##    of each variable for each activity and each subject

## Libraries
library(data.table)
library(plyr)

## Source file came from this location: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## setwd("D:\\R Workspace\\Getting Data\\Course Assignment\\")
strURLforData = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
strLocalFile = "ZipDataset.zip"
##if (file.exists(strLocalFile)) { file.remove(strLocalFile) }
##download.file(url = strURLforData, destfile = strLocalFile, quiet = TRUE)
##unzip(strLocalFile, overwrite = TRUE, setTimes = FALSE)

strDataFolder = "UCI HAR Dataset"

activities <- read.table(paste(strDataFolder, "\\activity_labels.txt", sep=""))
names(activities)[1] = "activity"
names(activities)[2] = "activityName"

features <- read.table(paste(strDataFolder, "\\features.txt", sep=""))
## create a column for the row ID
features$colN <- with(features, paste("V", as.character(V1), sep=""))
## get only the mean and std meaures
features$mean <- with(features, grepl("mean()", V2))
features$std <- with(features, grepl("std()", V2))
## create a char vector to select only the mean and std measures
selfeatures <- subset(features, mean | std, select = c(colN, V2))
cSelectedV1 <- as.character(selfeatures$colN)
cSelectedV1 <- c(cSelectedV1)
cSelectedV2 <- as.character(selfeatures$V2)
cSelectedV2 <- c(cSelectedV2)

## TRAIN
sub <- read.table(paste(strDataFolder, "\\train\\subject_train.txt", sep=""))
names(sub)[1]="subject"
sub$ID <- with(sub, as.numeric(row.names(sub)))

y <- read.table(paste(strDataFolder, "\\train\\y_train.txt", sep=""))
names(y)[1]="activity"
y$ID <- with(y, as.numeric(row.names(y)))
y <- merge(activities, y, by="activity", all.y="TRUE", all.x="TRUE")

x <- read.table(paste(strDataFolder, "\\train\\x_train.txt", sep="")) ## this statement takes a minute to read in
## select only mean and std measures
x <- x[cSelectedV1]
## name the columns after the features doc
names(x) <- cSelectedV2
x$ID <- with(x, as.numeric(row.names(x)))

## merge all three together
train <- merge(sub, y, by="ID", all.y="TRUE")
train <- subset(train, , select = c(ID, subject, activity, activityName)) ## have to remove the extra ID field from the merged set
train <- merge(train, x, by="ID", all.y="TRUE")
train$src <- "train"

## clean-up
rm(sub); rm(y); rm(x);

## TEST
sub <- read.table(paste(strDataFolder, "\\test\\subject_test.txt", sep=""))
names(sub)[1]="subject"
sub$ID <- with(sub, as.numeric(row.names(sub)))

y <- read.table(paste(strDataFolder, "\\train\\y_train.txt", sep=""))
names(y)[1]="activity"
y$ID <- with(y, as.numeric(row.names(y)))
y <- merge(activities, y, by="activity", all.y="TRUE", all.x="TRUE")

x <- read.table(paste(strDataFolder, "\\test\\x_test.txt", sep="")) ## this statement takes a minute to read in
## select only mean and std measures
x <- x[cSelectedV1]
## name the columns after the features doc
names(x) <- cSelectedV2
x$ID <- with(x, as.numeric(row.names(x)))

## merge all three together
test <- merge(sub, y, by="ID", all.y="TRUE")
test <- subset(test, , select = c(ID, subject, activity, activityName)) ## have to remove the extra ID field from the merged set
test <- merge(test, x, by="ID", all.y="TRUE")
test$src <- "test"

## clean-up
rm(sub); rm(y); rm(x);

complete <- rbind(test, train)
##CHECK: count(complete, "src")

## remove helper columns
complete$ID <- NULL
complete$src <- NULL
complete$activity <- NULL

tidy <- ddply(complete,.(subject, activityName),numcolwise(mean,na.rm = TRUE))