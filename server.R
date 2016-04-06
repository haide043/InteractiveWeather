# server.R  
library(shiny)
library(leaflet)
library(ggmap)
source('helper.R')

lightningtBoltIcon <- makeIcon(
  iconUrl = "http://emojipedia-us.s3.amazonaws.com/cache/11/d9/11d9507d9aec50e2758c0759e231a95a.png",
  iconWidth = 38, iconHeight = 95,
  iconAnchorX = 22, iconAnchorY = 94
)

TemperatureTheme <- theme_grey() + theme(plot.title = element_text(family = "Times", face = "bold", colour = "Black", size = rel(2)), 
                                     axis.title = element_text(family = "Times", size= rel(2)))

shinyServer(function(input, output, session) {  
  output$mymap <- renderLeaflet({
    leaflet()  %>% setView(-93.65, 42.0285, zoom = 4) %>% setMaxBounds(-180, -90, 180, 90) %>% 
      addProviderTiles("MapQuestOpen.OSM", options = providerTileOptions(noWrap = T, minZoom = 3))
      #addTiles(
      #urlTemplate = "//{s}.mqcdn.com/tiles/1.0.0/{type}/{z}/{x}/{y}.{ext}",
      #attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>',
      #options = tileOptions(noWrap = T, minZoom = 3)
  #  )
  })
  observeEvent(input$mymap_click, {
    click = input$mymap_click
    clat <- click$lat
    clng <- click$lng
    #address = revgeocode(c(clng,clat))
    leafletProxy("mymap") %>% clearMarkers()
    leafletProxy("mymap") %>% addMarkers(lng = clng, lat = clat, icon = lightningtBoltIcon)
  
    
    
    
    })
  
  df =eventReactive(input$mymap_click,{
    click = input$mymap_click
    clat <- click$lat
    clng <- click$lng
    
    weatherData = last7Days(clat, clng)
    
    ggplot(weatherData, aes(weatherDate, group = 2))+
      geom_line(aes(y = weatherTempMax, colour = "Maximum")) +
      geom_line(aes(y = weatherTempMin, colour = "Minimum")) +
      labs(x = "\nDate", y = "Temperature\n",title = "Temperature for the Last 7 Days") +
      TemperatureTheme + scale_color_discrete(name = "Temperature")
  })
  
  output$temperaturePlot = renderPlot({
    df()
      })
  
})
















