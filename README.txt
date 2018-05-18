Peer-graded Assignment: Getting and Cleaning Data Course Project
======================================================================

Yao LI
shuieryao@hotmail.com
======================================================================

Data:
The data for the project (downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
======================================================================

The project contains following files:

1. 'project_codebook.txt' - The code book contains all the varibles and summaries calculated, along with units, and other relevant information

2. 'run_analysis.R' - R script of the analysis

3. 'README.txt' 
======================================================================

The data analysis has been carried out using 'UCI HAR Dataset' data. First, the zip file was downloaded. I read the 'README' file from the folder, and get a general idea about what this data is about and what information is included. Second, I found what file need to read into R to accomplish the requirement of the project. Therefore the picked data files were read in to R. Then I begun the analysis.
======================================================================

Analysis process:
1. read files into R
2. rename the columns in each table into descriptive variables
3. select the variable of measurements on mean and standerd deviation for test group and train group
4. change the variable in activity into decriptive names (ie '1' to 'walking','2' to 'walking upstairs' etc.)
5. add group infomation (test/train) and activity label (walking,lying, etc.) to the table
6. merge the test and train table together and called the merged table 'df'
7. create a second, independent data set with the average of each variable for each activity of each subject in 'df', named 'df_average'
8. tidy df_average, stored as 'df_average_tidy'. Each row represent a single variable.
======================================================================

I didn't do the analysis according to the order listed in the project webpage which is merge the test and the train sets first and than select columns accordingly. Because I think it could creat a rather large dataset and increased the computing time as well as the complexicity to select columns afterword. And I think remove the '()' and keep most of the variable name is good enough for a descriptive variable names.
Comments and correction are welcome.
Thank you for your time.
All the best.