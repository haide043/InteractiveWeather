# server.R  
library(shiny)
library(leaflet)
library(ggmap)
library(DT)
source('helper.R')

shinyServer(function(input, output, session) {  
  output$mymap <- renderLeaflet({
    leaflet()  %>% setView(-93.65, 42.0285, zoom = 4) %>% setMaxBounds(-180, -90, 180, 90) %>% 
      addProviderTiles("MapQuestOpen.OSM", options = providerTileOptions(noWrap = T, minZoom = 3))
  })
  
  weatherValues = reactiveValues(weather = NULL)
  
  
  iconChoice = eventReactive(input$mymap_click,{
    if(weatherValues$weather$currentIcon[1] == "rain"){
      icon = rainIcon
    }
    else if(weatherValues$weather$currentIcon[1] == "partly-cloudy-day"){
      icon = partlyCloudyIcon
    }
    else if(weatherValues$weather$currentIcon[1] == "cloudy"){
      icon = cloudyIcon
    }
    else if(weatherValues$weather$currentIcon[1] == "clear-day"){
      icon = clearIcon
    }
    else if(weatherValues$weather$currentIcon[1] == "fog"){
      icon = fogIcon
    }
    else if(weatherValues$weather$currentIcon[1] == "wind"){
      icon = partlyCloudyIcon
    }
    else if(weatherValues$weather$currentIcon[1] == "clear-night"){
      icon = clearNightIcon
    }
    else if(weatherValues$weather$currentIcon[1] == "snow"){
      icon = snowIcon
    }
    else if(weatherValues$weather$currentIcon[1] == "sleet"){
      icon = sleetIcon
    }
    else if(weatherValues$weather$currentIcon[1] == "partly-cloudy-night"){
      icon = partlyCloudyNightIcon
    }
    else{
      icon = NULL
    }
    return(icon)
  })
  
  observeEvent(input$mymap_click, {
    click = input$mymap_click
    clat <<- click$lat
    clng <<- click$lng
    
    if(input$timeSelect =="past 7"){
      weatherValues$weather = last7Days(clat, clng)
      icon = NULL
    }
    else if(input$timeSelect == "past 30"){
      weatherValues$weather = last30Days(clat, clng)
      icon = NULL
    }
    else if(input$timeSelect == "next 7"){
      weatherValues$weather = next7Days(clat, clng)
      icon = iconChoice()
    }

    leafletProxy("mymap") %>% clearMarkers()
    leafletProxy("mymap") %>% addMarkers(icon = icon, lng = clng, lat = clat)
    })
  
  
  observeEvent(input$findLocation,{
    clat = geocode(input$location)$lat
    validate(need(!is.na(clat), "Sorry, your location could not be found."))
    clng = geocode(input$location)$lon
    
    if(input$timeSelect =="past 7"){
      weatherValues$weather = last7Days(clat, clng)
      icon = NULL
    }
    else if(input$timeSelect == "past 30"){
      weatherValues$weather = last30Days(clat, clng)
      icon = NULL
    }
    else if(input$timeSelect == "next 7"){
      weatherValues$weather = next7Days(clat, clng)
      icon = iconChoice()
    }
    
    leafletProxy("mymap") %>% clearMarkers()
    leafletProxy("mymap") %>% addMarkers(icon = icon, lng = clng, lat = clat)
  })
  
  
  
  observeEvent(input$timeSelect,{
    validate(need(!is.null(clat) ,''))
    if(input$timeSelect =="past 7"){
      weatherValues$weather = last7Days(clat, clng)
      icon = NULL
    }
    else if(input$timeSelect == "past 30"){
      weatherValues$weather = last30Days(clat, clng)
      icon =NULL
    }
    else if(input$timeSelect == "next 7"){
      weatherValues$weather = next7Days(clat,clng)
      icon = iconChoice()
    }
    else{}
  })
  
    
   
  plotType = eventReactive(input$plotChoice, {
    
    validate(
      need(weatherValues$weather, '')
    )    
    weatherData = weatherValues$weather


      output$windPlot = renderPlot({
        validate(
          need("wind" %in% input$plotChoice, 'Select Wind speed as a varaible!')
        )
        weatherData = weatherValues$weather
        
        ggplot(weatherData, aes(weatherDate, group = 2))+
          geom_line(aes(y = weatherWindSpeed, colour = "Wind Speed")) +
          labs(x = "\nDate", y = "Wind Speed\n",title =paste("Wind Speed for the",input$timeSelect,"Days")) +
          TemperatureTheme + scale_color_discrete(name = "Wind Speed")
      })
    
    
      output$humidPlot = renderPlot({
        validate(
          need("humid" %in% input$plotChoice, 'Select humidity as a varaible!')
        )
        weatherData = weatherValues$weather
        
        ggplot(weatherData, aes(weatherDate, group = 2))+
          geom_line(aes(y = weatherHumidity, colour = "Humidity")) +
          labs(x = "\nDate", y = "Humidity\n",title = paste("Humidity for the",input$timeSelect, "Days")) +
          TemperatureTheme + scale_color_discrete(name = "Humidity")
      })
    
    
      output$precipPlot = renderPlot({
        validate(
          need("precip" %in% input$plotChoice, 'Select precipitation as a varaible!')
        )
        weatherData = weatherValues$weather
        
        ggplot(weatherData, aes(weatherDate, group = 2))+
          geom_line(aes(y = weatherPrecip, colour = "Precipitation per Hour")) +
          labs(x = "\nDate", y = "Precipitation\n",title = paste("Precipitation for the",input$timeSelect,"Days")) +
          TemperatureTheme + scale_color_discrete(name = "Precipitation")
      })
    
    
       
      output$temperaturePlot = renderPlot({
        validate(
          need("temp" %in% input$plotChoice, 'Select temperature as a varaible!')
        )   
        weatherData = weatherValues$weather
        
        ggplot(weatherData, aes(weatherDate, group = 2))+
          geom_line(aes(y = weatherTempMax, colour = "Maximum")) +
          geom_line(aes(y = weatherTempMin, colour = "Minimum")) +
          labs(x = "\nDate", y = "Temperature\n",title = paste("Temperature for the",input$timeSelect, "Days")) +
          TemperatureTheme + scale_color_discrete(name = "Temperature")
      })
    
   
    output$ozonePlot = renderPlot({
      validate(
        need("ozone" %in% input$plotChoice, 'Select Ozone Levels as a varaible!')
      )  
      weatherData = weatherValues$weather
      
        ggplot(weatherData, aes(weatherDate, group = 2))+
          geom_line(aes(y = weatherOzone, colour = "Ozone")) +
          labs(x = "\nDate", y = "Ozone\n",title = paste("Ozone levels for the",input$timeSelect,"Days")) +
          TemperatureTheme + scale_color_discrete(name = "Ozone")
      })
    
    
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
  output$iconTable = DT::renderDataTable({
    DT::datatable(iconDataTable, escape = FALSE, style = "bootstrap", 
                  selection = "none",class = "table-condensed", rownames = FALSE,
                  options = list(lengthChange = FALSE, searching = FALSE, autowidth = TRUE,
                                 columnDefs = list(list(width= "100px", targets = c(0,1)))))
  })
  
  
  })














