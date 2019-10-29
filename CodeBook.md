# The Data
The code defines 2 dataframes in your eviorment. Primarily its the tidy dataset called dftot which has 81 columns. In order to understand the other dataset dfavg , one needs to understand what is in the first one.
The data comes from mesurments done by a smart phone. In particular only avrages and standardeviations are recorded for each entry. There are 30 different subjects in this experiment and this is indicated by the SUBJECT column. These recorded in 6 different positions which is indicated by the ACTIVITY column. Further there are categories in which  given 3 coordinates x,y,z and its coupled standard deviations  accounts for 6 variables.
*tBodyAcc* which indicates the accelleration in the time domain. 
*tGravityAcc* which indicates measured gravitation in the time domain.
*tBodyAccJerk*
*tBodyGyro*
*tBodyGyroJerk*
*tBodyAccMag* Is given without a coordinate
*tGravityAccMag*
*tBodyAccJerkMag*
Further more each of these values are given in the frequency domain.
# The Transformations
The tidy set was produced by first picking out the column names found in the features.txt file. Then a regular expression search was done to find the columns containing means and standard deviations.
In order to find avrages given activity and subject a group by and summarize was used with the dplyr package.
