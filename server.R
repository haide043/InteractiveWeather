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

shinyServer(function(input, output, session) {  
  output$mymap <- renderLeaflet({
    leaflet() %>% addTiles() %>% setView(-93.65, 42.0285, zoom = 4) 
  })
  observeEvent(input$mymap_click, {
    click = input$mymap_click
    clat <<- click$lat
    clng <<- click$lng
    address = revgeocode(c(clng,clat))
    leafletProxy("mymap") %>% clearMarkers()
    leafletProxy("mymap") %>% addMarkers(lng = clng, lat = clat, icon = lightningtBoltIcon)
  })
  
})