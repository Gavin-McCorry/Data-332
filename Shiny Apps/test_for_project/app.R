library(shiny)

# Makes Mock Data Set
# Set seed for reproducibility
set.seed(123)

# Generate 50 observations of mock data
n <- 50  # Number of observations

# Create a data frame with mock data
mock_data <- data.frame(
  MPH = round(runif(n, min = 40, max = 80), 1),  # Random MPH between 40 and 80
  TimeOfDay = sample(c("Morning", "Afternoon", "Evening", "Night"), n, replace = TRUE),  # Random time of day
  Temperature = round(rnorm(n, mean = 70, sd = 10), 1),  # Random temperature around 70°F with SD of 10
  Weather = sample(c("Sunny", "Cloudy", "Rainy", "Snowy"), n, replace = TRUE)  # Random weather conditions
)

# Moch_data for now, in future car_data.csv
# df <- read.csv(car_data.csv)
df <- mock_data

# UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Counting Cars IRL"),

    # Displaying Table
    tableOutput("table")
    
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  #Displaying Table of Data
  output$table <- renderTable({
    df
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
