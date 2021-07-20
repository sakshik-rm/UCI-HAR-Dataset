#Pre-analysis
setwd("UCI HAR Dataset/train")
x_train <- read.delim("X_train.txt", header=FALSE, sep="")
y_train <- read.delim("y_train.txt", header=FALSE, sep="")
subj_train <- read.delim("subject_train.txt", header=FALSE, sep="")
setwd("..")
setwd("test")
x_test <- read.delim("X_test.txt", header=FALSE, sep="")
y_test <- read.delim("y_test.txt", header=FALSE, sep="")
subj_test <- read.delim("subject_test.txt", header=FALSE, sep="")

#1
merged <- merge(x_train, x_test, all=TRUE)

#2
means <- data.frame(merged[1:3], merged[41:43], merged[81:83], 
                       merged[121:123], merged[161:163], merged[201], 
                       merged[214], merged[227], merged[240], merged[253], 
                       merged[266:268], merged[345:347],merged[424:426],
                       merged[503],merged[516],merged[529],merged[542])

stds <- data.frame(merged[4:6], merged[44:46], merged[84:86], 
                      merged[124:126], merged[164:166], merged[202], 
                      merged[215], merged[228], merged[241], merged[254], 
                      merged[269:271], merged[348:350], merged[427:429], 
                      merged[504], merged[517], merged[530], merged[543])

#3
act_labels <- rbind(y_train, y_test)
act_labels <- data.frame(ifelse(act_labels$V1==1,"WALKING",
                 ifelse(act_labels$V1==2, "WALKING_UPSTAIRS",
                   ifelse(act_labels$V1==3, "WALKING_DOWNSTAIRS",
                      ifelse(act_labels$V1==4,"SITTING",
                          ifelse(act_labels$V1==5, "STANDING",
                                 ifelse(act_labels$V1==6,"LAYING",0)))))))
merged_a <- cbind(merged, act_labels)
  
#4
setwd("..")
newnames <- read.delim(header=FALSE,"features.txt",sep=" ", check.names = TRUE)
newnames <- sapply(newnames[2], as.character)
newnames <- rbind(newnames, "Activity")
colnames(merged_a) <- newnames

#5
tidied <- merged_a
names(tidied) <- make.unique(names(tidied))

mergesub <- merge(subj_train, subj_test, all=TRUE)
colnames(mergesub) <- "Subject"
tidied <- cbind(tidied, mergesub)

tidied <- tidied %>% group_by(Activity, Subject) %>% summarise_all(mean)

