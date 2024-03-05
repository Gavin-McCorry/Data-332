library(tidyverse)
library(readxl)
library(here)
library(skimr) 
library(kableExtra)

# Read in Data
setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332")
lobsters <- read.csv("Lobster Example/Data/Lobster_Abundance_All_Years_20230831.csv")

# Filtering the data
lobsters <- lobsters %>%
  dplyr::filter(SIZE_MM > 0)

# Explore the Data
skimr::skim(lobsters)

# Just grouping the data 
lobsters %>%
  group_by(YEAR) %>%
  summarize(count_by_year = n())

# Not using group_by just gives you a count of the rows
lobsters %>%
  summarize(count =  n())


# Making a pivot table
siteyear_summary <- lobsters %>%
  group_by(SITE, YEAR) %>%
  summarize(count_by_siteyear = n(), 
            mean_size_mm = mean(SIZE_MM, na.rm = TRUE), 
            s_size_mm = sd(SIZE_MM, na.rm = TRUE), 
            median_size_mm = median(SIZE_MM, na.rm = TRUE))


siteyear_summary


# Making a table with the kableExtra package

siteyear_summary %>%
  kable()

# Making a line graph
ggplot(data = siteyear_summary, aes(x = YEAR, y = median_size_mm, color = SITE)) +
  geom_line() 


# Saving the line graph
ggsave(here("lobsteres-line.png"))
