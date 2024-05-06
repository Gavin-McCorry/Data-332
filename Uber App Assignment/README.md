# Uber Assignment 🚗


## About
For my Data-332 class at Augustana College, I was tasked to take given data containing information about Uber rides, combine the data, and create specific analytical graphs.
The variables given and used are listed below in the Data Dictionary section, and an analysis of the data cleaning is below as well. All analytical graphs and pivot tables can 
be found in the shiny app I created, linked in the Shiny App section of this README.

## Author ✍️
Gavin McCorry

## Data Dictionary
- **Date.Time**: The date on time that the data point was collected, in ymd_hms format.
- **Lat**: The latitude of the data collected
- **Lot**: The longitude of the data collected
- **Base**: The base of the data collection center
- **Hour**: A self-made data column, containing the hour from the Date.Time column to make analysis easier
- **Month**: A self-made data column, containing the month of the month from the Date.Time column to make analysis easier
- **Day**: A self-made data column, containing the day of the month from the Date.Time column to make analysis easier
- **Day_of_week**: A self-made data column, containing the day of the week to make analysis easier

## Data Cleaning
The data given only contained the Date.Time variable, which was not asy to work with t creat graphs and make connections. So I created 3 new variables,  
Hour, Month, Day, and Day_of_week using the code below:
```R
df$Hour <- hour(df$Date.Time)
df$Month <- month.abb[month(df$Date.Time)]
df$Day <- day(df$Date.Time)
df$Day_Of_Week <- weekdays(df$Date.Time, abbreviate = TRUE)
```
The rest of the data given was clean and didn't need any cleaning.

## Shiny App
https://gavin-mccorry.shinyapps.io/Uber_App_Assignment/

## Copyright Notice

The content and code snippets in this repository, unless otherwise indicated, are Gavin McCorry's. All rights reserved.

### Restrictions on Use

1. **Use of Code**: You may view and refer to the code for educational and personal use. However, you may not reproduce, distribute, or create derivative works based on this code without explicit permission from the copyright owner.

2. **Use of Shiny App**: The Shiny app deployed in this repository is intended for demonstration purposes only. You may interact with the app through the provided link but may not copy, modify, or redistribute the app without permission.

### Permissions

For inquiries regarding the use of the code or the Shiny app for commercial or other purposes not mentioned above, please contact [gavin.mccorry2025@gmail.com].

### Attribution

If you refer to or use any portion of this repository in your own work, please provide appropriate attribution by linking back to this repository.
