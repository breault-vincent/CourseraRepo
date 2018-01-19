## Code Book
Getting and cleaning data course project.

### Data source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
See README.txt for specifics about the data.
Refer here for more information on the data source:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Merges the training and the test sets to create one data set.
Concatenating the test and subject to create one dataset.
`test_x`, `train_x` contains the `features`
`test_y`, `train_y` contains the `activity`
`subject_x`, `subject_y` contains the subjects id.

All of these tables get merged into `Data` for processing.

### Processing
The following operations were performed on the data:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
