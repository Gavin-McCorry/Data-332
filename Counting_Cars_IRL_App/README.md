# IRL Cars Analysis

## About 📰
Radar speed signs track the speed which drivers are going to encourage safe driving practices, such as driving within the speed limit and keeping pedestrians safe. Many statitica; analysis of these signs have shown that drivers decrease their speeds wen radar speds are installed. Our goal in this project was to determine if these claims from the radar companies and other analysis of the technology are true.

For this project we hand collected data about the speed of the cars, in Miles Per Hour, the time of day the car was observed, the weather conditions, temperature, and day of the week. 

## Authors
Gavin McCorry, Gianni Gubbins, Sam Mulugeta

## Data Collection

Describe how the car data was collected and any preprocessing steps performed.

## Code ✍️
The shiny app template was obtained from the shinydashboard library.
```R
library(shinydashboard)
```

All the Code was simple and self-explanatory except for when displaying the times the data was collected on the graphs. With to many individual times, the graph was messy and hard to read. To do this we had to first change the format of the time data so that it could be displayed correctly, and so that R could skip the hours correctly. This was done using the as.POSIXct function.
```R
output$plot_01 <- renderPlot({
    if (input$X == "Time.of.Day") {
      # Convert input$X values to POSIXct datetime objects
      df$Time <- as.POSIXct(df$Time.of.Day, format = "%I:%M %p")
      
      ggplot(df, aes_string(x = df$Time, y = input$Y, colour = input$Splitby)) + 
        geom_point() +
        scale_x_datetime(date_breaks = "1 hour", date_labels = "%I:%M %p")
      
    } else {
      ggplot(df, aes_string(x = input$X, y = input$Y, colour = input$Splitby)) + 
        geom_point() +
        labs(x = input$X, y = input$Y)
    }
  })
```

## Shiny App
All visuals and data can be found on the link below.
https://gavin-mccorry.shinyapps.io/Counting_Cars_IRL_App/

## Conclusion
Based on the 150 cars observed, we can find no initial correlation between the effectiveness of the radar and the speeds of cars. Besides the effectiveness of the radar, time of day, temperature, and weather don't have any correlation either with the speed of cars. More observations are needed to draw further conclusions about the effectiveness of speed radars on drivers speeding. 

## Copyright Notice

The content and code snippets in this repository, unless otherwise indicated, are Gavin McCorry, Gianni Gubbins, and Sam Mulugeta's. All rights reserved.

### Restrictions on Use

1. **Use of Code**: You may view and refer to the code for educational and personal use. However, you may not reproduce, distribute, or create derivative works based on this code without explicit permission from the copyright owner.

2. **Use of Shiny App**: The Shiny app deployed in this repository is intended for demonstration purposes only. You may interact with the app through the provided link but may not copy, modify, or redistribute the app without permission.

### Permissions

For inquiries regarding the use of the code or the Shiny app for commercial or other purposes not mentioned above, please contact [gwmccorry@gmail.com].

### Attribution

If you refer to or use any portion of this repository in your own work, please provide appropriate attribution by linking back to this repository.
