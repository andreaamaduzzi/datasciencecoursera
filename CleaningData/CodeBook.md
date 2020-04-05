---
title: "CodeBook"
output: html_document
---


# *All steps of the Cleaning Data Assignment*


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

