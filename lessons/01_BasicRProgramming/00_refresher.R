install.packages(c("tidyverse", "here", "nycflights13"))

library(nycflights13)
library(tidyverse)
flights

# Tipe Data Primitif
# numeric
1
class(1)
class(NaN)

# integer
class(1L)

# character
"string"
class("string")
class("1")

# logical
class(T)
class(TRUE)
class(NA)

# NULL
class(NULL)

typeof(1) #kalo typeof lebih low-level atau lebih deket ke bahasa mesin
typeof(mtcars)
class(mtcars) #lebih high-level, atau kayak cara pandang kita ke datanya



# Tipe data kolektif
# Vector (1D)
vector1 <- c(1,2,3,4)
class(vector1)
vector2 <- c(1,2,3,"4")
class(vector2)

class(c(1L, 2L, 4L)) # karakteristiknya dia itu harus satu tipe data
class(c(1L, 2L, 4))
class(c(TRUE, 1L, 2L))
class(c(1L, "2L", 4)) # Tingkatan: logical -> integer -> numeric/double -> character

# List (1D)
list1 <- list(c(1,2,3,4,5), 
              "character") # dia tipe data di dalamnya bisa heterogen
list1[2]
list1[1:2]
list1[[1]]

# Penamaan
vector3 <- c("jan" = 1, "feb" = 2, "mar" = 3)
names(vector3) <- c("satu", "dua", "tiga")
vector3

list2 <- list("Januari" = 100, "Pelanggan" = c("Rudi", "Dito"))
list2
names(list2)

vector3["satu"]
list2["Pelanggan"]
list2[[1]]


# Matrix (Vector tapi 2D)
matrix(c(1,2,1,4,2,3,4,5,7), nrow = 3, ncol = 3)
matrix(c(1,2,1,4,2,3,4,5,7), ncol = 3, byrow = TRUE)
cbind(c(1,1,1), c(2,2,2), c(3,3,3))
rbind(c(1,1,1), c(2,2,2), c(3,3,3))

matrix1 <- rbind(c(1,1,1), c(2,2,2), c(3,3,3), c(4,4,4))
dim(matrix1) # atribut pertama
colnames(matrix1) <- paste0("col_", c(1,2,3))
rownames(matrix1) <- paste0(c(1,2,3,4), "_row")

names(matrix1) <- paste0("dat_", 1:12)
matrix1["dat_10"]
matrix(c(matrix1), ncol = 3)


# dataframe (2D, heterogen, tapi satu kolom itu satu tipe data)
mtcars$vs <- as.character(mtcars$vs)
mtcars$vs[10] <- 3

mtcars$vs
mtcars[,3]
mtcars[1:2,]
mtcars[c(1,2), ]
mtcars[ c(rep(FALSE,25), rep(TRUE, 7)) , c("vs", "am")]

mtcars[ mtcars$vs != 1 , c("am", "vs")]

class(mtcars[1,])
dim(mtcars[1,])

dim(mtcars)
names(mtcars)
colnames(mtcars)
rownames(mtcars)


mtcars[ mtcars$vs == 1 , ]
mtcars %>%
  filter(vs == 1)

vector1 + 10
paste0(vector1, 10)
paste(vector1, 10, sep = "hahahaha")

vector1 + c(100,) 

var1 <- 101

if ( var1%%2 == 0) {
  print("var1 adalah bilangan genap")
} else {
  print("var1 adalah bilangan ganjil")
}

if ( 0 ) { # kalau nerima TRUE, 1, lebih dari 1, yang penting selain 0 
  print("var1 adalah bilangan genap")
} else { # kalau tidak, jalankan perintah berikut
  print("var1 adalah bilangan ganjil")
}

if ( var1%%2 ) {
  print("var1 adalah bilangan ganjil")
} else {
  print("var1 adalah bilangan genap")
}

var2 <- 3

# cara kerja while mirip sama if, cuman bedanya kode bakal dijjalankan hanya ketika
# conditional nya bernilai false
while ( var2 <= 100 ) {
  var2 <- var2 + 13
  if (var2 == 55) {
    print(var2)
  }
}
print(var2)

# kalo for itu, kita udah tau opsi atau jumlah
for (i in 1:10) {
  if ( i == 6 ) {
    next
  } else if ( i == 8 ){
    break
  }
  print(paste(i, "-- heloo"))
}
for (i in 1:10) {
  if ( i == 6 ) {
    next
  }
  if ( i == 8 ){
    break
  }
  print(paste(i, "-- heloo"))
}

for (i in 1:100) {
  if (i %% 7 == 0) {
    if (i %% 5 == 0) {
      print(i)
    } else if (i %% 3) { #apakah ini alternatif dari yang atas??
      print(paste0("ho", i))
    } else {
      print(paste0("he", i))
    }
  }
  if (i %% 13 == 0) {
    print(paste0("13 - ", i))
  }
}

var3 <- 100

if (var3 < 101) {
  if (var3 > 99) {
    print(TRUE)
  }
}

fun1 <- function(paramater = 4) {
  # coding panjang
  return(parameter * 100)
}
print(100)

# git config --global user.email "you@example.com"
# git config --global user.name "Your Name"