library(dplyr)

# 1. Getting the data---------------------------------------------------
url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "Samsung accelerometer data.zip")
unzip("samsung accelerometer data.zip") #unzip the zip file downloaded from the url
setwd("./UCI HAR Dataset")#set the working directory in the unzipped folder

# 2. Loading features and activity labels--------------------------------
features<-read.table("features.txt", colClasses = "character")
activity_labels<-read.table("activity_labels.txt", colClasses = "character")

# 3. creating data forms from the different *.txt files -----------------
train_data<-read.table("./train/X_train.txt")
train_subject<-read.table("./train/subject_train.txt")
train_activity<-read.table("./train/y_train.txt")
train_all<-cbind(train_subject, train_activity, train_data)
colnames(train_all)<-c("subject", "activity", features[,2])
train_all$condition<-"train"
    
test_data<-read.table("./test/X_test.txt")
test_subject<-read.table("./test/subject_test.txt")
test_activity<-read.table("./test/y_test.txt")
test_all<-cbind(test_subject, test_activity, test_data)
colnames(test_all)<-c("subject", "activity", features[,2])
test_all$condition<-"test"

# 4. Merge both data sets and reorder the "condition" variable to the first column----
Activity_data<-rbind(train_all, test_all)
Activity_data<-Activity_data[,c(ncol(Activity_data), 2:ncol(Activity_data)-1)]

# 5. Rename activity id by descriptive names------------------------------------------
Activity_data$activity<-as.factor(Activity_data$activity)
levels(Activity_data$activity)<-activity_labels$V2

#Alternative way of renaming the activity variable using mapvalues() function
# of the pylr package.

    # library(plyr)
    # Activity_data$activity<-mapvalues(Activity_data$activity, 
                                      # from=activity_labels$V1, to=activity_labels$V2)

# 6. Create summary data set by average-----------------------------------------------
Activity_summary<-group_by(Activity_data, condition, subject, activity)
Activity_summary<-summarise_each(Activity_summary, funs(mean))

# 7. Saving the data sets to txt files-------------------------------------------------
write.table(Activity_data, "Samsung activity.txt", row.names = F)
write.table(Activity_summary, "Samsung activity summary.txt", row.names = F)
