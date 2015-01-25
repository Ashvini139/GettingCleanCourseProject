#Getting and Cleaning Data - Course Project

#1. Merges the training and the test sets to create one data set.

#Downloading the Zipped files from data source to place in working directory.

if (!file.exists("./data")){dir.create("./data")}
fileUrl = "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl, destfile="./data/datasetzip.zip")

#Unzip the downloaded folder.
unzip(zipfile="./data/datasetzip.zip", exdir="./data")

#List the files to get required files.
fileList=list.files("./data/UCI HAR Dataset",recursive=TRUE)

# Reading X_test.txt. data file
testdata=read.table("./data/UCI HAR Dataset/test/X_test.txt")
traindata=read.table("./data/UCI HAR Dataset/train/X_train.txt")

# merging the two datafiles read.
mergeddata = rbind(testdata,traindata)



#2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Reading column names from features file and adding column names to merged data.
features <- read.table("./data/UCI HAR Dataset/features.txt")
names(mergeddata) <- features$V2

# creating dataset with only Means and standard deviation measurements
mean_std_data = grep("mean\\(|std\\(",features[,2], value=F)
mean_std_data = mergeddata[,mean_std_data]

#3. Uses descriptive activity names to name the activities in the data set
#Read the activity labels file.
activitylabel = read.table("./data/UCI HAR Dataset/activity_labels.txt")

#Editing acitivitylabels to get lower case and without underscore.
activitylabel[,2] <- tolower(as.character(activitylabel[,2]))
activitylabel[,2] <- gsub("_","",activitylabel[,2])

# reading acitivity data files.
activitydataTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
activitydataTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

#Merging of two data files of activities.
mergedactivity = rbind(activitydataTest, activitydataTrain)

#Merging of activity labels with activity data
mergedactivity [,1]<-  activitylabel[mergedactivity[,1],2]

#Name the activity column with name "Activity".
names(mergedactivity) <- c("Activities")

#Reading subject test and train datasets
subjectdataTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
subjectdataTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Merging Test & Train subject datasets and adding column name as "Subject".
mergedsubject = rbind(subjectdataTest, subjectdataTrain)
names( mergedsubject) <- c("Subject")

###4. Appropriately labels the data set with descriptive variable names
#Prefix "t" is replaced by time.
names(mean_std_data)<-gsub("^t", "time", names((mean_std_data)))

#Acc is replaced by Accelerometer
names(mean_std_data)<-gsub("Acc", "Accelerometer", names(mean_std_data))

#Prefix "f" is replaced by frequency
names(mean_std_data)<-gsub("^f", "Frequency", names(mean_std_data))

#Prefix "Mag" is replaced by Magnitude
names(mean_std_data)<-gsub("Mag", "Magnitude", names(mean_std_data))

#Prefix "Gyro" is replaced by Gyroscope
names(mean_std_data)<-gsub("Gyro", "Gyroscope", names(mean_std_data))

#The word "BodyBody" is replaced by Body
names(mean_std_data)<-gsub("BodyBody", "Body", names(mean_std_data))

#The word "mean" is replaced by Mean
names(mean_std_data)<-gsub("mean", "Mean", names(mean_std_data))

#The word "std" is replaced by STD.
names(mean_std_data)<-gsub("std", "STD", names(mean_std_data))

#The "( )" and "-" is removed.
names(mean_std_data)<-gsub("\\(|\\)","", names(mean_std_data))
names(mean_std_data)<-gsub("-", "", names(mean_std_data))

### 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#Combine data with subject and activity data.
combineddata <- cbind(mean_std_data,mergedsubject,mergedactivity)

#Aggregating data to average each variable for each activity and each subject.
finaldata  <- aggregate(.~Subject + Activities, combineddata, mean)

#Sort dataset by subject and then by activities.
finaldatasorted = finaldata[order(finaldata$Subject, finaldata$Activities),]

#Write final sorted data.
write.table(finaldatasorted, "./data/tidydata.txt", sep="\t", row.names=FALSE)
