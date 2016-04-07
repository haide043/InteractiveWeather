library(shiny)
library(leaflet)
library(RColorBrewer)


shinyUI(
  fluidPage(
    fluidRow(
      column(12,
             titlePanel(h1(strong("Interactive Weather"), align = "center")),
             h2("Created by Humza Haider",align = "center"),
             br(),
             h4(strong("Click anywhere on the map to have the historical data displayed or have the weather forcast for out to 7 days.")),
             h4(strong("Check the boxes to display the weather variables you want to see.")),
             h4(strong("Please allow time for the data to load. Enjoy!")),
             br(),
             br(),
             fluidRow(
               column(3, 
                      selectInput("timeSelect", label = h3("Select a duration of time"),
                                  choices = list("Past 7 days" = "past 7", "Past 30 days" = "past 30", "Next 7 days" ="next 7"),
                                  selected = "next 7"),
                      
                      checkboxGroupInput("plotChoice", "Select a Weather Variable to Display",
                                   c("Temperature" = "temp",
                                     "Precipitation" = "precip",
                                     "Wind Speed" = "wind",
                                     "Humidity" = "humid",
                                     "Ozone" = "ozone"
                                   ))
               ),
               column(9,
                      leafletOutput("mymap", height = "600")
               ),
               br(),
               fluidRow(

               column(4,
                      plotOutput("temperaturePlot", width = "100%")
               ),
               column(4,
                      plotOutput("precipPlot", width = "100%")
               ),
               column(4,
                      plotOutput("windPlot", width = "100%")
               ),
               fluidRow(
               column(6,
                      plotOutput("humidPlot", width = "100%")
               ),
               column(6,
                      plotOutput("ozonePlot", width = "100%")
               )
               )

               
               
             )
             )
      )
    )))





