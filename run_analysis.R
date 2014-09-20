## STEP 1

# read the data for the test set 
test.set <- read.table("UCI HAR Dataset/test/X_test.txt")
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
labels.test <- read.table("UCI HAR Dataset/test/y_test.txt")
# merge subject, lables and measurments for the test set
full.test.set <- cbind(subject.test, labels.test, test.set)

# read the data for the train set 
train.set <- read.table("UCI HAR Dataset/train/X_train.txt")
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
labels.train <- read.table("UCI HAR Dataset/train/y_train.txt")
# merge subject, lables and measurments for the train set
full.train.set <- cbind(subject.train, labels.train, train.set)

# merge the two data sets
full.data.set <- rbind(full.test.set, full.train.set)
# attribute names to the columns
measurments <- read.table("UCI HAR Dataset/features.txt")
colnames(full.data.set) <- c("Subject", "Activity", as.character(measurments[, 2]))


## STEP 2

# extract columns with measurements on the mean and standard deviation
ex.mean <- grep("mean()", colnames(full.data.set))
ex.std <- grep("std()", colnames(full.data.set))
# exclude columns with "meanFreq()"
meanFreq <- grep("meanFreq()", colnames(full.data.set))
ex.mean <- ex.mean[!is.element(ex.mean, meanFreq)]

# create a subset of the full.data.set
data.set <- full.data.set[, c(1, 2, ex.mean, ex.std)]


## STEP 3

# read the activity lables
activity.lables <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity.lables) <- c("Activity", "Activity.Name")
# merge data.set and activity.lables
my.data.set <- merge(activity.lables, data.set, by = "Activity", all = TRUE, sort = FALSE)


## STEP 4

# removing special characters and giving descriptive names to the variables.0..0

new.colnames <- colnames(my.data.set)[4: 68]
new.colnames <- gsub("\\()", "", new.colnames)
new.colnames <- gsub("\\-", " ", new.colnames)
new.colnames <- gsub("Body", " Body", new.colnames)
new.colnames <- gsub("Gravity", " Gravity", new.colnames)
new.colnames <- gsub("Acc", " Acceleration", new.colnames)
new.colnames <- gsub("Gyro", " Gyroscope", new.colnames)
new.colnames <- gsub("Mag", " Magnitude", new.colnames)
new.colnames <- gsub("Jerk", " Jerk", new.colnames)
new.colnames <- gsub("t ", "Time ", new.colnames)
new.colnames <- gsub("f ", "Frequency ", new.colnames)
colnames(my.data.set)[4: 68] <- new.colnames


## STEP 5
# grouping by Subject ans Activity.Name in a new table
my.data.set2 <-my.data.set %>% group_by(Subject, Activity.Name)
# calculating the average of the groups
result <- my.data.set2  %>% summarise_each(funs(mean))
# write.table(result, file = "course_project.txt", row.name = FALSE)
