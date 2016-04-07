library(shiny)
library(leaflet)
library(RColorBrewer)


shinyUI(
  fluidPage(
  
    titlePanel("Interactive Weather"),
    sidebarLayout(
      sidebarPanel(
        selectInput("timeSelect", label = h3("Select a duration of time"),
                    choices = list("Yesterday" = "1", "Past 7 days" = "7", "Past 30 days" = "30"),
                    selected = "7"),
        
        radioButtons("plotChoice", "Select a Weather Variable to Display",
                     c("Temperature" = "temp",
                       "Precipitation" = "precip",
                       "Wind Speed" = "wind",
                       "Humidity" = "humid",
                       "Ozone" = "ozone"
                       ))
      ),
    mainPanel(
      leafletOutput("mymap"),
      plotOutput("weatherPlot"),
      textOutput("weatherText")
    )
  )))





