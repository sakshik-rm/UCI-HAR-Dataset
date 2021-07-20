1.  Navigate to UCI HAR Dataset directory and locate the *test and train text files* inside their respective folders, as well as the *features, features info and activity_labels text files.*

2.  Read train and test files from the corresponding folders into variables **x_train**, **y_train**, **x_test**, **y_test**, **subj_train** and **subj_test** using *read.delim(file, header=FALSE, sep="")*

3.  To merge the data, use *merge(all=TRUE)* and assign to '**merged** variable.

4.  To extract only the mean measurements, refer to the full features list on *features.txt* file and note the index of each mean measurement. Then create a *data.frame()* called **means** and add the corresponding indexed values from **merged**.

5.  Similar to Step 4, extract the standard deviations, note the index of each standard deviation measurement. Create another *dataframe()* called **stds** and add the corresponding indexed values from **merged**.

6.  *y_train and y_test files* contain the activities corresponding to the **merged** dataset. First bind the two datasets into one and call the variable **act_labels**. Turning the variable into a *data.frame()* and using *ifelse()*, set the activity labels for each activity number in the dataset. e.g. if activity = 1, label = WALKING, referring to *activity_labels.txt*. Then, using cbind(), bind act_labels with merged and assign to a variable **merged_a.**

7.  To extract all variable names from the *features.txt* file, use *read.delim(header=FALSE, sep=" ", check.names=TRUE)* and assign them to **newnames**. As the indices themselves load with the feature names, only extract the second column with the names using *sapply(as.character)* into **newnames** again. Using *rbind*(), rename the column name to "Activity", overwriting **newnames**. Using **colnames()\<-** assign **newnames** to the column names of **merged_a.**

8.  To create a separate, independent tidy dataset, assign a new variable **tidied** with **merged_a**. As some column names are very similar, make all of them unique by using *make.unique(names())* and assign it to *names()* of **tidied**. Create a variable **mergesub** and assign merged **subj_train** and **subj_test**, using *merge(all=TRUE)*. Rename the columns of **mergesub** using *colnames*() and assign "Subject" to it. Then bind this dataset to **tidied** using *cbind()*. Then using dplyr, pipe **tidied** with *group_by()* to group by Activity and Subject respectively, and *summarise()* to calculate the mean for each activity and each subject.
