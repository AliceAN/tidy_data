#load packages
library(data.table)
library(plyr)
library(dplyr)

##Download Files and set working directory to downloaded folder with data
wd<-getwd()
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file.create("project3")
download.file(url, "project3")
unzip("project3")
filename<-file.path(wd, "UCI HAR Dataset")
testfolder<-file.path(wd, "UCI HAR Dataset", "test")
trainfolder<-file.path(wd, "UCI HAR Dataset", "train")
setwd(filename)

#read activity and features files into R
filelist <- list.files(pattern = ".*.txt")
activity<-fread(filelist[1])
features<-fread(filelist[2])

##Merge the training and the test sets to create one data set

#read filespath from test and train folders
testfilelist=list.files(testfolder, full.names=TRUE) 
trainfilelist=list.files(trainfolder, full.names=TRUE) 

#read the files for the subject and row bind test and train
subjectlist<-c(testfilelist[2], trainfilelist[2])  
subjectdf <- lapply(subjectlist, function(x) fread(x, header=F)) 
subjectdf <- do.call("rbind", subjectdf) 

#read the files for X and row bind test and train
Xlist<-c(testfilelist[3], trainfilelist[3])  
Xdf <-lapply(Xlist, function(x) read.table(x, header=F)) 
Xdf <- do.call("rbind", Xdf)

#read the files for y and row bind test and train
ylist<-c(testfilelist[4], trainfilelist[4])  
ydf <-lapply(ylist, function(x) fread(x, header=F)) 
ydf <- do.call("rbind", ydf)

#Bind the columns of the datasets together
mergeddata<-cbind(Xdf, subjectdf, ydf)

#Extract only the measurements on the mean and standard deviation 
#for each measurement

extractmeanposition<-grep("mean", features$V2, ignore.case=TRUE, value=FALSE)
extractstdposition<-grep("std", features$V2, ignore.case=TRUE, value=FALSE)

#create and sort a vector with the columns to extract from merged data set
forExtraction<-c(extractmeanposition, extractstdposition, 562, 563)
forExtraction<-sort(forExtraction)

#change names of the appended V1, v1 columns and select required columns 
setnames(mergeddata, 562:563, c("subject", "activity"))

extracteddata<-select(mergeddata, forExtraction)

#Use descriptive activity names to name the activities in the data set
#create key = matching colname in activity data set 
setnames(activity, 1:2, c("activity", "activity_name"))
wActivity<-merge(extracteddata,activity, by="activity")
wActivity<-select(wActivity, -activity)

##Label the data set with descriptive variable names
#get the variable names from the features file

variablenames<-features$V2[forExtraction]

#Clean up variable names 
variablenames<-gsub("\\(|\\)", "", variablenames)
variablenames<-gsub("-", "", variablenames)
variablenames<-gsub(",", "", variablenames)
variablenames<-tolower(variablenames)

##Label the data set with descriptive variable names
setnames(wActivity, 1:86, variablenames[1:86])
setnames(wActivity, 88, "activity")

##arrange data by subject and activity and set them to first 2 columns 
wActivity<-arrange(wActivity, activity, subject)
tidydata<-wActivity[c(87,88, 1:86)]

##create an independent tidy data set 
#with the mean of each variable 
#for each activity and each subject
independenttidydata<-tidydata%>%
        group_by(activity, subject)%>%
        summarise_each(funs(mean))

file.create("tidydata.txt")
write.table(independenttidydata, file="tidydata.txt", row.name=FALSE)
