library(class) #library utk model klasifikasi
library(dplyr) #library utk proses data
library(here)  #library untuk manage direktori
library(heatmaply) #library untuk normalisasi data

#import data
data = read.csv(here("../Supervised Learning/knn_traffic_signs.csv"))

#model = knn(data_train,data_test,label_train,k) #bikin model knn
#mean(model == test_label)#melihat akurasi

# 75% of the sample size
smp_size <- floor(0.75 * nrow(data))

#normalisasi data agar antar fitur bobotnya tidak jomplang dalam knn
normal_data <- normalize(data)

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(normal_data)), size = smp_size)

#membagi data jadi train dan test data
train_data <- normal_data[train_ind, ]
test_data <- normal_data[-train_ind, ]
train_label <- train_data$sign_type
test_label <- test_data$sign_type

#membuat model knn
model <-knn(train = train_data[-c(1,2,3)],test = test_data[-c(1,2,3)],cl = train_label,k=2) 
mean(model == test_label) #melihat akurasi 

table(model,test_label) #confusion matrix melihat apa dan berapa prediksi yang salah





