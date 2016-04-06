# server.R  
library(shiny)

shinyServer(function(input, output, session) {  
  
  library(shiny)
  shinyServer(function(input, output) {
    output$distPlot <- renderPlot({
      dist <- rnorm(input$obs)
      hist(dist)
    })
  })
  })