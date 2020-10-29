# install.packages("nycflights13")

library(readr)
library(dplyr)
library(here)
library(nycflights13)

raw_superstore <- read_csv(here("datasets/SuperstoreIndonesia.csv"))

length(raw_superstore)
ncol(raw_superstore)
nrow(raw_superstore)

superstore <- raw_superstore[, c(2,3,4,5,6,19,20,21,22,23,24)]

superstore

# Pipe Operator ( %>% )
# =====================
# fungsi: meningkatkan readibility
#
# Cara Kerja:
# z = f( g(x) )
# 
# x -> g() -> y
# y -> f() -> z
#
# x %>%
#   g() %>%
#   f()
# hasilnya sama dengan z

sqrt(sum(superstore$Quantity))

superstore$Quantity %>%
  sum() %>%
  sqrt()


# Kosa kata inti
# - filter
# - select
# - mutate
# - summarise
# - group by


# Filter Function
# ===============
# fungsi: memilih baris sesuai conditional yang kita inginkan

10 > 3
10 %% 2 == 0

superstore[, c(1,2,3,8:10)] %>%
  filter(Profit < 0)

superstore[superstore$Profit < 0, c(1,2,3,8:10)]


# Select Function
# ===============
# fungsi: memilih kolom/variabel

# fungsi ends_with dan start_with
superstore %>%
  select(ends_with("ID"), ends_with("date"), Profit) %>%
  filter(Profit > 0)

superstore %>%
  select(starts_with("c"))

# fungsi everything untuk memilih semua kolom tersisa
superstore %>%
  select(Profit, everything())

superstore[, c(1,3,4,5,6)]
c(superstore$Profit, superstore$`Order ID`)
superstore$Profit


# Fungsi Mutate
# =============
# fungsi: transformasi variabel dari data yang udah ada

# misalkan profit dalam dolar, terus mau dikonversi ke euro
# 1 USD = 1.5 EUR
kurs_USD_EUR = 1.5
superstore %>%
  select(Profit) %>%
  mutate(Profit_in_EUR = Profit*kurs_USD_EUR) %>%
  head()

cbind(superstore, Profit_in_IDR = superstore$Profit*13000) %>%
  head()

superstore$Profit_in_EUR <- superstore$Profit * 1.5


# Fungsi Summarise/Summarize
# ==========================
# fungsi: merangkum atau mengambil benang merah

superstore %>%
  filter(is.na(`Shipping Cost`)) %>%
  select(`Shipping Cost`) %>%
  mutate(`Shipping Cost` = 5) 

superstore %>%
  select(`Shipping Cost`) %>%
  mutate(`Shipping Cost` = ifelse(
    is.na(`Shipping Cost`), 5, `Shipping Cost`)
  )  %>%
  summarise(
    mean = mean(`Shipping Cost`),
    median = median(`Shipping Cost`)
  )

superstore %>%
  select(`Shipping Cost`) %>%
  summarise(
    mean = mean(`Shipping Cost`, na.rm = T),
    median = median(`Shipping Cost`, na.rm = T)
  )


# Fungsi Group BY
# ===============
# fungsi: mengelompokkan observasi berdasarkan kategori tertentu
#
# nominal, ordinal -> data kualitatif atau categorical
# contohnya adalah `Order Priority`

superstore %>%
  group_by(`Order Priority`) %>%
  select(c(9:11)) %>%
  summarise(
    mean = mean(`Shipping Cost`, na.rm = T),
    median = median(`Shipping Cost`, na.rm = T)
  )

superstore %>%
  group_by(`Order Priority`) %>%
  select(c(9:11)) %>%
  mutate(
    mean = mean(`Shipping Cost`, na.rm = T),
    median = median(`Shipping Cost`, na.rm = T)
  )

names(superstore)
unique(superstore$`Order Priority`)

# Fungsi tambah

# distinct
data <- superstore[1:5, c(1, 9:11)]
data[6:9, ] <- data[1, ]
data$Profit[6:9] <- rnorm(4)*5 + 5
data$`Shipping Cost`[6:9] <- rnorm(4)*5 + 5
data$`Order Priority`[6:9] <- c("Medium", "Low", "High", "Critical")

data %>%
  distinct(`Order ID`)

unique(data$`Order ID`)

# sample_n dan sample_frac
superstore %>%
  sample_n(10)
superstore %>%
  sample_frac(.5)

superstore %>%
  sample_n(100) %>%
  sample_n(1000, replace = TRUE)
superstore %>%
  sample_n(100) %>%
  sample_frac(10, replace = TRUE)

# slice
superstore[1:5, ]
superstore %>%
  slice(1:5)

# top_n
head(superstore, 100)
superstore %>%
  top_n(100)

# Sidenote
# ========
?NA
?superstore
?mtcars

# packages::object (object itu kan bisa fungsi, dataset, dll)
dplyr::select(superstore, Profit)

# Object itu bisa variable, bisa fungsi dll
my_variable <- 5
my_function <- function(n) {n}

# NA itu merupakan special value
NA == NULL

# Control Structure
if (10 > 2) {
  print(TRUE)
} else {
  print(FALSE)
}

for (i in 1:10) {
  print(i)
}

# Fungsi (menerima input, menghasilkan output)
ifelse(c(1,2,3,4,5) %% 2 == 0, "Genap", "Ganjil")
ifelse(is.na(superstore$`Shipping Cost`), 
       5, superstore$`Shipping Cost`)

# mean, median, dll punya argumen/parameter na.rm
mean(c(1,2,1,31,4,1, NA), na.rm = TRUE)
mean(c("123", "2314"))