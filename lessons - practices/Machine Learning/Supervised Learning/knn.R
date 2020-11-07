library(class)
library(dplyr)
library(here)
data = read.csv(here("../Supervised Learning/knn_traffic_signs.csv"))

#model = knn(data_train,data_test,label_train,k) #bikin model knn
#mean(model == test_label)#melihat akurasi

## 75% of the sample size
smp_size <- floor(0.75 * nrow(data))

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(data)), size = smp_size)

train_data <- data[train_ind, ]
test_data <- data[-train_ind, ]
train_label <- train_data$sign_type
test_label <- test_data$sign_type

model <-knn(train = train_data[-c(1,2,3)],test = test_data[-c(1,2,3)],cl = train_label,k=2) 
mean(model == test_label) #melihat akurasi 

table(model,test_label) #confusion matrix melihat apa dan berapa prediksi yang salah




