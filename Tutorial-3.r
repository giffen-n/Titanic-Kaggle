# Nicholas Giffen - 23 Dec 2014
# Titanic Tutorial 3 - 'Decision Trees'
# Full guide from Trevor Stephens available at: http://trevorstephens.com/

# Set Working Directory and load data sets
setwd("~/Titanic-Kaggle") 
train <- read.csv("~/Titanic-Kaggle/train.csv") 
test  <- read.csv("~/Titanic-Kaggle/test.csv")

# Install and load required packages for decision tree plotting
install.packages('rattle')
install.packages('rpart.plot')
install.packages('RColorBrewer')
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# Recreate the gender model
fit <- rpart(Survived ~ Sex, data=train, method="class")
fancyRpartPlot(fit)

# Store fit as Decision Tree on Pclass, Sex, Age, SibSp, Parch, Fare, and Embarked
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method="class")
# Plot it with base-R
plot(fit)
text(fit)
# And then make it look better with fancyRpartPlot!
fancyRpartPlot(fit)

# Now let's make a prediction and write a submission file
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)

# Let's unleash the decision tree and let it grow to the max
#fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, 
#             method="class", control=rpart.control(minsplit=2, cp=0))
#fancyRpartPlot(fit)

# Now let's make a prediction and write a submission file - Commented out due to run time 
# Prediction <- predict(fit, test, type = "class")
# submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
# write.csv(submit, file = "myfullgrowntree.csv", row.names = FALSE)

# Manually trim a decision tree
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train,
             method="class", control=rpart.control(minsplit=20, cp=0.005))
new.fit <- prp(fit,snip=TRUE)$obj
fancyRpartPlot(new.fit)

# Now let's make a prediction and write a submission file
Prediction <- predict(new.fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "mypersonaltree.csv", row.names = FALSE)