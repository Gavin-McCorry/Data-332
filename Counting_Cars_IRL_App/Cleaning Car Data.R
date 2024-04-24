library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(plyr)
library(chron)
library(stringdist)


setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332/Counting_Cars_IRL_App")


df_1 <- read.csv("Car Data Excel.csv")
df_2 <- read.csv("CarData.csv")
df_3 <- read.csv("Car.csv")
df_4 <- read.csv("counting_cars.csv")
df_5 <- read.csv("IRL_Car_Data.csv")
df_6 <- read.csv("MergedCarData.csv")
df_7 <- read.csv("Speed analyst 332 Car Data.csv")
df_8 <- read.csv("UpdatedCarTracking.csv")

# Cleaning each df

#df 1, No name column
df_1["Collector.Name"] <- NA 
names(df_1)[names(df_1) == "Color"] <- "Vehicle.Color"
names(df_1)[names(df_1) == "License.plate.state"] <- "State"
names(df_1)[names(df_1) == "Speed"] <- "MPH"



#df 2
names(df_2)[names(df_2) == "Speed"] <- "MPH"
names(df_2)[names(df_2) == "Color"] <- "Vehicle.Color"
names(df_2)[names(df_2) == "Name"] <- "Collector.Name"
names(df_2)[names(df_2) == "License.plate.state"] <- "State"


#df 3
df_3[11] <- NULL
names(df_3)[names(df_3) == "Speed.MPH"] <- "MPH"
df_3["Date"] <- NA
names(df_3)[names(df_3) == "Day"] <- "Week.Day"


#df 4
df_4[5] <- NULL
names(df_4)[names(df_4) == "Temp"] <- "Temperature"

#df 5
names(df_5)[names(df_5) == "Collector"] <- "Collector.Name"
names(df_5)[names(df_5) == "Time.of.Day"] <- "Time"
names(df_5)[names(df_5) == "Wheater"] <- "Weather"


#df 6
names(df_6)[names(df_6) == "Speed"] <- "MPH"
names(df_6)[names(df_6) == "Orange.Light"] <- "Flashing.Light"
names(df_6)[names(df_6) == "Name"] <- "Collector.Name"

#df 7
names(df_7)[names(df_7) == "Student"] <- "Collector.Name"
names(df_7)[names(df_7) == "Time.of.Day"] <- "Time"
names(df_7)[names(df_7) == "Type.of.se"] <- "Vehicle.Type"
names(df_7)[names(df_7) == "Orange.Light"] <- "Flashing.Light"

#df 8
df_8[1] <- NULL
names(df_8)[names(df_8) == "Time.of.Day"] <- "Time"
names(df_8)[names(df_8) == "Type.of.Car"] <- "Vehicle.Type"
names(df_8)[names(df_8) == "Speed..mph."] <- "MPH"
names(df_8)[names(df_8) == "Name"] <- "Collector.Name"
names(df_8)[names(df_8) == "Weather"] <- "Temperature"

# Fix times that dont have Am or PM
convert_time_format <- function(time_str) {
  # Check if the time_str includes AM or PM
  if (grepl("[AP]M$", time_str, ignore.case = TRUE)) {
    # Extract hour and minute from time string with AM/PM
    time_components <- unlist(strsplit(time_str, ":|\\s+"))
    hour <- as.integer(time_components[1])
    minute <- as.integer(time_components[2])
    am_pm <- time_components[3]
    
    # Determine the cutoff hour based on AM/PM
    if (am_pm == "AM" && hour >= 9) {
      formatted_time <- sprintf("%d:%02d PM", hour, minute)
    } else if (am_pm == "PM" && hour < 9) {
      formatted_time <- sprintf("%d:%02d AM", hour, minute)
    } else {
      formatted_time <- time_str
    }
  } else {
    # Convert time without AM/PM to the desired format
    time_components <- unlist(strsplit(time_str, ":"))
    hour <- as.integer(time_components[1])
    minute <- as.integer(time_components[2])
    
    # Define cutoff hour
    cutoff_hour <- 9
    
    # Determine whether to convert to AM or PM
    if (hour < cutoff_hour) {
      # Convert to PM if hour is before the cutoff
      formatted_time <- sprintf("%d:%02d PM", hour, minute)
    } else {
      # Convert to AM if hour is after the cutoff
      formatted_time <- sprintf("%d:%02d AM", hour, minute)
    }
  }
  
  return(formatted_time)
}

# Apply add_am_pm_indicator function to the Time column in df_6
df_6$Time <- sapply(df_6$Time, convert_time_format)
df_7$Time <- sapply(df_7$Time, convert_time_format)

# Merging all data frames into one
df_full_car_data <- rbind.fill(df_1, df_2, df_3, df_4, df_5, df_6, df_7, df_8)

# Making Data the same
df_full_car_data$Weather <- tolower(df_full_car_data$Weather)
df_full_car_data$Weather <- trimws(df_full_car_data$Weather)

df_full_car_data$Vehicle.Color <- tolower(df_full_car_data$Vehicle.Color)
df_full_car_data$Vehicle.Color <- trimws(df_full_car_data$Vehicle.Color)

# Making all car color spelings the same
correct_color <- function(x) {
  ifelse(stringdist(tolower(x), "grey", method = "lv") <= 2, "gray", x)
}

df_full_car_data$Vehicle.Color <- sapply(df_full_car_data$Vehicle.Color, correct_color)

# Saving new df
saveRDS(df_full_car_data, file = "Combined_Car_Data.rds")
