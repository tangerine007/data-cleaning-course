library(plyr)
library(reshape2)
library(dplyr)
library(data.table)


testX <- read.table('C:/Users/576970/Documents/R Workspace/data cleaning coursera/UCI HAR Dataset/test/X_test.txt')
testY <- read.table('C:/Users/576970/Documents/R Workspace/data cleaning coursera/UCI HAR Dataset/test/Y_test.txt')
subjectTest <- read.table('C:/Users/576970/Documents/R Workspace/data cleaning coursera/UCI HAR Dataset/test/subject_test.txt')
trainX <- read.table('C:/Users/576970/Documents/R Workspace/data cleaning coursera/UCI HAR Dataset/train/X_train.txt')
trainY <- read.table('C:/Users/576970/Documents/R Workspace/data cleaning coursera/UCI HAR Dataset/train/Y_train.txt')
subjectTrain <- read.table('C:/Users/576970/Documents/R Workspace/data cleaning coursera/UCI HAR Dataset/train/subject_train.txt')

features <- read.table('C:/Users/576970/Documents/R Workspace/data cleaning coursera/UCI HAR Dataset/features.txt')



addTestY <- cbind(testX,testY,subjectTest)
addTrainY <- cbind(trainX,trainY,subjectTrain)
combined <- rbind(addTestY,addTrainY)

mean_std <- c(1,2,3,4,5,6,  41,42,43,44,45,46,  81,82,83,84,85,86,  121,122,123,124,125,126,  
              161,162,163,164,165,166, 201,202,   214,215,     227,228,      240,241,      253,254,      
              266,267,268,269,270,271,      345,346,347,348,349,350,     424,425,426,427,428,429,      503,504,      516,517,     
              529,530,      542,543)

subset_MeanStd <- combined[,c(mean_std,562,563)] #subset which only includes mean/std columns and the activity and subject info

names_MeanStd <- features[mean_std,2] #subset of names ex. 'fBodyBodyGyroMag-mean()'

colnames(subset_MeanStd) <- c(as.character(names_MeanStd),'Activity','Subject')
subset_MeanStd$Activity <- as.factor(subset_MeanStd$Activity)
if(subset_MeanStd$Activity[1] %in% c(1,2,3,4,5,6)){
  subset_MeanStd$Activity <- mapvalues(subset_MeanStd$Activity, from = c(1,2,3,4,5,6), to = c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING'))
}

dataColumns <- colnames(subset_MeanStd)[1:66]
resAct <- ddply(subset_MeanStd, c("Activity"), function(x) colSums(x[dataColumns]))#part 5 matrix average for Activity

resSub <- ddply(subset_MeanStd, c("Subject"), function(x) colSums(x[dataColumns]))#part 5 matrix average for Subject

combinedActSub <-  ddply(subset_MeanStd, c("Activity","Subject"), function(x) colSums(x[dataColumns]))#part 5 matrix average for both

write.table(combinedActSub, file = "tidyData.txt",row.names = FALSE)







# 1,2,3,4,5,6,  41,42,43,44,45,46,  81,82,83,84,85,86,  121,122,123,124,125,126,  161,162,163,164,165,166,
# 201,202,   214,215,     227,228,      240,241,      253,254,      266,267,268,269,270,271,      345,346,347,348,349,350,
# 424,425,426,427,428,429,      503,504,      516,517,      529,530,      542,543,      