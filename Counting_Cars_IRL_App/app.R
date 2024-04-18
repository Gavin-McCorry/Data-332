library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(readxl)


df <- read.csv("IRL_Car_Data.csv")
df <- df[1: (length(df) - 1)]

column_names <- colnames(df)

ui <- dashboardPage(
  dashboardHeader(title = "Counting Cars IRL"), 
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")), 
      menuItem("Data Set", tabName = "data", icon = icon("database")), 
      menuItem("Analysis", tabName = "analysis", icon = icon("signal")) 
    )
  ), 
  
  dashboardBody(
    tabItems(
      # Dashboard Items
      tabItem(tabName = "dashboard",
        fluidRow(
          column(width = 4, 
            box(title = "About", status = "primary", solidHeader = TRUE, width = NULL,
                HTML('<div style="font-size: 20px;">
                Radar speed signs track the speed that drivers are going to encourage safe 
                driving practices, such as driving within the speed limit and keeping pedestrians safe. 
                Many statitica; analysis of these signs have shown that drivers decrease their speeds wen
                radar speds are installed. Our goal in this project was to determine if these claims from the radar 
                companies and other analysis of the technology are true.
                </div>'), 
                br(),
                br(),
                HTML('<div style="font-size: 20px;">
                For this project we hand collected data about the speed of the cars, in Miles Per Hour, the time 
                of day the car was observed, the weather conditions, temperature, and day of the week.
                </div>'), 
                br(), 
                br(),
                HTML('<div style="font-size: 20px;">
                The data collected can be observed in the “Data Set” page, and an analysis of the data can be lookd 
                at on the “Analysis” page.
                </div>'), 
              
            ) 
          ),
          column(width = 4, 
            valueBoxOutput("num_data_points", width = NULL),
            valueBoxOutput("num_variables", width = NULL), 
            valueBoxOutput("max_mph", width = NULL), 
            valueBoxOutput("min_mph", width = NULL), 
            valueBoxOutput("mean_mph", width = NULL), 
            valueBoxOutput("median_mph", width = NULL)
    
          ),
          column(width = 4, 
             box(title = "Authors", status = "primary", width = NULL, solidHeader = TRUE, 
                 HTML('<div style="font-size: 20px;">Gavin McCorry</div>'), 
                 br(),
                 HTML('<div style="font-size: 20px;">Gianni Gubbins</div>'), 
                 br(),
                 HTML('<div style="font-size: 20px;">Sam Mulugeta</div>')
            )
          )
        )
      ),
      
      # Data Set Items
      tabItem(tabName = "data",
        titlePanel(title = "Explore IRL Cars Data Set"),
        DT::dataTableOutput("table")
      ),
      
      tabItem(tabName = "analysis", 
        fluidRow(
          column(3, 
            selectInput('X', 'Choose X', column_names, selected = column_names[2]), 
            selectInput('Y', 'Choose Y', column_names, selected =   column_names[1]), 
            selectInput('Splitby', 'Split By', column_names, column_names[2])
          ),
          column(6,
            box(plotOutput('plot_01'), width = NULL), 
            box(plotOutput('plot_02'), width = NULL)
            )
          )
        )
      ),
        
      tags$head(
        tags$style(
          HTML(
            ".selectize-control { width: 100% !important; }"
        )
      )
    )
  )
)

server <- function(input, output) {
  output$num_data_points <- renderValueBox({
    valueBox(nrow(df), "Number of Observations", icon = icon("eye"), color = "light-blue")
  })
  
  output$num_variables <- renderValueBox({
    valueBox(ncol(df), "Number of Variables", icon = icon("list"), color = "light-blue")
  })
  
  output$max_mph <- renderValueBox({
    valueBox(max(df$MPH), "Max MPH", icon = icon("maximize"), color = "light-blue")
  })
  
  output$min_mph <- renderValueBox({
    valueBox(min(df$MPH), "Min MPH", icon = icon("minimize"), color = "light-blue")
  })
  
  output$mean_mph <- renderValueBox({
    valueBox(mean(df$MPH), "Mean MPH", icon = icon("percent"), color = "light-blue")
  })
  
  output$median_mph <- renderValueBox({
    valueBox(median(df$MPH), "Median MPH", icon = icon("plus"), color = "light-blue")
  })
  
  # For Table displaying data set
  output$table <- DT::renderDataTable(df, options = list(pagelength = 4))
  
  # Displaying chart in analysis
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
  
  output$plot_02 <- renderPlot({
    ggplot(df, aes_string(x = input$X)) + 
      geom_bar()
  })
  
}

shinyApp(ui, server)