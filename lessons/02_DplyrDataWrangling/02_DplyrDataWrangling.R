# install.packages("tidyverse")
# install.packages("here")

library(dplyr)
library(readr)
library(ggplot2)
library(here)

# ================
# Tentang Function
# ================
# bahasan: Struktur, evaluasi parameter, cara pemakaian

my_function <- function(param1 = 5, param2){
  result = param1 * (param2+10)
  return(result)
}

# Evaluasi parameter
# 1) by position
my_function(10, 20)
# 2) by name
my_function(param1 = 10, param2 = 35)

# cara2 memakai fungsi
# 1) ngisi semua parameter
my_function(10,20)
# 2) ngisi semua parameter dengan nama parameter
my_function(param1 = 10, param2 = 20)
my_function(param2 = 20, param1 = 10)
# 3) ngisi parameter yang belum ada default
my_function(10)
my_function(param1 = 10)



# ========================
# Tentang directory here()
# ========================
# bahasan: absolute vs relative directory, fungsi here(),
#          fungsi read_csv() dibanding versi base

getwd() # buat lihat directory kita lagi di mana
setwd(here()) # buat setting directory

here("datasets") # menggenerate absolute directory
read_csv("datasets/balitaGiziBuruk-3.csv")

here("datasets/balitaGiziBuruk-3.csv")
here()

