
### An app that greats the user by name
## The app gets the input from the user and stores it in "name"
## then outputs the greeting "Hello name" on the next line
# library(shiny)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function(input, output, session){
  output$greeting <- renderText({
    paste0("Hello ", input$name)
  })

}

shinyApp(ui, server)
