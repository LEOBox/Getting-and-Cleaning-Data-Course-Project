library(dplyr)
#read train data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

#read test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

#read features and labels data
features <- read.table("UCI HAR Dataset/features.txt")
activitiy_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

#merge train and test data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
sub_data <- rbind(sub_train, sub_test)

#select meand and std features
features_selected <- grep("std|mean", features[,2])
x_data <- x_data[,features_selected[,1]]

#Uses descriptive activity names to name the activities in the data set
colnames(y_data) <- "activity"
y_data$activity_label <- factor(y_data$activity, labels = as.character(activitiy_labels[,2]))
activitiy_label <- y_data[,-1]

#Appropriately labels the data set with descriptive variable names.
colnames(x_data) <- features[features_selected,2]

#From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.
colnames(sub_data) <- "subject"
tidy_data <- cbind(x_data, activitiy_label, sub_data)
tidy_data_mean <- tidy_data %>% group_by(activitiy_label, subject)

write.table(tidy_data_mean, file="tidyData.txt", row.names = FALSE)