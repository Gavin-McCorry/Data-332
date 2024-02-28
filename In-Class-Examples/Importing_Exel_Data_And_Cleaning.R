library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

# clears environment on run
rm(list = ls()) 

## Setting up working directory
setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332")

df_truck <- read_excel('In-Class-Examples/Data/NP_EX_1-2.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')


# selecting columns
df  <- df_truck[, c(4:15)]
# deselect columns
df <- subset(df, select = -c(...10))

#getting difference in days within a column
date_min <- min(df$Date)
date_max <- max(df$Date)

number_of_days_on_the_road <- date_max - date_min
print(number_of_days_on_the_road)

days <- difftime(max(df$Date), min(df$Date))
print(days)
number_of_days_recorded <- nrow(df)

total_hours <- sum(df$Hours)
avg_hrs_per_day_rec <- round(total_hours / number_of_days_recorded, digits = 3)
print(avg_hrs_per_day_rec)

df$fuel_cost <- df$Gallons * df$Price.per.Gallon

df[c('warehouse', 'starting_city_state')] <-
  str_split_fixed(df$Starting.Location, ',', 2)

df$starting_city_state <- gsub(',', "", df$starting_city_state)

# df[c('col1', 'col2')] <-
#   str_split_fixed(df$city_state, ' ', 2)


## Summary Questions:
# 1) Days of Driving
days_of_driving = as.numeric(last(df$Date) - first(df$Date))

# 2) Hours of Driving
hours_of_driving = sum(df$Hours)

# 3) Average hours per day
average_hours_per_day = hours_of_driving / days_of_driving

# 4) Total Expenses
total_expenses = sum(df$fuel_cost) + sum(df$Tolls) + sum(df$Misc)

# 5) Total fuel expenses
total_fuel_expenses = sum(df$fuel_cost)

# 6) Other Expenses
other_expenses = sum(df$Misc) + sum(df$Tolls)

# 7) Total Gallons Consumed
total_gallons = sum(df$Gallons)

# 8) Total miles driven
total_miles_driven = sum(df$Odometer.Ending) - sum(df$Odometer.Beginning)

# 9) Miles peer gallon
miles_pe_gallon = round(total_miles_driven / total_gallons, 3)

# 10) Total Cost per Mile
total_cost_peer_mile = total_expenses / total_miles_driven

df_starting_pivot <- df %>%
  group_by(starting_city_state) %>%
  summarize(count = n(),
            mean_size_hours = mean(Hours, na.rm = TRUE),
            sd_hours = sd(Hours, na.rm = TRUE),
            total_hours = sum(Hours, na.rm = TRUE),
            total_gallons = sum(Gallons, na.rm = TRUE)
  )

ggplot(df_starting_pivot, aes(x = starting_city_state, y = count)) +
  geom_col() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))


# Splitting Deliveery.Location

df[c('Store', 'delivery_city_state')] <-
  str_split_fixed(df$Delivery.Location, ', ', 2)

df$delivery_city_state <- gsub(',', "", df$delivery_city_state)


df_delivery_pivot <- df %>%
  group_by(delivery_city_state) %>%
  summarize(count = n(), 
            mean_size_hours = mean(Hours, na.rm = TRUE),
            sd_hours = sd(Hours, na.rm = TRUE),
            total_hours = sum(Hours, na.rm = TRUE),
            total_gallons = sum(Gallons, na.rm = TRUE)
            )

ggplot(df_delivery_pivot, aes(x = delivery_city_state, y = count)) + 
         geom_col() + 
         theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

