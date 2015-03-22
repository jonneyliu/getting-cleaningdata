###Getting and cleaning data Course Project



###read the relevant data
x_train <- read.table("Getting & cleaning data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("Getting & cleaning data/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("Getting & cleaning data/UCI HAR Dataset/train/subject_train.txt")
features <- read.table("Getting & cleaning data/UCI HAR Dataset/features.txt")

x_test <- read.table("Getting & cleaning data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("Getting & cleaning data/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("Getting & cleaning data/UCI HAR Dataset/test/subject_test.txt")
activity_labels <- read.table("Getting & cleaning data/UCI HAR Dataset/activity_labels.txt")

###Step 1: Merge training and test data for X, Y and Subject

#merging training and test 
x_dt <- rbind(x_train,x_test) #start with putting the x data sets together by merging training and test dataset
y_dt <- rbind(y_train,y_test) #next apply with y
sub_dt <- rbind(subject_train,subject_test) #lastly do same with subject

###Step2: Extract only the measurements on the mean and standard deviation for each measurement. 

#use grepl function to find column array with "mean" or "std" in column name

features_extract <-  grepl("mean|std", features[,2])
colnames(x_dt) <- features[,2] #name columns in x with respect to features

x_dt_extract <- x_dt[,features_extract] #return only columns in x with "mean" or "std" in name


###Step 3: Uses descriptive activity names to name the activities in the data set

y_dt[,2] <- activity_labels[y_dt[,1],2]  ##matches activity number in y against activity labels table and creates a new column

###Step 4: Appropriately labels the data set with descriptive variable names. 
colnames(y_dt) <- c("activity_no","activity_name")
colnames(sub_dt) <- "subject"

###cbind x,y abd subject to create 1 tidy dataset

dt <- cbind(sub_dt,y_dt,x_dt_extract)


###Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#melt data table by collapsing all necessary columns used to calculate mean and std
dt_melt <- melt(dt, id = c("subject","activity_no","activity_name"),colnames(dt)[4:length(colnames(dt))])
dt_mean <- dcast(dt_melt, subject+activity_name  ~ variable, mean)


write.table(dt_mean,"tidy_data.txt",row.name=FALSE)
