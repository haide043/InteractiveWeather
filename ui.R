library(shiny)
library(leaflet)
library(RColorBrewer)
library(DT)


shinyUI(navbarPage(theme ="bootstrap.css", "Interactive Weather",
                   tabPanel("Home",
                            fluidRow(
                              column(8, offset = 2,
                                     titlePanel(h1(strong("World Wide Weather"), align = "center")),
                                     h2("Created by Humza Haider", align = "center"),
                                     br(),
                                     br(),
                                     h3("Click one of the tabs to explore different types of weather analysis.",em("World Weather Report"), "will supply a map of the world. On this map you
                                        will be able to click anywhere in the world to get forecast information for the next 7 days as well as historical information for 7 to 30 days in the past."),
                                     br(),
                                     h3(em("State Weather"),"will display the yearly temperatures and humidity for any of the 50 states, based on your choosing.")),
                              column(2))
                            
                   ),
                   tabPanel("World Weather Report",
                            fluidRow(
                              column(8, offset = 2,
                                     titlePanel(h1(strong("World Weather Report"), align = "center")),
                                     br(),
                                     h3("You can use this map to show either forecast data or historical data. If you would like to view historical data
                                        choose either the 'Past 7 Days' or the 'Past 30 Days' from the time select drop down. If you would like to see
                                        the 7 day forecast, choose 'Next 7 Days'.", strong("Please allow time for the historical data to load.")),
                                    
                                  
                              h3("When in the 'Next 7 Days' selection when you click the map, the icon will change based on that locations current weather conditions.
                                 See the table below for icon interpretation."),
                        
                              h3("Choose the variables you would like to be displayed. In addition to clicking a location on the map you are able to search for a specific location using the text box.")),
                              column(2)),
                            br(),
                            fluidRow(
                              column(2, 
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
                              column(3,
                                     DT::dataTableOutput('iconTable', width = "100%")),
                              column(7,
                                     leafletOutput("mymap", height = "600px"))
                              
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
                   tabPanel("State Weather",
                            tabsetPanel(
                              tabPanel("View Individual States",
                            fluidRow(
                              column(12,
                                     titlePanel(h1(strong("Choose a Capital to see Average Yearly Weather"), align = "center")))),
                            hr(),
                            fluidRow(
                              column(4,style = "background-color:#D3D3D3; color:#000000;",
                                     radioButtons("statesTemp", label = h3(""), 
                                                  choices = list("Montgomery, Alabama" = "Alabama",  "Juneau, Alaska" = "Alaska",  "Phoenix, Arizona" = "Arizona",
                                                                 "Little Rock, Arkansas" = "Arkansas",  "Sacramento, California" = "California",  "Denver, Colorado" = "Colorado",
                                                                 "Hartford, Connecticut" = "Connecticut",  "Dover, Delaware" = "Delaware",  "Tallahassee, Florida" = "Florida", 
                                                                 "Atlanta, Georgia" = "Georgia",  "Honolulu, Hawaii" = "Hawaii",  "Boise, Idaho" = "Idaho",  "Springfield, Illinois" = "Illinois",
                                                                 "Indianapolis, Indiana" = "Indiana",  "Des Moines, Iowa" = "Iowa",  "Topeka, Kansas" = "Kansas",  "Frankfort, Kentucky" = "Kentucky",
                                                                 "Baton Rouge, Louisiana" = "Louisiana",  "Augusta, Maine" = "Maine",  "Annapolis, Maryland" = "Maryland",  "Boston, Massachusetts" = "Massachusetts",
                                                                 "Lansing, Michigan" = "Michigan",  "St. Paul, Minnesota" = "Minnesota",  "Jackson, Mississippi" = "Mississippi",  "Jefferson City, Missouri" = "Missouri"
                                                                 
                                                                 
                                                  ),selected = "Minnesota", width = "800px")
                              ),
                              column(4, style = "background-color:#D3D3D3; color:#000000;",
                                     radioButtons("statesTemp2", label = h3(""), 
                                                  choices = list(
                                      "Helena, Montana" = "Montana","Lincoln, Nebraska" = "Nebraska",  "Carson City, Nevada" = "Nevada",  "Concord, New Hampshire" = "New Hampshire",
                                     "Trenton, New Jersey" = "New Jersey",  "Santa Fe, New Mexico" ="New Mexico",  "Albany, New York" = "New York",  "Raleigh, North Carolina" = "North Carolina",
                                     "Bismarck, North Dakota" = "North Dakota",  "Columbus, Ohio" = "Ohio",  "Oklahoma City, Oklahoma" = "Oklahoma",  "Salem, Oregon" = "Oregon",  "Harrisburg, Pennsylvania" = "Pennsylvania",
                                     "Providence, Rhode Island" = "Rhode Island",  "Columbia, South Carolina" = "South Carolina",  "Pierre, South Dakota" = "South Dakota",  "Nashville, Tennessee" = "Tennessee",
                                     "Austin, Texas" = "Texas",  "Salt Lake City, Utah" = "Utah",  "Montpelier, Vermont" = "Vermont",  "Richmond, Virginia" = "Virgina",  "Olympia, Washington" = "Washington",
                                     "Charleston, West Virginia" = "West Virginia",  "Madison, Wisconsin" = "Wisconsin",  "Cheyenne, Wyoming" = "Wyoming"
                              ),selected = character(0), width = "800px"
                            )),
                            column(4,
                                   plotOutput("stateTempPlot", width = "100%"),
                                   plotOutput("stateHumidPlot", width = "87.5%")
                            ))),
                            tabPanel("Compare States",
                                     fluidRow(
                                       column(12,
                                              titlePanel(h1(strong("Choose a Capital to see Average Yearly Weather"), align = "center")))),
                                     hr(),
                                     fluidRow(
                                       column(4,style = "background-color:#D3D3D3; color:#000000;",
                                              checkboxGroupInput("compareTemps", label = h3(""), 
                                                           choices = list("Montgomery, Alabama" = "Alabama",  "Juneau, Alaska" = "Alaska",  "Phoenix, Arizona" = "Arizona",
                                                                          "Little Rock, Arkansas" = "Arkansas",  "Sacramento, California" = "California",  "Denver, Colorado" = "Colorado",
                                                                          "Hartford, Connecticut" = "Connecticut",  "Dover, Delaware" = "Delaware",  "Tallahassee, Florida" = "Florida", 
                                                                          "Atlanta, Georgia" = "Georgia",  "Honolulu, Hawaii" = "Hawaii",  "Boise, Idaho" = "Idaho",  "Springfield, Illinois" = "Illinois",
                                                                          "Indianapolis, Indiana" = "Indiana",  "Des Moines, Iowa" = "Iowa",  "Topeka, Kansas" = "Kansas",  "Frankfort, Kentucky" = "Kentucky",
                                                                          "Baton Rouge, Louisiana" = "Louisiana",  "Augusta, Maine" = "Maine",  "Annapolis, Maryland" = "Maryland",  "Boston, Massachusetts" = "Massachusetts",
                                                                          "Lansing, Michigan" = "Michigan",  "St. Paul, Minnesota" = "Minnesota",  "Jackson, Mississippi" = "Mississippi",  "Jefferson City, Missouri" = "Missouri",
                                                                          "Helena, Montana" = "Montana","Lincoln, Nebraska" = "Nebraska",  "Carson City, Nevada" = "Nevada",  "Concord, New Hampshire" = "New Hampshire",
                                                                          "Trenton, New Jersey" = "New Jersey",  "Santa Fe, New Mexico" ="New Mexico",  "Albany, New York" = "New York",  "Raleigh, North Carolina" = "North Carolina",
                                                                          "Bismarck, North Dakota" = "North Dakota",  "Columbus, Ohio" = "Ohio",  "Oklahoma City, Oklahoma" = "Oklahoma",  "Salem, Oregon" = "Oregon",  "Harrisburg, Pennsylvania" = "Pennsylvania",
                                                                          "Providence, Rhode Island" = "Rhode Island",  "Columbia, South Carolina" = "South Carolina",  "Pierre, South Dakota" = "South Dakota",  "Nashville, Tennessee" = "Tennessee",
                                                                          "Austin, Texas" = "Texas",  "Salt Lake City, Utah" = "Utah",  "Montpelier, Vermont" = "Vermont",  "Richmond, Virginia" = "Virgina",  "Olympia, Washington" = "Washington",
                                                                          "Charleston, West Virginia" = "West Virginia",  "Madison, Wisconsin" = "Wisconsin",  "Cheyenne, Wyoming" = "Wyoming"
                                                                          
                                                                          
                                                           ),selected = c("Minnesota","Hawaii"), width = "800px")),
                                              
                                             
                                       column(8,
                                              plotOutput("compareAvg", width = "100%"),
                                              plotOutput("compareHumidPlot", width = "100%")
                                       ))
                            )))
                                                         
                            ))





