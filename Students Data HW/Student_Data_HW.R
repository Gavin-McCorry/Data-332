library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(lubridate)

## Setting up working directory
setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332")

student_data <- read_xlsx("Students Data HW/Data/Student.xlsx")
registration_data <- read_xlsx("Students Data HW/Data/Registration.xlsx")
course_date <- read_xlsx("Students Data HW/Data/Course.xlsx")




# joining the data
df <- left_join(student_data, registration_data, by = c('Student ID'))
df <- left_join(df, course_date, by = c('Instance ID'))




# Making the pivot tables
df_pivot_majors <- df %>%
  group_by(Title) %>%
  summarize(count = n())

df_pivot_birth_dates <- df %>%
  group_by(year = lubridate::year(`Birth Date`)) %>%
  summarize(count = n())

df_pivot_payment_plan <- df %>%
  group_by(Title, `Payment Plan`) %>%
  summarize(count = n(), 
            total_cost = sum(`Total Cost`, na.rm = TRUE), 
            total_bal = sum(`Balance Due`, na.rm = TRUE))




# Chart on the number of majors
major_count_plot <- ggplot(df_pivot_majors, aes(x = Title, y = count, fill = Title)) + 
  geom_col() + 
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1)) +
  xlab("Major") + 
  ylab("Count") + 
  ggtitle("Count Per Major") + 
  geom_text(aes(label = count), vjust = -0.5)

major_count_plot
ggsave('major_count_plot.png', height = 5)


# Chart by birth year for students
birth_year_count_plot <- ggplot(df_pivot_birth_dates, aes(x = year, y = count, fill = year)) + 
  geom_col() + 
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1)) +
  xlab("Birth Year") + 
  ylab("Total Cost") + 
  ggtitle("Count Per Birth Year") + 
  geom_text(aes(label = count), vjust = -0.5)

birth_year_count_plot
ggsave('birth_year_count_plot.png', height = 5)



# Total cost per major segmented by payment plan
cost_pre_major_plot <- ggplot(df_pivot_payment_plan, aes(x = Title, y = total_cost, fill = `Payment Plan`)) +
  geom_col() + 
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1)) +
  xlab("Payment Plan") + 
  ylab("Total Cost") + 
  ggtitle("Total Cost Vs. Payment Plan") + 
  geom_text(aes(label = total_cost), vjust = -0.5)

cost_pre_major_plot
ggsave('cost_pre_major_plot.png')



# Total balance due by major segmented by payment plan    
balance_per_major_plot <- ggplot(df_pivot_payment_plan, aes(x = Title, y = total_bal, fill = `Payment Plan`)) +
  geom_col() + 
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1)) +
  xlab("Payment Plan") + 
  ylab("Total Balance")  +
  ggtitle("Total Balance Vs. Payment Plan") + 
  geom_text(aes(label = total_bal), vjust = -0.5)

balance_per_major_plot
ggsave('balance_per_major_plot.png')


