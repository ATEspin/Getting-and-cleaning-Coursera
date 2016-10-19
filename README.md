# Getting-and-cleaning-Coursera
Week 4 assignment of the Coursera course "Getting and Cleaning Data"

This repo contains the R code to extract and tidy the data from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In the README.txt found in the previous zip file are specified in detail the description of the different variables.

In the CodeBook.md in this repo are described the new variables generated using the run_analysis.R code.

The run_analysis.R file contains the scripts to extract and merge the data from the zip file into a unique data set. Moreover, a script to summarise the data by the mean is included.

The scripts run as follow (package dplyr is needed):

1. Getting the data: Definition of the url and downloading the data. Unzip the zip file. Changing the working directory to the unzipped folder
2. Loading features and activity labels: Loading the features.txt and activity_labels.txt using read.table
3. creating data forms from the different *.txt files: Loading into R the files X_train, y_train and subject_train and merge them using cbind(). loading into R the files X_test, y_test and subject_test and merge them using cbind()
4. Merge both data sets, reorder the "condition" variable to the first column and select the mean and std columns
5. Rename activity id by descriptive names
6. Create summary data set by average using group_by and summarise_each
7. Saving the data sets to txt files
