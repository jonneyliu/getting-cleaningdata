## Getting and Cleaning Data Course Project
=======================

This repository contains the relevant files for the Course Project in which we will take data measured by accelerometers from the Samsung Galaxy S smartphone and merge the relevant files to create a tidy data set.

Description of data set in the following link:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Data set is as follows:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Files in this repository:
`CodeBook.md` describes the variables, the data, and any transformations or work that was performed to clean up the data.

`run_analysis.R` is the R script that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

`tidy_data.txt` is the final output of `run.analysis.R`
