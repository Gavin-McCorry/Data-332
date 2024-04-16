# IRL Cars Analysis

## About 📰

This project analyzes real-world car data to extract insights and visualize key statistics using R and Shiny.

## Data Collection :

Describe how the car data was collected and any preprocessing steps performed.

## Code ✍️

```R
dashboardBody(
  tabItems(
    # Dashboard Items
    tabItem(tabName = "dashboard",
      fluidRow(
        column(width = 4, 
          box(title = "About", status = "primary", solidHeader = TRUE, width = NULL,"This is where the paragraph will go") 
        ),
        column(width = 4, 
          valueBoxOutput("num_data_points", width = NULL),
          valueBoxOutput("num_variables", width = NULL), 
          valueBoxOutput("max_mph", width = NULL), 
          valueBoxOutput("min_mph", width = NULL), 
          valueBoxOutput("mean_mph", width = NULL), 
          valueBoxOutput("mode_mph", width = NULL)
        ),
        column(width = 4, 
           box(title = "Authors", status = "primary", width = NULL, solidHeader = TRUE, 
               "Gavin McCorry", 
               br(),
               "Gianni Gubbins", 
               br(),
               "Sam Mulugeta")
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
          selectInput('X', 'Choose X', column_names, column_names[1]), 
          selectInput('Y', 'Choose Y', column_names, column_names[3]), 
          selectInput('Splitby', 'Split By', column_names, column_names[3])
        ),
        column(10,
          box(plotOutput('plot_01')), 
          box(plotOutput('plot_02'))
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
```

```R
server <- function(input, output) {
  output$num_data_points <- renderValueBox({
    valueBox(nrow(mock_data), "Number of Observations", icon = icon("eye"), color = "light-blue")
  })
  
  output$num_variables <- renderValueBox({
    valueBox(ncol(mock_data), "Number of Variables", icon = icon("list"), color = "light-blue")
  })
  
  output$max_mph <- renderValueBox({
    valueBox(max(mock_data$MPH), "Max MPH", icon = icon("maximize"), color = "light-blue")
  })
  
  output$min_mph <- renderValueBox({
    valueBox(min(mock_data$MPH), "Min MPH", icon = icon("minimize"), color = "light-blue")
  })
  
  output$mean_mph <- renderValueBox({
    valueBox(mean(mock_data$MPH), "Mean MPH", icon = icon("percent"), color = "light-blue")
  })
  
  output$mode_mph <- renderValueBox({
    valueBox(mode(mock_data$MPH), "Mode MPH", icon = icon("plus"), color = "light-blue")
  })
  
  # For Table displaying data set
  output$table <- DT::renderDataTable(mock_data, options = list(pagelength = 4))
  
  # Displaying chart in analysis
  output$plot_01 <- renderPlot({
    ggplot(mock_data, aes_string(x = input$X, y = input$Y, colour = input$Splitby)) + 
      geom_point()
  })
  
  output$plot_02 <- renderPlot({
    ggplot(mock_data, aes_string(x = input$X, colour = input$Splitby)) + 
      geom_bar()
  })
}
```

## Shiny App
