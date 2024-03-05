library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

# clears environment on run
rm(list = ls()) 

## Setting up working directory
setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332")

df_truck_0001 <- read_excel('In-Class-Examples/Data/truck data 0001.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_0369 <- read_excel('In-Class-Examples/Data/truck data 0369.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1226 <- read_excel('In-Class-Examples/Data/truck data 1226.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1442 <- read_excel('In-Class-Examples/Data/truck data 1442.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1478 <- read_excel('In-Class-Examples/Data/truck data 1478.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1539 <- read_excel('In-Class-Examples/Data/truck data 1539.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1769 <- read_excel('In-Class-Examples/Data/truck data 1769.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df_pay <- read_excel('In-Class-Examples/Data/Driver Pay Sheet.xlsx', .name_repair = 'universal')

# Combined Table
df <- rbind(df_truck_0001, df_truck_0369, df_truck_1226, df_truck_1442, df_truck_1478, 
                        df_truck_1539, df_truck_1769)

# Cheecking to see if all the same id numbers are in each table, df and df_pay
# by grouping the id numbers from the df we can see if they all match the ones in the df_pay

df_pivot <- df %>%
  group_by(Truck.ID) %>%
  summarize(count = n()
  )


# Now we left join the two tables
# The many of the many to on relationship is on the left of the left join
# if after the join you have more rows then you started with that is an exploding join
# tht happens if you dont have a unique key to join the tables on

df <- left_join(df, df_pay, by = c('Truck.ID'))

# In class activity
# see in a chart, how much each driver got paid for there trips

# First calculate the pay for each trip, put it in the table
df[c('pay')] <- (df$Odometer.Ending - df$Odometer.Beginning) * df$labor_per_mil
df[c('miles_driven')] <- df$Odometer.Ending - df$Odometer.Beginning

df_pay_pivot <- df %>%
  group_by(Truck.ID) %>%
  summarize(count = n(), 
            total_pay = sum(pay, na.rm = TRUE), 
            total_miles = sum(Odometer.Ending - Odometer.Beginning)
  )

ggplot(df_pay_pivot, aes(x = Truck.ID, y = total_pay, fill = Truck.ID)) +
  geom_col() + 
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1)) +
  xlab("Driver ID") + 
  ylab(" Total Pay")
  




