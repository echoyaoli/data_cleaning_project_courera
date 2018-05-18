# load packages
library(dplyr)
library(stringr)
library(plyr)
library(reshape2)

# load the data files
test <- read.csv('./data/UCI HAR Dataset/test/X_test.txt',header = F,sep='')
test_label <- read.csv('./data/UCI HAR Dataset/test/y_test.txt',header = F)
train <- read.csv('./data/UCI HAR Dataset/train/X_train.txt',header = F,sep='')
train_label <- read.csv('./data/UCI HAR Dataset/train/y_train.txt',header = F)
activity_label <- read.csv('./data/UCI HAR Dataset/activity_labels.txt',header = F)
subject_test <- read.csv('./data/UCI HAR Dataset/test/subject_test.txt',header = F)
subject_train <- read.csv('./data/UCI HAR Dataset/train/subject_train.txt',header = F)
features <- read.csv('./data/UCI HAR Dataset/features.txt',header = F,sep = '\t')

# rename the columns in each table to descriptive
names(test)<- features[,1]
names(train) <- features[,1]
names(test_label)<-'activity'
names(train_label)<- 'activity'
names(subject_test)<- 'subject'
names(subject_train)<- 'subject'

# select only the measurements on the mean and standard deviation for each measurement
# mean is expressed as 'mean', and standard deviation is 'std'
colselect <- c('mean','std')
test_s <- test %>% select(grep(paste(colselect,collapse="|"),colnames(test)))
train_s <- train %>% select(grep(paste(colselect,collapse = "|"),colnames(train)))

# uses descriptive activity names to name the activities in the data set
pattern <- c('1','2','3','4','5','6')
replace <- c('walking','walking_upstair','walking_downstair','sitting','standing','lying')
test_label_d<- mapvalues(test_label[,1],from = pattern, to= replace)
train_label_d <- mapvalues(train_label[,1],from = pattern, to=replace )

# add discriptive activity label,group information to test/train table
test_s <- cbind(group='test',subject_test,test_label_d,test_s)
train_s <- cbind(group='train',subject_train,train_label_d,train_s)
names(test_s)[3]<- 'label'
names(train_s)[3]<- 'label'

#merge test and train dataset together
# the new dataset as required are called 'df'
df <- merge(test_s,train_s,all = T,no.dups = F)
colnames(df) <- gsub('\\d*','',colnames(df))
colnames(df) <- gsub('\\()','',colnames(df))


# creat new data set with the average of each variable for each activity and each subject
str(df)
df$subject <- as.factor(df$subject)
df_average <-df %>%
  group_by(subject,label,group) %>% summarise_if(is.numeric,mean)
colnames(df_average)[4:82]<- paste('average',colnames(df_average)[4:82],sep = '-')

# tidy df_average
df_average_tidy <- 
  melt(df_average,id.vars = c('group','subject','label'),value.name = 'average', variable.name = 'description')
# optional
# remove the "average-" from description,
# since is duplicate for the value name 
# people know the value is average of means from the measurement
df_average_tidy$description <- str_remove(df_average_tidy$description,'average- ')              
