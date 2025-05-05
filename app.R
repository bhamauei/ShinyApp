setwd("C:/Users/britt/OneDrive/Documents/ADA/ShinyExtraCredit")
getwd()

library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("MPG Explorer"),
  sidebarLayout(
    sidebarPanel(
      selectInput("predictor", "Choose a predictor:", 
                  choices = names(mtcars)[-1])
    ),
    mainPanel(
      plotOutput("regPlot")
    )
  )
)

server <- function(input, output) {
  output$regPlot <- renderPlot({
    predictor <- input$predictor
    ggplot(mtcars, aes_string(x = predictor, y = "mpg")) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE) +
      labs(title = paste("MPG vs", predictor),
           x = predictor,
           y = "Miles per Gallon")
  })
}

shinyApp(ui = ui, server = server)

