---
title: "Getting an cleaning data-course project"
author: "David Zapata"
date: "16 de junio de 2015"
output: html_document
---
### Read this first
This project reads datasets from different sources and merges and cleans the data in order to have a tidy data set as final result.
The original data source can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). To execute the `run_analysis.R` script, the data must be unzipped in the same folder as the script file.

## Variables
For this project I have assumed the variables described in detail in the code book, here is a summary and the convention used to name the variables:

variable format						|description
--------------------------------|-----------------
Subject 						|Volunteer number. 30 volunteers in total.
Activity						|Activity performed by a subject (see the codebook)
(t/f)BodyAcc(Mean/Std)-XYZ		|Body acceleration
tGravityAcc(Mean/Std)-XYZ 		|Gravity acceleration
(t/f)BodyAccJerk(Mean/Std)-XYZ	|Body acceleration jerk
(t/f)BodyGyro(Mean/Std)-XYZ		|Body orientation
tBodyGyroJerk(Mean/Std)-XYZ		|Body orientation jerk
(t/f)BodyAccMag					|Body acceleration magnitude
tGravityAccMag					|Gravity acceleration magnitude
(t/f)BodyAccJerkMag				|Body acceleration jerk magnitude
(t/f)BodyGyroMag				|Body orientation magnitude
(t/f)BodyGyroJerkMag			|Body orientation jerk magnitude

where `t` stands for time domain, `f` for frequency domain. 
Note that each variable has the mean and standard deviation measurement; this could be separate in an extra column in order to follow the tidy data theory, but I decided not to do it because the final tidy dataset could result more complex.
Variables `meanFreq` and `angles` were excluded because they are a different kind of measurement.


## *Run_analysis.R* Step By Step
### Input
These files are the files needed to get final tidy data frame:

Data Frame|File name			  |description
----------|-----------------|-----------
msmTrain 	|X_train.txt		  |Measurements data for the train group.
msmTest 	|X_test.txt 		  |Measurements data for the test group.
actTrain 	|y_train.txt 		  |Activity data for the train group.
actTest 	|y_test.txt 		  |Activity data for test group.
sjtTrain 	|subject_train.txt|Subject data for the train group.
sjtTest 	|subject_test.txt |Subject data for the test group.
features 	|features.txt 		|List of measurements data for the test and train groups.

### Steps
1. Read the input files. Please note in the code that the column names are loaded as well in this step. If well the column names are not in a human readable format yet, it helps in the execution of the step 7.
2. Do a subset of `msmTrain` and `msmTest` extracting only the means and standard deviations columns. this is done by a regular expression filter. I preferred to do this step first in order to have a smaller data set, which makes the process easier and faster (avoid to process unwanted data).
3. Merge the data sets `sjtTest`,`actTest`,`msmTest` by column
4. Merge the data sets `sjtTrain`,`actTrain`,`msmTrain` by column
5. merge the two previous datasets by row. The obtained dataset is a 10299x68 data frame.
6. In order to set descriptive names to the values in the activity variable, I have used the function `factor` to apply labels to the values.
7. To make the variable names descriptive and human readable, I applied a set of regular expression filters:
	+ replace `mean` for *Mean* excluding the `.` and special characters.
	+ replace `std` for *Std* excluding the `.` and special characters.
	+ make the x,y,z characters upper-case excluding the `.` and special characters.
	+ replace `BodyBody` for `Body`.

### Output
the output of this script is a tiny data frame, containing the average of the means and standard deviation measurements for each subject in each activity. This was done using the function `aggregate`, that splits the data frame by a list of variables (Subject and Activity) and performs the average.
The final result is written in the text file `courseProject.txt`.
