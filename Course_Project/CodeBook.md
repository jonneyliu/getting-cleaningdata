#Code Book

This code book describes the variables, the data, and any transformations or work that you performed to clean up the data

##Data Description

Detailed description of the data can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data files can be downloaded with the following link (need to unzip):

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## What ```run_analysis.R``` does
* Loads the the x, y and subject data from both the training data and test with `read.table()`
* Using `rbind()` function merge the training data with the test data to create `x_dt`, `y_dt` and `sub_dt'
* Loads `actvitiy_labels` as a table used to match `activity_no` given in y with a `activity_name`
* Loads `feature.txt` which corresponds to the column labels for `x_dt`
* Using `grepl()` function we return an array of TRUE or FALSE if the name corresponds to a mean or std which we subsequently use to extract the relevant columns for our tidy data set `x_dt_extract`
* Create a new column in `y_dt` that matches `activity_no` with `activity_name`
* Using `cbind()` function on `x_dt_extract`, `y_dt` and `sub_dt` we return our tidy data set `dt`
* In order to return a tidy data set with average of each variable for each activity and each subject we first use `melt()` function to collapse the data in 5 columns before we take the mean. Then we use `dcast()` to get a table of corresponding averages
* Finally we create a text file 'tidy_data.txt' with the averages 


