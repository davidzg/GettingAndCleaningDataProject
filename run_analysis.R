#setwd("E:/DATA_SCIENCE/3.GettingAndCleaningData/course_project")
library(dplyr)

msmTrainFile <- "./UCI HAR Dataset/train/X_train.txt"
msmTestFile <- "./UCI HAR Dataset/test/X_test.txt"
actTrainFile <- "./UCI HAR Dataset/train/y_train.txt"
actTestFile <- "./UCI HAR Dataset/test/y_test.txt"
sjtTrainFile <-"./UCI HAR Dataset/train/subject_train.txt"
sjtTestFile <-"./UCI HAR Dataset/test/subject_test.txt"
featuresFile <- "./UCI HAR Dataset/features.txt"


features <- read.table(featuresFile)
actTest <- read.table(actTestFile,col.names = "Activity")
actTrain <- read.table(actTrainFile,col.names = "Activity")
sjtTest <- read.table(sjtTestFile,col.names = "Subject")
sjtTrain <- read.table(sjtTrainFile,col.names = "Subject")
if(!exists("msmTrain")) msmTrain <- read.table(msmTrainFile, col.names = features$V2)
if(!exists("msmTest")) msmTest <- read.table(msmTestFile, col.names = features$V2)


msmVariables <- grepl("-mean[^Ff]|-std()",features$V2)
train <- cbind(sjtTrain,actTrain,msmTrain[msmVariables])
test <- cbind(sjtTest,actTest,msmTest[grepl("-mean[^Ff]|-std()",features$V2)])
dt <- tbl_df(rbind(train,test))


