library(dplyr)
library(ggplot2)
library(here)
library(caret)
library(corrplot)
library(skimr)
library(lubridate)
library(RANN)
library(caretEnsemble)

raw<- read.csv(here("../AB_US_2020.csv"))

str(raw)
summary(raw)
skim(raw)

data<- select(raw,c(latitude,longitude,minimum_nights,number_of_reviews,
                     calculated_host_listings_count,availability_365,room_type,price))

data$room_type<- as.factor(data$room_type)
str(data)


set.seed(1234)
row_train<- createDataPartition(data$price,p=0.7,list=FALSE)
data_train <- data[row_train,]
data_test<- data[-row_train,]
X <- select(data_train,-price)
Y <- data_train$price
y <- data_test$price

preProcess_missingdata_model <- preProcess(data_train, method='knnImpute')
preProcess_missingdata_model

data_train <- predict(preProcess_missingdata_model, newdata = data_train)
anyNA(data_train)

str(data_train)

dummies_model <- dummyVars(price ~ ., data=data_train)

# Create the dummy variables using predict. The Y variable (Purchase) will not be present in trainData_mat.
trainData_mat <- predict(dummies_model, newdata = data_train)

# # Convert to dataframe
trainData <- data.frame(trainData_mat)
str(trainData)

preProcess_range_model <- preProcess(trainData, method='range')
trainData <- predict(preProcess_range_model, newdata = trainData)

trainData$price <-Y

model_mars = train(price ~ ., data=trainData, method='earth')
fitted <- predict(model_mars)

model_mars

plot(model_mars, main="Model Accuracies with MARS")

testData1<- predict(dummies_model, data_test)
testData1<-data.frame(testData1)
testData2 <- predict(preProcess_range_model, testData1)
testData2$price <- y

predicted <- predict(model_mars, testData2)
head(predicted)
RMSE(predicted,testData2$price)
std.error(testData2$price)

sample_train <- sample_n(trainData,20000)
sample_test <- sample_n(testData2,10000)



trainControl <- trainControl(method="repeatedcv", 
                             number=5, 
                             repeats=3,
                             verboseIter=TRUE)

algorithmList <- c('ranger','earth', 'xgbDART', 'svmRadial')

set.seed(100)
models <- caretList(price ~ ., data=sample_train, trControl=trainControl, methodList=algorithmList) 
results <- resamples(models)
summary(results)