#updated file
options(scipen=999)
library(ISLR)
library(Hmisc) # to describe data
library(caret)
library(InformationValue)
data <- ISLR::Default
summary(data)

describe(data)
#find total observations in dataset
nrow(data)

#default: Indicates whether or not an individual defaulted.
#student: Indicates whether or not an individual is a student.
#balance: Average balance carried by an individual.
#income: Income of the individual.

# Train and Test samples

set.seed(1) # set a seed so that you get the same results if you run it again

#Use 70% of dataset as training set and remaining 30% as testing set
sample <- sample(c(TRUE, FALSE), nrow(data), replace=TRUE, prob=c(0.7,0.3))
train <- data[sample, ]
test <- data[!sample, ]  

#fit logistic regression model
model <- glm(default~student+balance+income, family="binomial", data=train)

summary(model)
#predict probability of defaulting - use test data here! For every row in test data a probability is produced

predicted = predict(model, test, type="response")

#convert defaults from "Yes" and "No" to 1's and 0's
test$default <- ifelse(test$default=="Yes", 1, 0)

#find optimal cutoff probability to use to maximize accuracy
#optimal <- optimalCutoff(test$default, predicted)[1]
optimal =0.9

#now create a confusion matrix
confusionMatrix(test$default, predicted)

misClassError(test$default, predicted, threshold=optimal)

#now create some new data as follows
#The probability of an individual with a balance of $1,400, an income of $2,000, and a student status of “Yes” has a probability of defaulting of .0273. Conversely, an individual with the same balance and income but with a student status of “No” has a probability of defaulting of 0.0439
#define two individuals
new <- data.frame(balance = 1400, income = 2000, student = c("Yes", "No"))

# with the already trained model predict the probabilities to default
predict(model, new, type="response")
