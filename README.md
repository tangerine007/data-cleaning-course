# data-cleaning-course 

1) The code first grabs all of the test and training data from their respective test and train folders under 'UCI HAR Dataset/'
  -It stores these values in the following variables: testX, testY, subjectTest, trainX, trainY, subjectTrain
  -Also grabs the features from features.txt and stores in variable 'features'
  
2) The code adds the activity and subject columns to the data
  -It stores these in 'addTestY' and 'addTrainY'
  -It then combines these datasets with an rbind() and stores this in variable 'combined'

3) Looking through data I found the columns corresponding to the mean and std-dev for all of the columns
  -I store these indecies in variable 'mean_std'
  -Using this vector I subset the 'combined' dataframe to include only the necessary columns which is stored in 'subset_MeanStd'
  -Using the values in 'features' I rename the columns as their descriptive Strings.
  -If Activities haven't already been changed to their descriptive names, I do this as well
  
4) Finally, I use ddply to find the mean for all data columns over all combinations of 'Activity' and 'Subject'
  -This dataframe is stored in 'combinedActSub'
  -Table is written to text file "tidyData.txt"

