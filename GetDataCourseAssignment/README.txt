==================================================================
Getting Data - Course Assignment
Run_Analysis.r
==================================================================
Louise Crooks
==================================================================

This script uses the UCI HAR Dataset and summarizes the results by subject and activity. 

The test and train sets were merged for this analysis. The test and train sets were structurally similar, and so 
the same code was used to prepare each set. There were no ID fields in the source data, so the row numbers were used
for joining the subject, activity and feature measures datasets together.

Only means and std measures from the original set of vectors were included in the summary. 

Process Flow: 
=======
Set-up
- Using the 'activity_labels.txt' file, create a lookup table of activity names. 
- Using the 'features.txt' file, create a lookup of features, removing all but the ones that are for mean and std.
Prepare the training set
- Get the training datasets for subject ('subject_train'), labels/activity ('y_train'), and the feature measures ('x_train)
from the 'train' folder. 
- Add the activity name column from the activity name lookup.
- Select only the feature measures from the feature lookup. 
- Merge the three sets together based on an ID generated from the row numbers. 
Prepare the test set
- Follow the same procedure as for training set, but using the test files in the 'test' folder. 
Merge the training and test set
- Use rbind to merge the two
Create the summarized set
- Use ddply to group by subject and activityName, while getting the mean for all other numeric columns

Contents:
=======
- README.txt
- CodeBook.md: A description of the columns in the summarized set
- Run_Analysis.r: The script that produces the summarized set

Notes: 
=======
The script assumes the source dataset is downloaded and resides in the working directory. 

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.