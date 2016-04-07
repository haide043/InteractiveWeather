# server.R  
library(shiny)
library(leaflet)
library(ggmap)
source('helper.R')

clat = NULL
clng = NULL

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
    clat <<- click$lat
    clng <<- click$lng
    
    if(input$timeSelect =="7"){
      weatherValues$weather = last7Days(clat, clng)
    }
    else if(input$timeSelect == "30"){
      weatherValues$weather = last30Days(clat, clng)
    }
  
    leafletProxy("mymap") %>% clearMarkers()
    leafletProxy("mymap") %>% addMarkers(lng = clng, lat = clat)
    })
  
  observeEvent(input$timeSelect,{
    if(!is.null(clat)){
      if(input$timeSelect =="7"){
        weatherValues$weather = last7Days(clat, clng)
      }
      else if(input$timeSelect == "30"){
        weatherValues$weather = last30Days(clat, clng)
      }
    }
    else{}
  })
  
  weatherValues = reactiveValues(weather = NULL)
    
   
  plotType = eventReactive(input$plotChoice, {
    print(input$plotChoice)
    if("wind" %in% input$plotChoice){
      output$windPlot = renderPlot({
        if(!is.null(weatherValues$weather)){
          weatherData = weatherValues$weather
          ggplot(weatherData, aes(weatherDate, group = 2))+
            geom_line(aes(y = weatherWindSpeed, colour = "Wind Speed")) +
            labs(x = "\nDate", y = "Wind Speed\n",title =paste("Wind Speed for the Last",input$timeSelect,"Days")) +
            TemperatureTheme + scale_color_discrete(name = "Wind Speed")
        }
      })
    }
    if("humid" %in% input$plotChoice){
      output$humidPlot = renderPlot({
        if(!is.null(weatherValues$weather)){
          weatherData = weatherValues$weather
          ggplot(weatherData, aes(weatherDate, group = 2))+
            geom_line(aes(y = weatherHumidity, colour = "Humidity")) +
            labs(x = "\nDate", y = "Humidity\n",title = "Humidity for the Last 7 Days") +
            TemperatureTheme + scale_color_discrete(name = "Humidity")
        }
      })
    }
    if("precip" %in% input$plotChoice){
      output$precipPlot = renderPlot({
        if(!is.null(weatherValues$weather)){
          weatherData = weatherValues$weather
          ggplot(weatherData, aes(weatherDate, group = 2))+
            geom_line(aes(y = weatherPrecip, colour = "Precipitation per Hour")) +
            labs(x = "\nDate", y = "Precipitation\n",title = "Precipitation for the Last 7 Days") +
            TemperatureTheme + scale_color_discrete(name = "Precipitation")
        }
      })
    }
    if("temp" %in% input$plotChoice){
      output$temperaturePlot = renderPlot({
        if(!is.null(weatherValues$weather)){
          weatherData = weatherValues$weather
          ggplot(weatherData, aes(weatherDate, group = 2))+
            geom_line(aes(y = weatherTempMax, colour = "Maximum")) +
            geom_line(aes(y = weatherTempMin, colour = "Minimum")) +
            labs(x = "\nDate", y = "Temperature\n",title = "Temperature for the Last 7 Days") +
            TemperatureTheme + scale_color_discrete(name = "Temperature")
        }
      })
    }

    if("ozone" %in% input$plotChoice){
      output$ozonePlot = renderPlot({
        if(!is.null(weatherValues$weather)){
          weatherData = weatherValues$weather
          ggplot(weatherData, aes(weatherDate, group = 2))+
            geom_line(aes(y = weatherOzone, colour = "Ozone")) +
            labs(x = "\nDate", y = "Ozone\n",title = "Ozone levels for the Last 7 Days") +
            TemperatureTheme + scale_color_discrete(name = "Ozone")
        }
      })
    }
  })
  
  output$temperaturePlot = renderPlot({
    plotType()
  })
  output$precipPlot = renderPlot({
    plotType()
  })
  output$humidPlot = renderPlot({
    plotType()
  })
  output$windPlot = renderPlot({
    plotType()
  })
  output$ozonePlot = renderPlot({
    plotType()
  })
  
  
  })














