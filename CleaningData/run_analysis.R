
#Libraries----

library(tidyverse)
library(data.table)

#Creating and setting the working directory

if (!dir.exists("~/data")) { dir.create("~/data") }
setwd("~/data")


#Download file 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              "data.zip")


#unzip the file downloaded in the working directory
unzip("data.zip")




#IMPORT DATA ------------------------------------------------------------------------------------------------------------------------

#Import variable names and activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")


#Import test data
testpath <- "UCI HAR Dataset/test"

testfilelist <- list.files(testpath, pattern = "(.*).txt") #create a list that contain 3 files
testfilelist <- paste(testpath, testfilelist, sep = "/")
testdatalist <- lapply(testfilelist, FUN = read.table) #use lapply to create a data list


#Import train data
trainpath <- "UCI HAR Dataset/train"

trainfilelist <- list.files(trainpath, pattern = "(.*).txt") #create a list that contain 3 files
trainfilelist <- paste(trainpath, trainfilelist, sep = "/")
traindatalist <- lapply(trainfilelist, FUN = read.table) #use lapply to create a data list





# DATA ELABORATION-------------------------------------------------------------------------------------------------------------------

#-----> merging train-test



#-------------> preparing the "subject" dataframe for the final join

tbl_subject <- bind_rows(traindatalist[[1]],testdatalist[[1]]) # merging train and test "subject" dataframe 

colnames(tbl_subject) <- "subject" #naming the column





#-------------> preparing the "y" dataframe for the final join

tbl_y <- bind_rows(traindatalist[[3]],testdatalist[[3]])%>% # merging train and test "subject" dataframe 
    left_join(activity_labels, by=c("V1"="V1")) %>% # join with the dataframe that contain the labels
    select(activity=V2) #renaming and selecting only the column that contain the labels





#-------------> preparing the "X" dataframe for the final join

tbl_X <- bind_rows(traindatalist[[2]],testdatalist[[2]]) # merging train and test "subject" dataframe 

colnames(tbl_X) <- as.character(features[,2]) # naming the columns with the name contained in the features dataframe


# creating a vector (colsel) with the positione of the columns that contain "mean" or "std" in the name 

colsel<-sort(
    as.numeric(
        c(as.character(grep("mean",names(tbl_X))),
          as.character(grep("std",names(tbl_X)))
          )))


# removing "meanFreq" from the colsel vector that we created in the previous step

colsel <- colsel[!colsel %in% as.character(grep("meanFreq",names(tbl_X)))]


# selecting the columns in the dataframe "X" using the colsel vector

tbl_X <- tbl_X[,colsel]





#-----> merging all the dataframe (subject, y and X)

tbl_tidy <- bind_cols(tbl_subject,tbl_y,tbl_X)


#-----> #renaming the variables

names(tbl_tidy)<-gsub("Acc", "Acceleration",names(tbl_tidy)); names(tbl_tidy)<-gsub("Gyro", "Gyroscope",names(tbl_tidy))

names(tbl_tidy)<-gsub("fBody", "Frequency: Body",names(tbl_tidy)); names(tbl_tidy)<-gsub("tBody", "Time: Body",names(tbl_tidy))

names(tbl_tidy)<-gsub("tGravity", "Time: Gravity",names(tbl_tidy));names(tbl_tidy)<-gsub("-mean()", " mean",names(tbl_tidy))

names(tbl_tidy)<-gsub("-std()", " std",names(tbl_tidy));names(tbl_tidy)<-gsub("-X", " X-Axis",names(tbl_tidy))

names(tbl_tidy)<-gsub("-Y", " Y-Axis",names(tbl_tidy));names(tbl_tidy)<-gsub("-Z", " Z-Axis",names(tbl_tidy))

names(tbl_tidy)<-gsub("Mag", "Magnitude",names(tbl_tidy));



#-----> creating the 2nd final dataframe 

tbl_tidy_mean <- tbl_tidy %>% 
    group_by(subject,activity) %>% 
    summarize_all(mean)


write.table(tbl_tidy_mean,"TidyDF_AndreaAmaduzzi.txt",row.name=FALSE)

View(tbl_tidy_mean)






