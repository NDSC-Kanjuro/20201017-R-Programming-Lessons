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
setwd("lessons/")
setwd(here()) # buat setting directory

here("datasets/balitaGiziBuruk-3.csv") # menggenerate absolute directory

# Pemakaian directory
# 1) bisa pakai absolue directory
data <- read_csv("C:/Users/Dito/Documents/20201017 R Programming Lessons/datasets/balitaGiziBuruk-3.csv")
data <- read_csv("D:/Projects/20201017 R Programming Lessons/datasets/balitaGiziBuruk-3.csv")
# 2) bisa pakai relative directory
setwd("lessons/02_DplyrDataWrangling/")
data <- read_csv("datasets/balitaGiziBuruk-3.csv")
data <- read_csv("../../datasets/balitaGiziBuruk-3.csv")

# Solusi permasalahan absolute dan relative directory
here("datasets/balitaGiziBuruk-3.csv")

# data.frame vs tibble
class(mtcars)
mtcars
as_tibble(mtcars)
class(as_tibble(mtcars))
tibble("hello world" = c(2,1,1,1,1,1,2))
data.frame("hello world" = c(2,1,1,1,1,1,2))

# read_csv and read.csv
# csv: comma separated value
# tsv: tab separated value
read_csv(here("datasets/balitaGiziBuruk-3.csv"))
read.csv(here("datasets/balitaGiziBuruk-3.csv"), sep="\t")
?read_csv
?read.csv

path <- here("datasets/balitaGiziBuruk-3.csv")

read_csv(path, col_names = TRUE, col_types = NULL,
         quote = "\"", comment = "", trim_ws = TRUE, skip = 0,
         n_max = 5, skip_empty_rows = TRUE)