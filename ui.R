library(shiny)
library(leaflet)
library(RColorBrewer)
library(DT)


shinyUI(navbarPage(theme ="bootstrap.css", "Weather Interactive",
                   tabPanel("Home",
                            fluidRow(
                              column(2),
                              column(8,
                                     titlePanel(h1(strong("World Wide Weather"), align = "center")),
                                     h2("Created by Humza Haider", align = "center"),
                                     br(),
                                     br(),
                                     h4("Click one of the tabs to explore different types of weather analysis.",em("World Weather Report"), "will supply a map of the world. On this map you
                                        will be able to click anywhere in the world to get forecast information for the next 7 days as well as historical information for 7 to 30 days in the past."),
                                     br(),
                                     h4(em("Weather Something Else"),"will do something else which I haven't decided yet.")),
                              column(2))
                            
                   ),
                   tabPanel("World Weather Report",
                            fluidRow(
                              column(12,
                                     titlePanel(h1(strong("World Weather Report"), align = "center")),
                                     br(),
                                     h5("You can use this map to show either forecast data or historical data. If you would like to view historical data
                                        choose either the 'Past 7 Days' or the 'Past 30 Days' from the time selection drop down. If you would like to see
                                        the 7 day forecast, choose 'Next 7 Days'. Make sure to alot time for the data to load for historical data."),
                                  
                              h5("When in the 'Next 7 Days' selection when you click the map, the icon will change based on that locations current weather conditions.
                                 See the table below for icon interpretation."),
                        
                              h5("Once selecting what days you would like to see you can select variables you would like to view for those days. 
                                        In addition to clicking a location on the map you are able to search for a specific location using the text box."))),
                        
                            fluidRow(
                              column(5,
                                     DT::dataTableOutput('iconTable'))),
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
                                                          "Ozone Levels" = "ozone"
                                                        )),
                                     
                                     textInput("location", label = h3("Search for a place!"),
                                               value = NULL),
                                     actionButton("findLocation", label = "Search")
                              ),
                              column(9,
                                     leafletOutput("mymap", height = "600")
                              )),
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
                              )),
                            br(),
                            fluidRow(
                              column(6,
                                     plotOutput("humidPlot", width = "100%")
                              ),
                              column(6,
                                     plotOutput("ozonePlot", width = "100%")
                              ))
                            
                            ),
                   tabPanel("Weather Something Else")))





