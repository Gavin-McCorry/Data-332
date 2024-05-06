library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(readxl)
library(dplyr)

df <- readRDS("Combined_Uber_Data.rds")


ui <- dashboardPage(
  dashboardHeader(title = "Uber Data Analysis", titleWidth = 300),
  
  dashboardSidebar(
    width = 300,

     sidebarMenu(     
       menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")), 
       menuItem("Data Set", tabName = "data", icon = icon("database"),
                menuSubItem("Trips By Hour Pivot Table", tabName = "trips_by_hour_pivot"), 
                menuSubItem("Trips By Day Pivot Table", tabName = "trips_by_day_pivot"), 
                menuSubItem("Trips By Bases Pivot Table", tabName = "trips_by_bases_pivot"), 
                menuSubItem("Trips By Hour and Day Pivot Table", tabName = "trips_by_hour_day_pivot"), 
                menuSubItem("Trips By Weekday Pivot Table", tabName = "trips_by_weekday_pivot"), 
                menuSubItem("Trips By Weekday and Bases Pivot Table", tabName = "trips_by_weekday_bases_pivot") 
                
       ), 
       menuItem("Graphs", tabName = "analysis", icon = icon("signal"), 
                menuSubItem("Trips Taken Every Hour", tabName = "trips_hour"), 
                menuSubItem("Trips By Hour and Month", tabName = "trips_hour_month"), 
                menuSubItem("Trips Taken By Days of the Month", tabName = "trips_by_day"), 
                menuSubItem("Trips Taken By Days of Month, By Month", tabName = "trips_by_day_month"), 
                menuSubItem("Trips Taken By Base by Month", tabName = "trips_base_month"),
                menuSubItem("Trips Taken by Weekday", tabName = "trips_weekday"), 
                menuSubItem("Trips Taken By Weekday, By Month", tabName = "trips_weekday_by_month"), 
                menuSubItem("Trips Taken by Month", tabName = "trips_month"), 
                
                # Heat Maps
                menuSubItem("Heat Map, Hour Vs. Day", tabName = "heat_hour_day"), 
                menuSubItem("Heat Map, Month Vs. Day", tabName = "heat_month_day"), 
                menuSubItem("Heat Map, Month Vs. Weekday", tabName = "heat_month_weekday"), 
                menuSubItem("Heat Map, Base Vs. Weekday", tabName = "heat_base_weekday")
      ) 
     )
    ),
  
  dashboardBody(
    tabItems(
      # Dashboard Items
      tabItem(tabName = "dashboard", 
              fluidRow(
                box(title = "About", status = "primary",solidHeader = TRUE, 
                    HTML('<div style="font-size: 20px;">
                    Using data provided to me by my Data-332 professor about uber rides taken in differnt months, days and time of day, I created some graphs to help analyze this data. 
                    The data was given to me in 6 different data sets that I combined in R. to make the data easier to work with I then created 6 pivot tables to then cretae graphs from. These
                    pivot tables can be viewed under the Data Set tab in the sidebar. All graphs created for analytical purposes can be viewed
                    under the Graphs tab in sidebar
                    </div>')), 
                box(title = "Author", status = "primary", solidHeader = TRUE, width = 2,
                    HTML('<div style="font-size: 20px;">
                    Gavin McCorry
                    </div>')
                    )
              )
          
      ),
      tabItem(tabName = "trips_by_hour_pivot", 
              titlePanel(title = "Trips by Hour and Month"), 
              DT::dataTableOutput("trips_by_hour_table")
      ),
      tabItem(tabName = "trips_by_day_pivot",
              titlePanel(title = "Trips by Day of Month"),
              DT::dataTableOutput("df_trips_by_day_table")
      ),
      tabItem(tabName = "trips_by_bases_pivot", 
              titlePanel(title = "Trips by Bases and Month"), 
              DT::dataTableOutput("df_trips_by_bases_table"),
      ),
      tabItem(tabName = "trips_by_hour_day_pivot", 
              titlePanel(title = "Trips by Hour and Day"),
              DT::dataTableOutput("df_trips_by_hour_day_table"),
      ),
      tabItem(tabName = "trips_by_weekday_pivot", 
              titlePanel(title = "Trips by Weekday and Month"), 
              DT::dataTableOutput("df_trips_by_weekday_table"), 
      ),
      tabItem(tabName = "trips_by_weekday_bases_pivot", 
              titlePanel(title = "Trips by Weekday and Base"), 
              DT::dataTableOutput("df_trips_by_weekday_bases_table")
      ),
      tabItem(tabName = "trips_hour", 
              fluidRow(
                column(width = 8,
                       plotOutput("trips_hour_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the number of trips taken per hour of the day. 
                            Using this chart you can see how trips taken change by hour of the day.
                           </div>'))
                )    
              )
      ),
      
      tabItem(tabName = "trips_hour_month", 
              fluidRow(
                column(width = 8,
                       plotOutput("trips_hour_month_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                       HTML('<div style="font-size: 20px;">This chart shows the number of trips taken per hour of the day, seperated by month. 
                           Using this chart you can see how trips taken change not only by hour of the day but also by time of year.
                           </div>'))
                )    
              )
      ), 
      tabItem(tabName = "trips_by_day", 
              fluidRow(
                column(width = 8,
                       plotOutput("trips_by_day_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the number of trips taken per day of the month. 
                           Using this chart you can see how trips taken change as the time of the month changes.
                           </div>'))
                )    
              )
      ), 
      tabItem(tabName = "trips_by_day_month", 
              fluidRow(
                column(width = 8,
                       plotOutput("trips_by_day_month_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the number of trips taken per day of the month, split by month. Using 
                           this chart you can see how trips taken change as the time of the month and the month change.
                           </div>'))
                )    
              )
      ),
      tabItem(tabName = "trips_base_month", 
              fluidRow(
                column(width = 8,
                       plotOutput("trips_base_month_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the number of trips taken per base, split by month. Using 
                           this chart you can see how trips taken change based of off the base and of off the month.
                           </div>'))
                )    
              )
      ), 
      tabItem(tabName = "trips_weekday", 
              fluidRow(
                column(width = 8,
                       plotOutput("trips_weekday_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the number of trips taken per wekday. Using 
                           this chart you can see how trips taken change based of off the weekday.
                           </div>'))
                )    
              )
      ), 
      tabItem(tabName = "trips_weekday_by_month", 
              fluidRow(
                column(width = 8,
                       plotOutput("trips_weekday_by_month_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the number of trips taken per wekday, split by month. Using 
                           this chart you can see how trips taken change based of off the weekday and of off the month.
                           </div>'))
                )    
              )
      ),
      tabItem(tabName = "trips_month", 
              fluidRow(
                column(width = 8,
                       plotOutput("trips_month_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the number of trips taken per month. Using 
                           this chart you can see how trips taken change based of off the month.
                           </div>'))
                )    
              )
      ), 
      tabItem(tabName = "heat_hour_day", 
              fluidRow(
                column(width = 8,
                       plotOutput("heat_hour_day_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the relationship between Hour of the day and the day of the month.
                           </div>'))
                )    
              )
      ), 
      tabItem(tabName = "heat_month_day", 
              fluidRow(
                column(width = 8,
                       plotOutput("heat_month_day_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the relationship between the month and the day of the month.
                           </div>'))
                )    
              )
      ), 
      tabItem(tabName = "heat_month_weekday", 
              fluidRow(
                column(width = 8,
                       plotOutput("heat_month_weekday_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the relationship between the month and the day of the week.
                           </div>'))
                )    
              )
      ), 
      tabItem(tabName = "heat_base_weekday", 
              fluidRow(
                column(width = 8,
                       plotOutput("heat_base_weekday_chart", height = "800px", width = "100%")
                ),
                column(width = 4,
                       box(title = "About Graph", solidHeader = TRUE, status = "primary", width ="85%",
                           HTML('<div style="font-size: 20px;">This chart shows the relationship between the base and the day of the week.
                           </div>'))
                )    
              )
      )
    )
  )
)

server <- function(input, output) {
  # Pivot Tables
  df_trips_by_hour <- df %>% 
    group_by(Hour, Month)%>%
    summarize(count = n())
  
  # Table showing trips by day
  df_trips_by_day <- df %>%
    group_by(Day, Month) %>%
    summarize(count = n())
  
  # Table showing trips by bases
  df_trips_by_bases <- df %>%
    group_by(Base, Month) %>%
    summarize(count = n())
  
  # Tabl showing trips by hour and day
  df_trips_by_hour_day <- df %>%
    group_by(Hour, Day) %>%
    summarize(count = n())
  
  # Table showing trips by weekday and month
  df_trips_by_weekday <- df %>%
    group_by(Day_Of_Week, Month) %>%
    summarize(count = n())
  
  # Table showing trips by bases and weekday
  df_trips_by_weekday_bases <- df %>%
    group_by(Day_Of_Week, Base) %>%
    summarize(count = n())
  
  output$trips_by_hour_table <- DT::renderDataTable(df_trips_by_hour)
  output$df_trips_by_day_table <- DT::renderDataTable(df_trips_by_day)
  output$df_trips_by_bases_table <- DT::renderDataTable(df_trips_by_bases)
  output$df_trips_by_hour_day_table <- DT::renderDataTable(df_trips_by_hour_day)
  output$df_trips_by_weekday_table <- DT::renderDataTable(df_trips_by_weekday)
  output$df_trips_by_weekday_bases_table <- DT::renderDataTable(df_trips_by_weekday_bases)
  
  
  output$trips_hour_month_chart <- renderPlot({
    ggplot(data = df_trips_by_hour, aes(x = Hour, y = count, fill = factor(Month))) +
      geom_col() +
      facet_wrap(~ Month, scales = "free_x") +
      labs(x = "Hour of the Day", y = "Number of Trips", fill = "Month") +
      scale_x_continuous(breaks = seq(0, 23, by = 2),  # Only show even numbers
                         limits = c(-1, 24)) +
      ggtitle("Trips by Hour and Month") +
      theme(plot.margin = margin(1, 1, 1, 1, "cm"))
    })
  
  output$trips_hour_chart <- renderPlot({
    ggplot(data = df_trips_by_hour, aes(x = Hour, y = count)) + 
      geom_col(fill = "red") + 
      labs(x = "Hour of the Day", y = "Number of Trips") +
      ggtitle("Number of Trips Every Hour") +
      scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
  })
  
  output$trips_by_day_chart <- renderPlot({
    ggplot(data = df_trips_by_day, aes(x = Day, y = count)) + 
      geom_col(fill = "red") + 
      labs(x = "Day of The Month", y = "Number of Trips") +
      ggtitle("Number of Trips Every Day")
  })
  
  output$trips_by_day_month_chart <- renderPlot({
    ggplot(data = df_trips_by_day, aes(x = Day, y = count, fill = factor(Month))) +
      geom_col() +
      facet_wrap(~ Month, scales = "free_x") +
      labs(x = "Day of The Month", y = "Number of Trips", fill = "Month") +
      scale_x_continuous(breaks = seq(0, 31, by = 2),  # Only show even numbers
                         limits = c(-1, 32)) +
      ggtitle("Trips by Day and Month")
  })
  
  output$trips_base_month_chart <- renderPlot({
    ggplot(data = df_trips_by_bases, aes(x = Base, y = count, fill = factor(Month))) +
      geom_col() +
      facet_wrap(~ Month, scales = "free_x") +
      labs(x = "Base", y = "Number of Trips", fill = "Month") +
      ggtitle("Trips by Day and Month") +
      scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
  })
  
  output$trips_weekday_chart <- renderPlot({
    ggplot(data = df_trips_by_weekday, aes(x = factor(Day_Of_Week, levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")), y = count)) +
      geom_col(fill = "red") +
      labs(x = "Base", y = "Number of Trips") +
      ggtitle("Trips by Day and Month") + 
      scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
  })
  
  output$trips_weekday_by_month_chart <- renderPlot({
    ggplot(data = df_trips_by_weekday, aes(x = factor(Day_Of_Week, levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")), y = count, fill = factor(Month))) +
      geom_col() +
      facet_wrap(~ Month, scales = "free_x") +
      labs(x = "Base", y = "Number of Trips", fill = "Month") +
      ggtitle("Trips by Weekday and Month")
  })
  
  output$trips_month_chart <- renderPlot({
    ggplot(data = df_trips_by_day, aes(x = factor(Month, levels = c("Apr", "May", "Jun", "Jul", "Aug", "Sep")), y = count)) +
      geom_col(fill = "red") +
      labs(x = "Month", y = "Number of Trips") +
      ggtitle("Trips by Month") +
      scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
  })
  
  output$heat_hour_day_chart <- renderPlot({
    ggplot(df_trips_by_hour_day, aes(x = Hour, y = Day)) + 
      geom_tile(aes(fill = count)) + 
      scale_fill_gradient(low = "white", high = "red") +
      labs(x = "Hour of The Day", y = "Day of The Month", fill = "Number of Trips") +
      theme_minimal()
  })
  
  output$heat_month_day_chart <- renderPlot({
    ggplot(df_trips_by_day, aes(x = Month, y = Day)) + 
      geom_tile(aes(fill = count)) + 
      scale_fill_gradient(low = "white", high = "red") +
      labs(x = "Month", y = "Day of The Month", fill = "Number of Trips") +
      theme_minimal()
  })
  
  output$heat_month_weekday_chart <- renderPlot({
    ggplot(df_trips_by_weekday, aes(x = Month, y = Day_Of_Week)) + 
      geom_tile(aes(fill = count)) + 
      scale_fill_gradient(low = "white", high = "red") +
      labs(x = "Month", y = "Day of The Week", fill = "Number of Trips") +
      theme_minimal()
  })
  
  output$heat_base_weekday_chart <- renderPlot({
    ggplot(df_trips_by_weekday_bases, aes(x = Base, y = Day_Of_Week)) + 
      geom_tile(aes(fill = count)) + 
      scale_fill_gradient(low = "white", high = "red") +
      labs(x = "Base", y = "Day of The Week", fill = "Number of Trips") +
      theme_minimal()
  })
  
}

shinyApp(ui, server)
