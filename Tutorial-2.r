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