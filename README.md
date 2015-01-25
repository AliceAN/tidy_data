
######Course Project #2 Getting and Cleaning Data
Datascience specialization track
by AliceAN 

######run_analysis
The tidydata set was created from the UCI HAR Dataset using the code in run_analysis.R file.
The summary contains the mean of 86 vector features for each subject and activity. 
There are 30 subjects in the experiment and 6 activities
- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

The result is a table with 180 observations of 88 variables 

***
R packages used 
- data.table
- plyr
- dplyr

***

One data set is created by binding the test and train files using row bind and then column bind.
For each measurement only the mean and standard deviation are extract using grep. Using information on the activity.txt file the numeric activity labels numbered 1 through 6 are replaced with descriptive names. Using the features.txt file descriptive variable names are extracted, cleaned and set as the variable names for the vector features for columns 1 through 86, while the last two columns are named subject and activity. 

The data is arranged by activity and subject. Because the arrangement was done after the activity names replaced the numeric activity label, LAYING is at the head of the dataset while WALKING_UPSTAIRS is at the tail. 

Tidy data is created by summarising the mean for each variable grouped by activity and subject. 

***
######Data Source

The UCI HAR Dataset was downloaded from url: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

- The UCI HAR Dataset includes

> -     'README.txt'
> -     'features_info.txt': Shows information about the variables used on the feature vector.
> -     'features.txt': List of all features.
> -     'activity_labels.txt': Links the class labels with their activity name.
> -     'train/X_train.txt': Training set.
> -     'train/y_train.txt': Training labels.
> -     'test/X_test.txt': Test set.
> -     'test/y_test.txt': Test labels.
> -     'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
> - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
> - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
> - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

***

######credits
The raw data is the work of 
>[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on >Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted >Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

***






