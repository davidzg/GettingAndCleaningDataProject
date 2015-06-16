#setwd("E:/DATA_SCIENCE/3.GettingAndCleaningData/course_project")
library(dplyr)
trainFile <- "./data/UCI HAR Dataset/train/X_train.txt"
testFile <- "./data/UCI HAR Dataset/test/X_test.txt"
featuresFile <- "./data/UCI HAR Dataset/features.txt"
features <- read.table(featuresFile)
yActTest<-read.table("./data/UCI HAR Dataset/test/y_test.txt",col.names = "Activity")
yActTrain<-read.table("./data/UCI HAR Dataset/train/y_train.txt",col.names = "Activity")
#trainRaw <- tbl_df(read.table(trainFile, col.names = features$V2))
#testRaw <- tbl_df(read.table(testFile, col.names = features$V2))
trainRaw["Activity"]<- yActTrain[1]
testRaw["Activity"]<- yActTest[1]
dt<- rbind(trainRaw,testRaw)
dt1<- select(dt,contains("mean"),contains("std"))
