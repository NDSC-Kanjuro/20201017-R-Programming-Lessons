library(rpart) #library untuk bikin decision tree
library(dplyr) #library untuk proses data
library(here)  #library untuk manage direktori
library(rpart.plot)  #library untuk plotting decision tree

#import data
raw_data <- read.csv(here("../Supervised Learning/loans.csv")) 

#preprocess data
#membuat label raw data
d <-raw_data%>%
  filter(xor(default == 0,keep == 0))


raw_data$outcome <- 0
for (i in 1:nrow(raw_data)){
  if(raw_data$keep[i] == 0 & raw_data$default[i] == 0){
    raw_data$outcome[i] <- "DEFAULT" #jika belum pernah bayar labelnya default
  }
  else if(raw_data$keep[i]==1 & raw_data$default[i]==1){
    raw_data$outcome[i]<- "REPAID" #jika pernah bayar pernah default labelnya repaid
  }
  else if(raw_data$keep[i]== 1){
    raw_data$outcome[i] <- "REPAID" #jika pernah bayar labelnya repaid
  }
  else if(raw_data$default[i]==1){
    raw_data$outcome[i] <- "DEFAULT" #jika pernah default labelnya default
  }
}

ready_data <- select(raw_data, -c(1,2,3)) #drop kolom yang tidak butuh


#split training dan test data
train_perc <- 0.75  #tentukan persentase data train
n <- nrow(ready_data)*train_perc  # dapatkan jumlah row data train
sample_rows <- sample(nrow(ready_data),n) #ambil acak sejumlah data train dr raw data
train_data <- ready_data[sample_rows,]  #buat data train
test_data <- ready_data[-sample_rows,]  #buat data test

#membuat model 
model <- rpart(outcome~loan_amount + credit_score,data=train_data,method ="class")

#membuat prediksi model
test_data$pred <- predict(model,test_data,type="class")

#melihat akurasi model
mean(test_data$pred == test_data$outcome) #melihat berapa persen akurasi model
table(test_data$pred,test_data$outcome) #membuat confusion matrix


