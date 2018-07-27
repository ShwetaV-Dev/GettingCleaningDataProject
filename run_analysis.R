
### 1.Merges the training and the test sets to create one data set 
library(data.table)

## download file and unzip the zip data to a directory in the system 
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
unzip(zipfile=temp, exdir="./desktop/Coursera")
rm(temp)

## read test and train data from the files
df_xtrainData <- read.table("./desktop/Coursera/UCI HAR Dataset/train/X_train.txt")
df_xtestData <- read.table("./desktop/Coursera/UCI HAR Dataset/test/X_test.txt")
## combine the test and train data
df_combineData <- rbind(df_xtrainData, df_xtestData)
## add column names from features file
df_colNamesData <- read.table("./desktop/Coursera/UCI HAR Dataset/features.txt")
names(df_combineData) <- df_colNamesData[, 2]
rm(df_xtrainData)
rm(df_xtestData)
rm(df_colNamesData)

## read activity data from train and test dir
df_ytrainData <- read.table("./desktop/Coursera/UCI HAR Dataset/train/y_train.txt")
df_ytestData <- read.table("./desktop/Coursera/UCI HAR Dataset/test/y_test.txt")
## combine the test and train activity data
df_activityData <- rbind(df_ytrainData, df_ytestData)
## add column name
names(df_activityData) <- c("activityData")
rm(df_ytrainData)
rm(df_ytestData)

## read subject data from train and test dir
df_subtrainData <- read.table("./desktop/Coursera/UCI HAR Dataset/train/subject_train.txt")
df_subtestData <- read.table("./desktop/Coursera/UCI HAR Dataset/test/subject_test.txt")
## combine the test and train subject data
df_subjectData <- rbind(df_subtrainData, df_subtestData)
## add column name
names(df_subjectData) <- c("subject")
rm(df_subtrainData)
rm(df_subtestData)

##combine all the data test/train data, activity data, subject data via columns
x <- cbind(df_activityData, df_subjectData)
final_data <- cbind(x, df_combineData)
rm(x)
rm(df_activityData)
rm(df_subjectData)
rm(df_combineData)

### 2.Extracts only the measurements on the mean and standard deviation for each measurement.
selectedColNames <- grep("mean\\(\\)|std\\(\\)|subject|activityData", names(final_data), value = TRUE)
sel_data <- subset(final_data, select = selectedColNames)

### 3.Use descriptive activity names to name the activities in the data set

## read activity labels data from file activity_labels.txt
df_activityLabels <- read.table("./desktop/Coursera/UCI HAR Dataset/activity_labels.txt")
sel_data <- merge(sel_data, df_activityLabels, by.x="activityData", by.y="V1", all=TRUE)
sel_data$activityData <- sel_data$V2
sel_data <- subset(sel_data, select = -V2 )

### 4.Appropriately labels the data set with descriptive variable names.
names(sel_data) <- sub("^t", "time", names(sel_data))
names(sel_data) <- sub("^f", "frequency", names(sel_data))
names(sel_data) <- sub("BodyBody", "Body", names(sel_data))
names(sel_data) <- sub("Acc", "Accelerometer", names(sel_data))
names(sel_data) <- sub("Gyro", "Gyroscope", names(sel_data))
names(sel_data) <- sub("Mag", "Magnitude", names(sel_data))

### 5.From the data set in step 4, creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject.

avg_data <- aggregate(. ~subject + activityData, sel_data, mean)
avg_data <- avg_data[order(avg_data$subject,avg_data$activity),]
write.table(avg_data, file = "tidydata.txt",row.name=FALSE)

