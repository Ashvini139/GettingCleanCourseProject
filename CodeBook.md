## Getting and Cleaning Data – Course Project

### Project Objective
The purpose is to collect, work, and clean a data set and to get tidy data that can be used for later analysis. 
### Experiment Description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information
For each record in the dataset it is provided:
•	Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
•	Triaxial Angular velocity from the gyroscope.
•	A 561-feature vector with time and frequency domain variables.
•	Its activity label.
•	An identifier of the subject who carried out the experiment.
### Data Source
The source of row data used for this project in given at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Project Details
 How the R script run_analysis.R works.
### Merges the training and the test sets to create one data set.

1.	The data directory is created and the data is downloaded from the source as datasetzip.zip

2.	Unzip the downloaded file.

3.	Listed the files to know all files present and to require files.

4.	Reading X_test.txt and X_train.txt files for merging.

5.	Merging of testdata and traindata files to get dataset with all observations or rows.


## Extracts only the measurements on the mean and standard deviation for each measurement. 
1.	Reading column names from features files and adding column names to merged dataset.

2.	Creating dataset only with Mean and standard deviation variables using function “grep”.

###Uses descriptive activity names to name the activities in the data set
1.	Read the activity labels from ctivity_labels.txt file.

2.	Renaming the activities with lowercase and removing “_” in activitylabel file. 

3.	Read the activity test - y_test.txt and train y_train.txt files .

4.	Merging of two data files of activities read in above step.

5.	Merging of activity labels with activity data

6.	Name the activity column with name “Activity”.

7.	Reading subject test - subject_test.txt and train subject_train.txt datasets.

8.	Merging Test & Train datasets and adding column name as “Subject”.

###Appropriately labels the data set with descriptive variable names. 
1.	Prefix “t” is replaced by time.

2.	Prefix “Acc” is replaced by Accelerometer

3.	Prefix “f” is replaced by frequency

4.	Prefix “Mag” is replaced by Magnitude

5.	Prefix “Gyro” is replaced by Gyroscope

6.	The word “BodyBody” is replaced by Body

7.	The word “mean” is replaced by Mean

8.	The word “std” is replaced by STD.

9.	The “( )” and “-“ is removed.

### Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
1.	The final data file is created by merging Combine data (mean_std_data file) with subject data ( mergedsubject file) and activity data (mergedactivity files).

2.	Aggregating data to average each variable for each activity and each subject. This is achieved using aggregate function and using “Subject”and “Activities”as parameters/variables.

3.	Sort dataset by first Subject and then by Activities variables/column

4.	Write final sorted data as tidydata.txt file.

The output file tidydata.txt is with 68 variables and 180 rows.

