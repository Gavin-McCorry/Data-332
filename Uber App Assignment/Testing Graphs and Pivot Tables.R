library(DT)
library(ggplot2)
library(readxl)

df_testing <- read_rds("Combined_Uber_Data.rds")

# Regular Charts and tables

# Table showing trips by hour
df_trips_by_hour <- df_testing %>% 
  group_by(Hour, Month)%>%
  summarize(count = n())

# Table showing trips by day
df_trips_by_day <- df_testing %>%
  group_by(Day, Month) %>%
  summarize(count = n())

# Table showing trips by bases
df_trips_by_bases <- df_testing %>%
  group_by(Base, Month) %>%
  summarize(count = n())

# Tabl showing trips by hour and day
df_trips_by_hour_day <- df_testing %>%
  group_by(Hour, Day) %>%
  summarize(count = n())

# Table showing trips by weekday and month
df_trips_by_weekday <- df_testing %>%
  group_by(Day_Of_Week, Month) %>%
  summarize(count = n())

# Table showing trips by bases and weekday
df_trips_by_weekday_bases <- df_testing %>%
  group_by(Day_Of_Week, Base) %>%
  summarize(count = n())


# Chart that shows trips by hour and month
ggplot(data = df_trips_by_hour, aes(x = Hour, y = count, fill = factor(Month))) +
  geom_col() +
  facet_wrap(~ Month, scales = "free_x") +
  labs(x = "Hour of the Day", y = "Number of Trips", fill = "Month") +
  scale_x_continuous(breaks = seq(0, 23, by = 2),  # Only show even numbers
                     limits = c(-1, 24)) +
  ggtitle("Trips by Hour and Month")

# Chart that displays trips evry hour
ggplot(data = df_trips_by_hour, aes(x = Hour, y = count)) + 
  geom_col(fill = "red") + 
  labs(x = "Hour of the Day", y = "Number of Trips") +
  ggtitle("Number of Trips Every Hour") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))


# Chart displayig trips taken during every day of the month
ggplot(data = df_trips_by_day, aes(x = Day, y = count)) + 
  geom_col(fill = "red") + 
  labs(x = "Day of The Month", y = "Number of Trips") +
  ggtitle("Number of Trips Every Day")


# Chart displaying trips taken during every day  of the month, by month
ggplot(data = df_trips_by_day, aes(x = Day, y = count, fill = factor(Month))) +
  geom_col() +
  facet_wrap(~ Month, scales = "free_x") +
  labs(x = "Day of The Month", y = "Number of Trips", fill = "Month") +
  scale_x_continuous(breaks = seq(0, 31, by = 2),  # Only show even numbers
                     limits = c(-1, 32)) +
  ggtitle("Trips by Day and Month")


# Chart displaying trips taken by base, by month
ggplot(data = df_trips_by_bases, aes(x = Base, y = count, fill = factor(Month))) +
  geom_col() +
  facet_wrap(~ Month, scales = "free_x") +
  labs(x = "Base", y = "Number of Trips", fill = "Month") +
  ggtitle("Trips by Day and Month") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))


# Chart displaying trips taken by week day, by month
ggplot(data = df_trips_by_weekday, aes(x = factor(Day_Of_Week, levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")), y = count, fill = factor(Month))) +
  geom_col() +
  facet_wrap(~ Month, scales = "free_x") +
  labs(x = "Base", y = "Number of Trips", fill = "Month") +
  ggtitle("Trips by Weekday and Month")


# Chart displaying total trips taken by week day
ggplot(data = df_trips_by_weekday, aes(x = factor(Day_Of_Week, levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")), y = count)) +
  geom_col(fill = "red") +
  labs(x = "Base", y = "Number of Trips") +
  ggtitle("Trips by Day and Month") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

# Chart displaying trips by month
ggplot(data = df_trips_by_day, aes(x = factor(Month, levels = c("Apr", "May", "Jun", "Jul", "Aug", "Sep")), y = count)) +
  geom_col(fill = "red") +
  labs(x = "Month", y = "Number of Trips") +
  ggtitle("Trips by Month") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

# Heat Maps

# Heat map that displays by hour and day
ggplot(df_trips_by_hour_day, aes(x = Hour, y = Day)) + 
  geom_tile(aes(fill = count)) + 
  scale_fill_gradient(low = "white", high = "red") +
  labs(x = "Hour of The Day", y = "Day of The Month", fill = "Number of Trips") +
  theme_minimal()

# Heat map by month and day
ggplot(df_trips_by_day, aes(x = Month, y = Day)) + 
  geom_tile(aes(fill = count)) + 
  scale_fill_gradient(low = "white", high = "red") +
  labs(x = "Month", y = "Day of The Month", fill = "Number of Trips") +
  theme_minimal()
  
# Heat map by month and weekday
ggplot(df_trips_by_weekday, aes(x = Month, y = Day_Of_Week)) + 
  geom_tile(aes(fill = count)) + 
  scale_fill_gradient(low = "white", high = "red") +
  labs(x = "Month", y = "Day of The Week", fill = "Number of Trips") +
  theme_minimal()

# Heat map Bases and Day of Week
ggplot(df_trips_by_weekday_bases, aes(x = Base, y = Day_Of_Week)) + 
  geom_tile(aes(fill = count)) + 
  scale_fill_gradient(low = "white", high = "red") +
  labs(x = "Base", y = "Day of The Week", fill = "Number of Trips") +
  theme_minimal()
