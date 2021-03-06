# server.R  
library(shiny)
library(leaflet)
library(ggmap)
library(reshape2)
library(ggplot2)
library(DT)
library(chron)
library(scales)
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
  
 observeEvent(input$statesTemp,{
   radioSwitch <<- TRUE
   updateRadioButtons(session, "statesTemp2", 
                      choices = list(
                        "Helena, Montana" = "Montana","Lincoln, Nebraska" = "Nebraska",  "Carson City, Nevada" = "Nevada",  "Concord, New Hampshire" = "New Hampshire",
                        "Trenton, New Jersey" = "New Jersey",  "Santa Fe, New Mexico" ="New Mexico",  "Albany, New York" = "New York",  "Raleigh, North Carolina" = "North Carolina",
                        "Bismarck, North Dakota" = "North Dakota",  "Columbus, Ohio" = "Ohio",  "Oklahoma City, Oklahoma" = "Oklahoma",  "Salem, Oregon" = "Oregon",  "Harrisburg, Pennsylvania" = "Pennsylvania",
                        "Providence, Rhode Island" = "Rhode Island",  "Columbia, South Carolina" = "South Carolina",  "Pierre, South Dakota" = "South Dakota",  "Nashville, Tennessee" = "Tennessee",
                        "Austin, Texas" = "Texas",  "Salt Lake City, Utah" = "Utah",  "Montpelier, Vermont" = "Vermont",  "Richmond, Virginia" = "Virgina",  "Olympia, Washington" = "Washington",
                        "Charleston, West Virginia" = "West Virginia",  "Madison, Wisconsin" = "Wisconsin",  "Cheyenne, Wyoming" = "Wyoming"
                      ),
                      selected = character(0))
   }) 
 
 observeEvent(input$statesTemp2,{
   radioSwitch <<- FALSE
   updateRadioButtons(session, "statesTemp", 
                      choices = list(
                        "Montgomery, Alabama" = "Alabama",  "Juneau, Alaska" = "Alaska",  "Phoenix, Arizona" = "Arizona",
                        "Little Rock, Arkansas" = "Arkansas",  "Sacramento, California" = "California",  "Denver, Colorado" = "Colorado",
                        "Hartford, Connecticut" = "Connecticut",  "Dover, Delaware" = "Delaware",  "Tallahassee, Florida" = "Florida", 
                        "Atlanta, Georgia" = "Georgia",  "Honolulu, Hawaii" = "Hawaii",  "Boise, Idaho" = "Idaho",  "Springfield, Illinois" = "Illinois",
                        "Indianapolis, Indiana" = "Indiana",  "Des Moines, Iowa" = "Iowa",  "Topeka, Kansas" = "Kansas",  "Frankfort, Kentucky" = "Kentucky",
                        "Baton Rouge, Louisiana" = "Louisiana",  "Augusta, Maine" = "Maine",  "Annapolis, Maryland" = "Maryland",  "Boston, Massachusetts" = "Massachusetts",
                        "Lansing, Michigan" = "Michigan",  "St. Paul, Minnesota" = "Minnesota",  "Jackson, Mississippi" = "Mississippi",  "Jefferson City, Missouri" = "Missouri"
                      ),
                      selected = character(0))

 }) 
 
 ##################Individual State Temp###################################################
    output$stateTempPlot = renderPlot({
      input$statesTemp #this is forcing the plot to wait until the inputs have been completed.
      input$statesTemp2
      if(radioSwitch){
      name = input$statesTemp
      location = paste("Capitals/",name, ".csv", sep = "")
      }
      else{
        name = input$statesTemp2
        location = paste("Capitals/",name, ".csv", sep = "")
      }
      
      state = stateClean(location)
      
      
      ggplot(data = state, aes(x = Month,y = Temperature, color = TemperatureType, group = TemperatureType)) + 
        geom_point(size = 2) +
        geom_line(size = 1.5) +
        scale_color_manual(values = c("red", "blue")) +
        ggtitle(paste(name, "Yearly Weather")) + 
        ylim(c(0,110)) +
        theme(legend.title=element_blank(), plot.title = element_text(size = 20, face="bold"),axis.text.y=element_text(size=12),axis.title=element_text(size=14,face="bold")) 
    })

##################################################################################################
 
 output$stateHumidPlot = renderPlot({
   input$statesTemp #this is forcing the plot to wait until the inputs have been completed.
   input$statesTemp2
   if(radioSwitch){
     name = input$statesTemp
     location = paste("Capitals/",name, ".csv", sep = "")
   }
   else{
     name = input$statesTemp2
     location = paste("Capitals/",name, ".csv", sep = "")
   }
   
   state = stateHumidClean(location)
   
   
   ggplot(data = state, aes(x = Month,y = Humidity,  group = 1)) + 
     geom_point(size = 2, color = "orange") +
     geom_line(size = 1.5, color = "orange") +
     ggtitle(paste(name, "Yearly Humidity")) + 
     theme(legend.title=element_blank(), plot.title = element_text(size = 20, face="bold"),axis.text.y=element_text(size=12),axis.title=element_text(size=14,face="bold")) +
     scale_y_continuous(labels= percent, limits = c(0,1)) 

 })
 
