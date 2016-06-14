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
                   tabPanel("Choosing a State to Live in",
                            fluidRow(
                              column(12,
                                     titlePanel(h1(strong("Pick a Capital based on Weather"), align = "center")))),
                            fluidRow(
                              column(3,style = "background-color:#D3D3D3; color:#000000;",
                                     radioButtons("statesTemp", label = h3("Cities to Choose From"), 
                                                  choices = list("Montgomery, Alabama" = "Alabama",  "Juneau, Alaska" = "Alaska",  "Phoenix, Arizona" = "Arizona",
                                                                 "Little Rock, Arkansas" = "Arkansas",  "Sacramento, California" = "California",  "Denver, Colorado" = "Colorado",
                                                                 "Hartford, Connecticut" = "Connecticut",  "Dover, Delaware" = "Delaware",  "Tallahassee, Florida" = "Florida", 
                                                                 "Atlanta, Georgia" = "Georgia",  "Honolulu, Hawaii" = "Hawaii",  "Boise, Idaho" = "Idaho",  "Springfield, Illinois" = "Illisnois",
                                                                 "Indianapolis, Indiana" = "Indiana",  "Des Moines, Iowa" = "Iowa",  "Topeka, Kansas" = "Kansas",  "Frankfort, Kentucky" = "Kentucky",
                                                                 "Baton Rouge, Louisiana" = "Louisiana",  "Augusta, Maine" = "Maine",  "Annapolis, Maryland" = "Maryland",  "Boston, Massachusetts" = "Massachusetts",
                                                                 "Lansing, Michigan" = "Michigan",  "St. Paul, Minnesota" = "Minnesota",  "Jackson, Mississippi" = "Mississippi",  "Jefferson City, Missouri" = "Missouri", 
                                                                 "Helena, Montana" = "Montana",  "Lincoln, Nebraska" = "Nebraska",  "Carson City, Nevada" = "Nevada",  "Concord, New Hampshire" = "NewHampshire",
                                                                 "Trenton, New Jersey" = "NewJersey",  "Santa Fe, New Mexico" ="NewMexico",  "Albany, New York" = "NewYork",  "Raleigh, North Carolina" = "NorthCarolina",
                                                                 "Bismarck, North Dakota" = "NorthDakota",  "Columbus, Ohio" = "Ohio",  "Oklahoma City, Oklahoma" = "Oklahoma",  "Salem, Oregon" = "Oregon",  "Harrisburg, Pennsylvania" = "Pennsylvania",
                                                                 "Providence, Rhode Island" = "RhodeIsland",  "Columbia, South Carolina" = "SouthCarolina",  "Pierre, South Dakota" = "SouthDakota",  "Nashville, Tennessee" = "Tennessee",
                                                                 "Austin, Texas" = "Texas",  "Salt Lake City, Utah" = "Utah",  "Montpelier, Vermont" = "Vermont",  "Richmond, Virginia" = "Virgina",  "Olympia, Washington" = "Washington",
                                                                 "Charleston, West Virginia" = "WestVirginia",  "Madison, Wisconsin" = "Wisconsin",  "Cheyenne, Wyoming" = "Wyoming"
                                                                 
                                                  ),selected = "Minnesota", width = "800px")  
                              ),
                              column(9,
                                     plotOutput("stateTempPlot", width = "100%")
                              )
                            )
                                                         
                            )))





