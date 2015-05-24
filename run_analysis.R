# merge training and test data

s1 <- read.table("test/subject_test.txt", header=F)
x1 <- read.table("test/x_test.txt", header=F)
y1 <- read.table("test/y_test.txt", header=F)

s2 <- read.table("train/subject_train.txt", header=F)
x2 <- read.table("train/x_train.txt", header=F)
y2 <- read.table("train/y_train.txt", header=F)

s <- rbind(s1, s2)
x <- rbind(x1, x2)
y <- rbind(y1, y2)

# read features and select only mean and sd of measurement
fea <- read.table("features.txt", header=F)
fea_id <- grep("mean\\(\\)|std\\(\\)", fea[,2], ignore.case = TRUE)

# add descriptive variable names for measurements
names(x) <- fea[,2]

# read activity labels and merge it with measurement set
labels <- read.table("activity_labels.txt", header=F)
y_l <- merge(y, labels, by.x=names(y)[1], by.y=names(labels)[1])

# generate tidy data
tdata <- cbind(s,y_l[,2],x[,fea_id])

# add descriptive variable names (features already have descriptive names)
names(tdata)[1:2] <- c("Subject","Activity")

# create second data set with the average of each variable for each activity and each subject
library(plyr)

tdata_mean <- ddply(tdata, .(Subject, Activity), summarize, 
              mean(tdata[,3]),
              mean(tdata[,4]),
              mean(tdata[,5]),
              mean(tdata[,6]),
              mean(tdata[,7]),
              mean(tdata[,8]),
              mean(tdata[,9]),
              mean(tdata[,10]),
              mean(tdata[,11]),
              mean(tdata[,12]),
              mean(tdata[,13]),
              mean(tdata[,14]),
              mean(tdata[,15]),
              mean(tdata[,16]),
              mean(tdata[,17]),
              mean(tdata[,18]),
              mean(tdata[,19]),
              mean(tdata[,20]),
              mean(tdata[,21]),
              mean(tdata[,22]),
              mean(tdata[,23]),
              mean(tdata[,24]),
              mean(tdata[,25]),
              mean(tdata[,26]),
              mean(tdata[,27]),
              mean(tdata[,28]),
              mean(tdata[,29]),
              mean(tdata[,30]),
              mean(tdata[,31]),
              mean(tdata[,32]),
              mean(tdata[,33]),
              mean(tdata[,34]),
              mean(tdata[,35]),
              mean(tdata[,36]),
              mean(tdata[,37]),
              mean(tdata[,38]),
              mean(tdata[,39]),
              mean(tdata[,40]),
              mean(tdata[,41]),
              mean(tdata[,42]),
              mean(tdata[,43]),
              mean(tdata[,44]),
              mean(tdata[,45]),
              mean(tdata[,46]),
              mean(tdata[,47]),
              mean(tdata[,48]),
              mean(tdata[,49]),
              mean(tdata[,50]),
              mean(tdata[,51]),
              mean(tdata[,52]),
              mean(tdata[,53]),
              mean(tdata[,54]),
              mean(tdata[,55]),
              mean(tdata[,56]),
              mean(tdata[,57]),
              mean(tdata[,58]),
              mean(tdata[,59]),
              mean(tdata[,60]),
              mean(tdata[,61]),
              mean(tdata[,62]),
              mean(tdata[,63]),
              mean(tdata[,64]),
              mean(tdata[,65]),
              mean(tdata[,66]),
              mean(tdata[,67]),
              mean(tdata[,68]))

names(tdata_avg) <- names(tdata)

# write data
write.table(tdata_mean, "tdata.txt", row.names=F, col.names=F)