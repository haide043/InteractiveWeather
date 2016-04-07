# server.R  
library(shiny)
library(leaflet)
library(ggmap)
source('helper.R')

TemperatureTheme <- theme_grey() + theme(plot.title = element_text(family = "Times", face = "bold", colour = "Black", size = rel(2)), 
                                     axis.title = element_text(family = "Times", size= rel(2)))

shinyServer(function(input, output, session) {  
  output$mymap <- renderLeaflet({
    leaflet()  %>% setView(-93.65, 42.0285, zoom = 4) %>% setMaxBounds(-180, -90, 180, 90) %>% 
      addProviderTiles("MapQuestOpen.OSM", options = providerTileOptions(noWrap = T, minZoom = 3)
      )
  })
  
  observeEvent(input$mymap_click, {
    click = input$mymap_click
    clat <- click$lat
    clng <- click$lng
    
    if(input$timeSelect =="7"){
      weatherValues$weather = last7Days(clat, clng)
    }
    else if(input$timeSelect == "30"){
      weatherValues$weather = last30Days(clat, clng)
    }
  
    leafletProxy("mymap") %>% clearMarkers()
    leafletProxy("mymap") %>% addMarkers(lng = clng, lat = clat)
    })
  
  weatherValues = reactiveValues(weather = NULL)
    
   
  plotType = eventReactive(input$plotChoice, {
       output$weatherPlot = renderPlot({
          if(!is.null(weatherValues$weather)){
            weatherData = weatherValues$weather
            if(input$plotChoice == "temp"){

              ggplot(weatherData, aes(weatherDate, group = 2))+
                geom_line(aes(y = weatherTempMax, colour = "Maximum")) +
                geom_line(aes(y = weatherTempMin, colour = "Minimum")) +
                labs(x = "\nDate", y = "Temperature\n",title = "Temperature for the Last 7 Days") +
                TemperatureTheme + scale_color_discrete(name = "Temperature")
            }
            else if(input$plotChoice == "precip"){
              ggplot(weatherData, aes(weatherDate, group = 2))+
                geom_line(aes(y = weatherPrecip, colour = "Precipitation per Hour")) +
                labs(x = "\nDate", y = "Precipitation\n",title = "Precipitation for the Last 7 Days") +
                TemperatureTheme + scale_color_discrete(name = "Precipitation")
            }
            else if(input$plotChoice == "humid"){
              ggplot(weatherData, aes(weatherDate, group = 2))+
                geom_line(aes(y = weatherHumidity, colour = "Humidity")) +
                labs(x = "\nDate", y = "Humidity\n",title = "Humidity for the Last 7 Days") +
                TemperatureTheme + scale_color_discrete(name = "Humidity")
            }
            else if(input$plotChoice == "wind"){
              ggplot(weatherData, aes(weatherDate, group = 2))+
                geom_line(aes(y = weatherWindSpeed, colour = "Wind Speed")) +
                labs(x = "\nDate", y = "Wind Speed\n",title = "Wind Speed for the Last 7 Days") +
                TemperatureTheme + scale_color_discrete(name = "Wind Speed")
            }
            else if(input$plotChoice == "ozone"){
              ggplot(weatherData, aes(weatherDate, group = 2))+
                geom_line(aes(y = weatherPrecip, colour = "Ozone")) +
                labs(x = "\nDate", y = "Ozone\n",title = "Ozone levels for the Last 7 Days") +
                TemperatureTheme + scale_color_discrete(name = "Ozone")
            }
          }
          else{
            return()
          }
          
        })
    })
  
  output$weatherPlot = renderPlot({
    plotType()
  })
  
  
  })

#dat = switch(input$plotChoice,
#             "temp" = cbind.data.frame(max = weatherData$weatherTempMax, min = weatherData$weatherTempMin),
#             "precip" = c(),
#             "sunset" = c(),
#             "sunrise" = c(),
#             "ozone" = c()
#)














