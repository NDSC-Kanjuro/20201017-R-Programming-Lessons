library(ggplot2)
library(here)
library(dplyr)
library(readr)

.raw <- read_csv(here("datasets/SuperstoreIndonesia.csv"))
View(.raw)

data <- .raw[, c(2,3,4,5,6,7,19,20,21,22,23,24)]


# ==================
# DATA VISUALIZATION
# ==================
# ggplot itu menggunakan konsep grammar of graphics
#
#
# In short, the grammar tells us that:
#   
# A statistical graphic is a "mapping" of "data variables" to "aesthetic attributes" 
# of geometric objects.
# 
# Specifically, we can break a graphic into the following three essential components:
# 1. data: the dataset containing the variables of interest.
# 2. geom: the geometric object in question. This refers to the type of object 
#    we can observe in a plot. For example: points, lines, and bars.
# 3. aes: aesthetic attributes of the geometric object. For example, x/y position, 
#    color, shape, and size. Aesthetic attributes are mapped to variables in the
#    dataset.


# Konsep Grammar of Graphics di ggplot2
#
# Mapping variabel sebuah data ke atribut aestetic
# kemudian ditampilkan dalam objek geometri

ggplot(data = data, mapping = aes(x=Sales, y=Profit)) +
  geom_point()

plot(x=data$Sales, y=data$Profit)

data %>%  # pipe operator, output baris ini jadi input baris di bawah
  ggplot(mapping = aes(x=Sales, y=Profit)) +
  geom_point()

superstore <- data %>%
  sample_n(5000)


# ======================
# 1 Variabel Kuantitatif
# ======================
# histogram, boxplot

data %>%
  ggplot(mapping = aes(x=Profit)) +
  geom_histogram()

data %>%
  ggplot(mapping = aes(x=Profit)) +
  geom_histogram(bins = 100)

data %>%
  filter(Profit < 50 & Profit > -10) %>%
  ggplot(mapping = aes(x=Profit)) +
  geom_histogram(binwidth = 3)

?geom_histogram

data %>%
  filter(Profit < 50 & Profit > -1) %>%
  ggplot(mapping = aes(x=Profit)) +
  geom_boxplot()

fivenum(superstore$Profit)
summary(superstore$Profit)
IQR(superstore$Profit)

# Histogram:
# - Persebaran data/distribusi data
#     - Skewness (bell-shaped, right skewed, left skewed)
#     - Modality (unimodal, bimodal, uniform) <- Modus

# Boxplot:
# - IQR -> kotak di boxplot
# - Median -> garis di dalam kotak
# - Whishker -> garis sepanjang data terakhir yang masih berada
#               di 1.5 IQR
# - Outlier -> titik/point di luar dari 1.5 IQR



# scatterplot kurang cocok untuk 1 variabel kuantitatif
data %>%
  ggplot(mapping = aes(x=Profit)) +
  geom_point()

data %>%
  arrange(Profit) %>%
  ggplot(mapping = aes(x=Profit)) +
  geom_point()

plot(sort(data$Profit))



hist(rnorm(n=700, mean=165, sd=3))
hist(rnorm(n=700, mean=155, sd=3))

hist(
  c(rnorm(n=700, mean=165, sd=3), rnorm(n=700, mean=155, sd=3))
)



# 1 Variable Kualitatif
# Barplot
superstore %>%
  ggplot(mapping = aes(x=`Ship Mode`)) +
  geom_bar()



# 2 Variabel Kuantitatif
# Scatter Plot
#
# Istilah dua variable:
# - explanatory variable -> response variable
# - independent variable -> dependent variable
superstore %>%
  ggplot(mapping = aes(x=Discount, y=Profit)) +
  geom_point() +
  geom_smooth(method = "lm")
?geom_smooth

# Scatterplot:
# - Asosiasi/Korelasi antara kedua variable





# 2 Variable Kualitatif
# barplot
unique(superstore$`Ship Mode`)
superstore$`Ship Mode` <- factor(superstore$`Ship Mode`, levels=c(
  "Standard Class", "Second Class", "First Class", "Same Day"
))

superstore %>%
  ggplot(mapping = aes(x=`Ship Mode`, fill=`Order Priority`)) +
  geom_bar()

# Stacked Barplot
superstore %>%
  ggplot(mapping = aes(x=`Ship Mode`, fill=`Order Priority`)) +
  geom_bar(position = "stack")

# Percent stacked barplot
superstore %>%
  ggplot(mapping = aes(x=`Ship Mode`, fill=`Order Priority`)) +
  geom_bar(position = "fill")

# Grouped barplot
superstore %>%
  ggplot(mapping = aes(x=`Ship Mode`, fill=`Order Priority`)) +
  geom_bar(position = "dodge")

# Gimana kita milih jenis barchart yang sesuai??


View(.raw)
# Pake scatterplot tapi dibedain pakai variable kualitatif
data_raw <- .raw %>%
  sample_n(10000)

data_raw %>%
  filter(Sales < 3000) %>%
  ggplot(mapping = aes(x=Sales, y=Profit, color=Category)) +
  geom_point()

data_raw %>%
  filter(Sales < 3000) %>%
  ggplot(mapping = aes(x=Sales, y=Profit, alpha=Category)) +
  geom_point(color="#113355")

data_raw %>%
  sample_frac(.4) %>%
  filter(Sales < 3000) %>%
  ggplot(mapping = aes(x=Sales, y=Profit)) +
  geom_point(color="#113355", alpha=.5, position="jitter") +
  theme_minimal()
