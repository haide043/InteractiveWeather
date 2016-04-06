library(shiny)
library(leaflet)
library(RColorBrewer)


shinyUI(bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("mymap", width = "90%", height = "70%"),
  plotOutput("temperaturePlot")
  )
)




          