#####################################Compare States###################################################
 
 output$compareAvg = renderPlot({
   input$compareTemps
   statesToCompare = input$compareTemps
   validate(need(statesToCompare > 0, 'Please select at least one state.'))
   location = paste("Capitals/",statesToCompare[1],".csv",sep = "")
   stateFrame = stateAvgClean(location)

   if(length(statesToCompare)>1){
   for(i in 2:length(statesToCompare)){
     location = paste("Capitals/",statesToCompare[i],".csv",sep = "")
     state = stateAvgClean(location)
     stateFrame = merge(stateFrame, state, by = c("Month"))
   
   }}
   names(stateFrame) = c("Month",statesToCompare)
   stateFrame = melt(stateFrame, id.vars = c("Month"))
   names(stateFrame) = c("Month","State","Temperature")
   
   
   
   ggplot(data = stateFrame, aes(x = Month, y = Temperature, color = State, group = State)) +
     geom_line(size = 1.5) +
     ggtitle(paste("Average Temperature Comparison")) + 
     ylim(c(0,110)) +
     theme(legend.title=element_blank(), plot.title = element_text(size = 20, face="bold"),axis.text.y=element_text(size=12),axis.title=element_text(size=14,face="bold"))
   
 })

 
 
 output$compareHumidPlot = renderPlot({
   input$compareTemps
   statesToCompare = input$compareTemps
   validate(need(statesToCompare >0, ''))
   location = paste("Capitals/",statesToCompare[1],".csv",sep = "")
   stateFrame = stateHumidClean(location)
   if(length(statesToCompare)>1){
     for(i in 2:length(statesToCompare)){
       location = paste("Capitals/",statesToCompare[i],".csv",sep = "")
       state = stateHumidClean(location)
       stateFrame = merge(stateFrame, state, by = c("Month"))
     }}
   names(stateFrame) = c("Month",statesToCompare)
   stateFrame = melt(stateFrame, id.vars = c("Month"))
   names(stateFrame) = c("Month","State","Humidity")
   
   ggplot(data = stateFrame, aes(x = Month, y = Humidity, color = State, group = State)) +
     geom_line(size = 1.5) +
     ggtitle(paste("Humididty Comparison")) + 
     theme(legend.title=element_blank(), plot.title = element_text(size = 20, face="bold"), axis.text.y=element_text(size=12),axis.title=element_text(size=14,face="bold"))+
     scale_y_continuous(labels= percent, limits = c(0,1)) 
   
 })
 
 
######################################################################################################    
    
   
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
        cleanDate = month.day.year(weatherData$weatherDate)
        weatherData$weatherDate = paste(cleanDate$month, cleanDate$day, sep = "/")
        
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
        cleanDate = month.day.year(weatherData$weatherDate)
        weatherData$weatherDate = paste(cleanDate$month, cleanDate$day, sep = "/")
        
        ggplot(weatherData, aes(weatherDate, group = 2))+
          geom_line(aes(y = weatherHumidity, colour = "Humidity")) +
          labs(x = "\nDate", y = "Humidity\n",title = paste("Humidity for the",input$timeSelect, "Days")) +
          TemperatureTheme + scale_color_discrete(name = "Humidity") +
          scale_y_continuous(labels= percent, limits = c(0,1)) 

      })
      
      
      output$precipPlot = renderPlot({
        validate(
          need("precip" %in% input$plotChoice, 'Select precipitation as a varaible!')
        )
        weatherData = weatherValues$weather
        cleanDate = month.day.year(weatherData$weatherDate)
        weatherData$weatherDate = paste(cleanDate$month, cleanDate$day, sep = "/")
        
        ggplot(weatherData, aes(weatherDate, group = 2))+
          geom_line(aes(y = weatherPrecip, colour = "Inches per Hour")) +
          labs(x = "\nDate", y = "Precipitation\n",title = paste("Precipitation for the",input$timeSelect,"Days")) +
          TemperatureTheme + scale_color_discrete(name = "Precipitation")
      })
      
      
      
      output$temperaturePlot = renderPlot({
        validate(
          need("temp" %in% input$plotChoice, 'Select temperature as a varaible!')
        )   
        weatherData = weatherValues$weather
        cleanDate = month.day.year(weatherData$weatherDate)
        weatherData$weatherDate = paste(cleanDate$month, cleanDate$day, sep = "/")
        
        ggplot(weatherData, aes(weatherDate, group = 2))+
          geom_line(aes(y = weatherTempMax, colour = "Maximum")) +
          geom_line(aes(y = weatherTempMin, colour = "Minimum")) +
          labs(x = "\nDate", y = "Temperature\n",title = paste("Temperature for the",input$timeSelect, "Days")) +
          TemperatureTheme + scale_color_discrete(name = "Temperature")
      })
      
      
      output$ozonePlot = renderPlot({
        validate(
          need("ozone" %in% input$plotChoice, 'Select Ozone Levels as a varaible!'),
          need(nrow(weatherValues$weather) <30, strong('Sorry, ozone levels are not avaliable for the last 30 days.'))
        )  
        weatherData = weatherValues$weather
        cleanDate = month.day.year(weatherData$weatherDate)
        weatherData$weatherDate = paste(cleanDate$month, cleanDate$day, sep = "/")
        
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














