library(dplyr)
library(ggplot2)
library(here)
library(caret)
library(corrplot)
library(skimr)

raw <- read.csv(here("../AB_US_2020.csv"))
str(raw)
summary(raw)
sum(is.na(raw))
sum(is.null(raw))
data.class(raw)

skim(raw)

in_var <- select(raw,price)
dep_var <- select(raw,-c(name,host_name,neighbourhood_group,last_review,price))
