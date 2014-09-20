### Introduction
This CodeBook assumes a general knowledge about the project. More details can be found through the link in the *README.md* file in this repository.
The data were dowloaded  from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzipped into the R working directory.

### Step 1
The dataframe *full.test.set* is the result of the merge of:
* *subject.test*, column vector of subjects from the subject_test.txt file
* *labels.test*, column vector of activity lables form the y_test.txt file
* *test.set*, matrix of measurments from the X_test.txt file
The dataframe *full.train.set* is the result of the merge of:
* *subject.train*, column vector of subjects from the subject_train.txt file
* *labels.train*, column vector of activity lables form the y_train.txt file
* *train.set*, matrix of measurments from the X_train.txt file
Having the same number of variables (columns) the two sets were merged into one dataframe, *full.data.set*.
Then names were attributed to the columns of this new dataframe: "Subject" and "Activity" (names arbitrarily chosen) for the first two, a string vector *measurments* from from the features.txt file for all the other.

### Step 2
The measurements on the mean and standard deviation for each measurement were extracted from *full.data.set* and put into a new dataframe, *data.set*, by selecting column names including mean() or std(). Column names including meanFreq() were removed for three reasons:
* a. where mean() and std() had an equal count and a consistent position through *full.data.set*, meanFreq() had no stdFreq() equivalent and their position had not a recursive pattern
* b. no explaination was provided about the variable in the features_info.txt file
* c. Coursera Discussion Forum's consensus about the exclusion

### Step 3
In order to provide descriptive activity names, the dataftame *activity.lables* was extracted from the activity_labels.txt file and columns were arbitrarily renamed "Activity" and "Activity.Name". Then *activity.lables* and *data.set* were merged into a new dataframe, *my.data.set*, by using the common column "Activity".

### Step 4
Except the first three columns in *my.data.set*, all other columns were renamed providing a descriptive label. Special caracters *()-* were removed and abbreviations were substituted by full words according to the explaination provided in the features_info.txt file.

### Step 5
The average of each measurment for each "Activity.Name" and each "Subject" was stored into a new dataframe, *result*. The first grouping factor is "Subject" and the second "Activity.Name" by arbitrary choice.
The result may be written into a .txt file in the working directory by removing '#' and executing the line.
