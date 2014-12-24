# Nicholas Giffen - 23 Dec 2014
# Titanic Tutorial 2 - by Trevor Stephens
# Full guide available at: http://trevorstephens.com/

# Set Working Directory and load data sets
setwd("~/Titanic-Kaggle") 
train <- read.csv("~/Titanic-Kaggle/train.csv") 
test  <- read.csv("~/Titanic-Kaggle/test.csv")

# View number of females and males and proportion of each that survived
summary(train$Sex)
prop.table(table(train$Sex, train$Survived))
prop.table(table(train$Sex, train$Survived), 1)

# Since Females survive more often, set females to survive in test set
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1

# Create submission dataframe and output to file
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "gendermodel.csv", row.names = FALSE)

# Summary of passenger ages
summary(train$Age)

# Create Chile column identifying children as those under age 18
train$Child  <- 0
train$Child[train$Age < 18] <- 1

# Create survival table based on Child and Sex
aggregate(Survived ~ Child + Sex, data=train, FUN=sum)
aggregate(Survived ~ Child + Sex, data=train, FUN=length)
aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) {sum(x)/length(x)})