---
title: "CodeBook"
output: html_document
---

# _Dataset description_
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

## For each record it is provided:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.

Triaxial Angular velocity from the gyroscope.

A 561-feature vector with time and frequency domain variables.

Its activity label.

An identifier of the subject who carried out the experiment.

## The dataset includes the following files:
'README.txt'

'features_info.txt': Shows information about the variables used on the feature vector.

'features.txt': List of all features.

'activity_labels.txt': Links the class labels with their activity name.

'train/X_train.txt': Training set.

'train/y_train.txt': Training labels.

'test/X_test.txt': Test set.

'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.



# *What run_analysis.R do to perform the Cleaning Data Assignment*


## ---------- _First part is about preparing R environment_ -----------

### 1 - Libraries

#### I called the libraries needed for my manipulations: tidyverse, data.table

### 2- Creating and setting the working directory

#### I created the "data" directory a set it as working directory

### 3 - Download and unzip the file

### 4 - IMPORT DATA 

#### 4.1 Import variable names and activity labels 

#### This 2 dataframes contains the activity labels (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) and the features, those come from the activity of measurement of the fit-device.

#### 4.2 Import test data

#### three dataframes, the 1st contains the 30 subjects that have participated at the analisys, the 2nd the variables values (features value) and the 3rd contain the activity value (from 1 to 6). All these dataframes refer to the test set of data.

#### 4.3 Import train data

#### three dataframes, the 1st contains the 30 subjects that have participated at the analisys, the 2nd the variables values (features value) and the 3rd contain the activity value (from 1 to 6). All these dataframes refer to the train set of data.



## ------------- _Second part is about Elaboration Data_ --------------

### 5 - preparing the "subject" dataframe for the final join

#### 5.1 merging train and test "subject" dataframe using bind_rows function

#### 5.2 naming the column as "subject"

### 6 - preparing the "y" dataframe for the final join

#### 6.1 merging train and test "y" dataframe using bind_rows function

#### 6.2 join dataframes "y" with the dataframe that contain the labels of activities

#### 6.3 naming the column as "subject"

### 7 - preparing the "X" dataframe for the final join

#### 7.1 merging train and test "X" dataframe using bind_rows function

#### 7.2 naming the columns with the name contained in the features dataframe

#### 7.3 creating a vector (colsel) with the positione of the columns that contain "mean" or "std" in the name (removing "meanFreq")

#### 7.4 selecting the columns in the dataframe "X" using the colsel vector created in the step 7.3




## ------ _Third part is about creation of the final tidy dataframe_ ------

### 8 - merging dataframes created (subject, y, X) to obtain the finale dataframe using bind_col function (tidy dataframe)

### 9 - renaming the variables

### 10 - obtain a 2nd tidy dataframe that contain the mean of the variable grouped by the subjects and the activities

### 11 - create a file with the last tidy dataframe

