## Data Files
msmTrainFile <- "./UCI HAR Dataset/train/X_train.txt"
msmTestFile <- "./UCI HAR Dataset/test/X_test.txt"
actTrainFile <- "./UCI HAR Dataset/train/y_train.txt"
actTestFile <- "./UCI HAR Dataset/test/y_test.txt"
sjtTrainFile <-"./UCI HAR Dataset/train/subject_train.txt"
sjtTestFile <-"./UCI HAR Dataset/test/subject_test.txt"
featuresFile <- "./UCI HAR Dataset/features.txt"

## Read Tables
features <- read.table(featuresFile)
actTest <- read.table(actTestFile,col.names = "Activity")
actTrain <- read.table(actTrainFile,col.names = "Activity")
sjtTest <- read.table(sjtTestFile,col.names = "Subject")
sjtTrain <- read.table(sjtTrainFile,col.names = "Subject")
if(!exists("msmTrain")) msmTrain <- read.table(msmTrainFile, col.names = features$V2)
if(!exists("msmTest")) msmTest <- read.table(msmTestFile, col.names = features$V2)

#Step1 and Step2

msmVariables <- grepl("-mean[^Ff]|-std()",features$V2)
train <- cbind(sjtTrain,actTrain,msmTrain[msmVariables])
test <- cbind(sjtTest,actTest,msmTest[msmVariables])
df <- data.frame(rbind(train,test))

#Step 3
avtivityLabel <- c("Walking", "Walking_Upstairs", "Walking_Downstairs",
                   "Sitting", "Standing", "Laying")
df$Activity<- factor(df$Activity,labels = avtivityLabel)

#Step 4
labelAppropiator<-function(x){
  x<-gsub(".mean..","Mean",x)
  x<-gsub(".std..","Std",x)
  x<-gsub(".([XYZ])","\\1",x)
  x<-gsub("BodyBody","Body",x)
}
names(df)<-sapply(names(df),labelAppropiator)

#Step5
tidyDF<-aggregate(df[3:68],list(Subject=df$Subject,Activity=df$Activity),mean)
write.table(tidyDF,file = "courseProject.txt",row.names = FALSE)
