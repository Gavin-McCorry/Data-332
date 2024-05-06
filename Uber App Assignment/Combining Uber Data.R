library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(lubridate)
library(dplyr)


setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332/Uber App Assignment")


df_1 <- read.csv("uber-raw-data-apr14.csv")
df_2 <- read.csv("uber-raw-data-aug14.csv")
df_3 <- read.csv("uber-raw-data-jul14.csv")
df_4 <- read.csv("uber-raw-data-jun14.csv")
df_5 <- read.csv("uber-raw-data-may14.csv")
df_6 <- read.csv("uber-raw-data-sep14.csv")

df <- rbind(df_1, df_2, df_3, df_4, df_5, df_6)

# Convert to datetime format
df$Date.Time <- mdy_hms(df$Date.Time)

# Extract the hour
df$Hour <- hour(df$Date.Time)
df$Month <- month.abb[month(df$Date.Time)]
df$Day <- day(df$Date.Time)
df$Day_Of_Week <- weekdays(df$Date.Time, abbreviate = TRUE)

saveRDS(df, file = "Combined_Uber_Data.rds")
