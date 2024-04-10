
library(shiny)

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  
  sliderInput("y", label = "If y is", min = 1, max = 50, value = 30), 
  "then x times y is:", 
  textOutput("product", inline = T) # inline = T makes it so that the computd value is continud on th same line and not on the next line
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    input$x * input$y
  })
}

shinyApp(ui, server)
