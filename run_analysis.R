# Download data if necessary
filename <- 'data.zip'
if (!file.exists(filename) && !grepl(getwd(), "UCI HAR Dataset")){
  dataURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  download.file(dataURL, 'data.zip')
}
if (!file.exists("UCI HAR Dataset")){
  unzip('./data.zip')
}

if (!grepl(getwd(), "UCI HAR Dataset")){
  setwd("./UCI HAR Dataset")
}

# Load activity and feature
features <- read.table('features.txt')
activity_labels <- read.table('activity_labels.txt')

## Load training data
train_x <- read.table('train/X_train.txt')
train_y <- read.table('train/y_train.txt')
train_subjects <- read.table('train/subject_train.txt')

## Load test data
test_x <- read.table('test/X_test.txt')
test_y <- read.table('test/y_test.txt')
test_subjects <- read.table('test/subject_test.txt')

## Merges the training and the test sets to create one data set.
# First merge rows for x, y, and subjects
all_x <- rbind(train_x, test_x)
all_y <- rbind(train_y, test_y)
all_subjects <- rbind (train_subjects, test_subjects)

# Assign proper names to columns
names(all_subjects) = c('subject')
names(all_y) = c('activity')
names(all_x) = features$V2

# Merge columns into full data set
subject_activity = cbind(all_subjects, all_y)
Data <- cbind(all_x, subject_activity)

## Extracts only the measurements on the mean and standard deviation for each measurement.
# Subset whole dataset with column with names containing either mean, std, subject and activity
Data <- subset(Data, select=c(as.character(features$V2[grep('mean\\(|std', features$V2)]), 'subject', 'activity'))

## Uses descriptive activity names to name the activities in the data set
# Use previously imported activity_label mapping to replace names in that column.
Data$activity <- factor(Data$activity, levels = activity_labels$V1, labels = activity_labels$V2)

## Appropriately labels the data set with descriptive variable names.
# grep for replaceable strings in names and replace appropriately.
names(Data) <- gsub("[\\(\\)-]", "", names(Data))
names(Data) <- gsub("^f", "frequencyDomain", names(Data))
names(Data) <- gsub("^t", "timeDomain", names(Data))
names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("Freq", "Frequency", names(Data))
names(Data) <- gsub("mean", "Mean", names(Data))
names(Data) <- gsub("std", "StandardDeviation", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- aggregate(. ~subject + activity, Data, mean)
tidy_data <- tidy_data[order(tidy_data$subject,tidy_data$activity),]

write.table(tidy_data, file = 'tidy_data.txt', row.names = FALSE, quote = FALSE)
