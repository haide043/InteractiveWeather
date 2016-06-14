#Gathering Data from Dark Sky Forecast API

library('RCurl')
library('rjson')

getWeatherDataFromJSONFuture <- function(weatherJSON) {
  JSONList <- fromJSON(weatherJSON)
  weatherDataFrame = NULL
  
  currentIcon = NA
  weatherDate = NA
  weatherSummary = NA
  weatherIcon = NA
  weatherSunrise = NA
  weatherSunset = NA
  weatherMoonPhase = NA
  weatherPrecip = NA
  weatherTempMin = NA
  weatherTempMax = NA
  weatherDewPoint = NA
  weatherHumidity = NA
  weatherWindSpeed = NA
  weatherWindBearing = NA
  weatherVisibillity = NA
  weatherCloudCover = NA
  weatherPressure= NA
  weatherOzone = NA
  for(i in 2:8){
    if(!is.null(JSONList$daily$data[[i]]$time)){
      weatherDate = JSONList$daily$data[[i]]$time
      weatherDate = toString(as.POSIXct(as.numeric(toString(weatherDate)), origin = "1970-01-01"))
      
    }
    if(!is.null(JSONList$daily$data[[i]]$summary)){
      weatherSummary = JSONList$daily$data[[i]]$summary
    }
    if(!is.null(JSONList$daily$data[[i]]$summary)){
      weatherSummary = JSONList$daily$data[[i]]$summary
    } 
    if(!is.null(JSONList$current$icon)){
      currentIcon = JSONList$current$icon
    }
    if(!is.null(JSONList$daily$data[[i]]$sunriseTime)){
      weatherSunrise = JSONList$daily$data[[i]]$sunriseTime
      weatherSunrise = toString(as.POSIXct(as.numeric(toString(weatherSunrise)), origin = "1970-01-01"))
    }
    if(!is.null(JSONList$daily$data[[i]]$sunsetTime)){
      weatherSunset = JSONList$daily$data[[i]]$sunsetTime
      weatherSunset = toString(as.POSIXct(as.numeric(toString(weatherSunset)), origin = "1970-01-01"))
      
    }
    if(!is.null(JSONList$daily$data[[i]]$moonPhase)){
      weatherMoonPhase = JSONList$daily$data[[i]]$moonPhase
    }
    if(!is.null(JSONList$daily$data[[i]]$precipIntensity)){
      weatherPrecip = JSONList$daily$data[[i]]$precipIntensity
    }
    if(!is.null(JSONList$daily$data[[i]]$temperatureMin)){
      weatherTempMin = JSONList$daily$data[[i]]$temperatureMin
    }
    if(!is.null(JSONList$daily$data[[i]]$temperatureMax)){
      weatherTempMax = JSONList$daily$data[[i]]$temperatureMax
    }
    if(!is.null(JSONList$daily$data[[i]]$dewPoint)){
      weatherDewPoint = JSONList$daily$data[[i]]$dewPoint
    }
    if(!is.null(JSONList$daily$data[[i]]$humidity)){
      weatherHumidity = JSONList$daily$data[[i]]$humidity
    }
    if(!is.null(JSONList$daily$data[[i]]$windSpeed)){
      weatherWindSpeed = JSONList$daily$data[[i]]$windSpeed
    }
    if(!is.null(JSONList$daily$data[[i]]$windBearing)){
      weatherWindBearing = JSONList$daily$data[[i]]$windBearing
    }
    if(!is.null(JSONList$daily$data[[i]]$visibility)){
      weatherVisibillity = JSONList$daily$data[[i]]$visibility
    }
    if(!is.null(JSONList$daily$data[[i]]$cloudCover)){
      weatherCloudCover = JSONList$daily$data[[i]]$cloudCover
    }
    if(!is.null(JSONList$daily$data[[i]]$pressure)){
      weatherPressure = JSONList$daily$data[[i]]$pressure
    }
    if(!is.null(JSONList$daily$data[[i]]$ozone)){
      weatherOzone = JSONList$daily$data[[i]]$ozone
    }
    
    weatherDF = cbind.data.frame(currentIcon, weatherDate, weatherCloudCover,weatherVisibillity,weatherWindBearing,
                                 weatherWindSpeed,weatherHumidity,weatherDewPoint,weatherTempMax,
                                 weatherTempMin,weatherPrecip,weatherMoonPhase,weatherSunset,
                                 weatherSunrise,weatherIcon,weatherSummary, weatherPressure, weatherOzone)
    
    colnames(weatherDF) = col.names = c('currentIcon','weatherDate','weatherCloudCover','weatherVisibillity','weatherWindBearing',
                                        'weatherWindSpeed','weatherHumidity','weatherDewPoint','weatherTempMax',
                                        'weatherTempMin','weatherPrecip','weatherMoonPhase','weatherSunset',
                                        'weatherSunrise','weatherIcon','weatherSummary','weatherPressure','weatherOzone')
    
    weatherDataFrame = rbind(weatherDataFrame, weatherDF)
  }
  
  return(weatherDataFrame)
}

getWeatherDataFromJSON <- function(weatherJSON) {
  JSONList <- fromJSON(weatherJSON)
  
  weatherSummary = NA
  weatherIcon = NA
  weatherSunrise = NA
  weatherSunset = NA
  weatherMoonPhase = NA
  weatherPrecip = NA
  weatherTempMin = NA
  weatherTempMax = NA
  weatherDewPoint = NA
  weatherHumidity = NA
  weatherWindSpeed = NA
  weatherWindBearing = NA
  weatherVisibillity = NA
  weatherCloudCover = NA
  weatherPressure= NA
  weatherOzone = NA
  
  if(!is.null(JSONList$daily$data[[1]]$summary)){
    weatherSummary = JSONList$daily$data[[1]]$summary
  }
  if(!is.null(JSONList$daily$data[[1]]$icon)){
    weatherIcon = JSONList$daily$data[[1]]$icon
  }
  if(!is.null(JSONList$daily$data[[1]]$sunriseTime)){
    weatherSunrise = JSONList$daily$data[[1]]$sunriseTime
    weatherSunrise = toString(as.POSIXct(as.numeric(toString(weatherSunrise)), origin = "1970-01-01", format="%m/%d/%Y"))
  }
  if(!is.null(JSONList$daily$data[[1]]$sunsetTime)){
    weatherSunset = JSONList$daily$data[[1]]$sunsetTime
    weatherSunset = toString(as.POSIXct(as.numeric(toString(weatherSunset)), origin = "1970-01-01",format="%m/%d/%Y"))
    
  }
  if(!is.null(JSONList$daily$data[[1]]$moonPhase)){
    weatherMoonPhase = JSONList$daily$data[[1]]$moonPhase
  }
  if(!is.null(JSONList$daily$data[[1]]$precipIntensity)){
    weatherPrecip = JSONList$daily$data[[1]]$precipIntensity
  }
  if(!is.null(JSONList$daily$data[[1]]$temperatureMin)){
    weatherTempMin = JSONList$daily$data[[1]]$temperatureMin
  }
  if(!is.null(JSONList$daily$data[[1]]$temperatureMax)){
    weatherTempMax = JSONList$daily$data[[1]]$temperatureMax
  }
  if(!is.null(JSONList$daily$data[[1]]$dewPoint)){
    weatherDewPoint = JSONList$daily$data[[1]]$dewPoint
  }
  if(!is.null(JSONList$daily$data[[1]]$humidity)){
    weatherHumidity = JSONList$daily$data[[1]]$humidity
  }
  if(!is.null(JSONList$daily$data[[1]]$windSpeed)){
    weatherWindSpeed = JSONList$daily$data[[1]]$windSpeed
  }
  if(!is.null(JSONList$daily$data[[1]]$windBearing)){
    weatherWindBearing = JSONList$daily$data[[1]]$windBearing
  }
  if(!is.null(JSONList$daily$data[[1]]$visibility)){
    weatherVisibillity = JSONList$daily$data[[1]]$visibility
  }
  if(!is.null(JSONList$daily$data[[1]]$cloudCover)){
    weatherCloudCover = JSONList$daily$data[[1]]$cloudCover
  }
  if(!is.null(JSONList$daily$data[[1]]$pressure)){
    weatherPressure = JSONList$daily$data[[1]]$pressure
  }
  if(!is.null(JSONList$daily$data[[1]]$ozone)){
    weatherOzone = JSONList$daily$data[[1]]$ozone
  }
  
  weatherDF = cbind.data.frame(weatherCloudCover,weatherVisibillity,weatherWindBearing,
                                    weatherWindSpeed,weatherHumidity,weatherDewPoint,weatherTempMax,
                                    weatherTempMin,weatherPrecip,weatherMoonPhase,weatherSunset,
                                    weatherSunrise,weatherIcon,weatherSummary, weatherPressure, weatherOzone)
  
  colnames(weatherDF) = col.names = c('weatherCloudCover','weatherVisibillity','weatherWindBearing',
                                      'weatherWindSpeed','weatherHumidity','weatherDewPoint','weatherTempMax',
                                      'weatherTempMin','weatherPrecip','weatherMoonPhase','weatherSunset',
                                      'weatherSunrise','weatherIcon','weatherSummary','weatherPressure','weatherOzone')
  return(weatherDF)
}

next7Days = function(latitude, longitude){
  weatherDataFrame = NULL
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/",darkForecastAPIKey,"/",latitude, ",",longitude, sep=""))
    weatherDataFrame = getWeatherDataFromJSONFuture(weatherJSON)
  return(weatherDataFrame)
}

last7Days = function(latitude, longitude){
  weatherDataFrame = NULL
  
  currentTime = c(as.numeric(as.POSIXct(Sys.time(),format="%m/%d/%Y")))
  epoch = 24*60*60
  currentTime = currentTime + epoch
  for(i in 1:2){
    newDay = currentTime[i] - epoch
    currentTime = append(currentTime, newDay)
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/",darkForecastAPIKey,"/",latitude, ",",longitude,",",as.integer(currentTime[i]), sep=""))
    JSONData = getWeatherDataFromJSON(weatherJSON)
    JSONData = cbind(JSONData, weatherDate = Sys.Date()-i+1)
    weatherDataFrame = rbind(weatherDataFrame, JSONData)
  }
  return(weatherDataFrame)
}

last30Days = function(latitude, longitude){
  weatherDataFrame = NULL
  
  currentTime = c((as.POSIXct(Sys.time())))
  epoch = 24*60*60
  currentTime = currentTime + epoch
  for(i in 1:3){
    newDay = currentTime[i] - epoch
    currentTime = append(currentTime, newDay)
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/",darkForecastAPIKey,"/",latitude, ",",longitude,",",as.integer(currentTime[i]), sep=""))
    JSONData = getWeatherDataFromJSON(weatherJSON)
    JSONData = cbind(JSONData, weatherDate = Sys.Date()-i+1)
    weatherDataFrame = rbind(weatherDataFrame, JSONData)
  }
  return(weatherDataFrame)
}


last1Days = function(latitude, longitude){
  weatherDataFrame = NULL
  
  currentTime = c(as.numeric(as.POSIXct(Sys.time())))
  epoch = 24*60*60
  currentTime = currentTime + epoch
  for(i in 1){
    newDay = currentTime[i] - epoch
    currentTime = append(currentTime, newDay)
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/",darkForecastAPIKey,"/",latitude, ",",longitude,",",as.integer(currentTime[i]), sep=""))
    JSONData = getWeatherDataFromJSON(weatherJSON)
    JSONData = cbind(JSONData, weatherDate = Sys.Date()-i+1)
    weatherDataFrame = rbind(weatherDataFrame, JSONData)
  }
  return(weatherDataFrame)
}



#####################################################

clat = NULL
clng = NULL

TemperatureTheme <- theme_grey() + theme(plot.title = element_text(family = "Times", face = "bold", colour = "Black", size = rel(2)), 
                                         axis.title = element_text(family = "Times", size= rel(2)), plot.background = element_rect(fill = "grey"))

rainIcon <- makeIcon(
  iconUrl = "http://pix.iemoji.com/twit33/0564.png",
  iconWidth = 30, iconHeight = 30
)

cloudyIcon <- makeIcon(
  iconUrl = "http://pix.iemoji.com/lg33/0082.png",
  iconWidth = 30, iconHeight = 30
)

partlyCloudyIcon <- makeIcon(
  iconUrl = "http://pix.iemoji.com/lg33/0116.png",
  iconWidth = 30, iconHeight = 30
)

windIcon <- makeIcon(
  iconUrl = "http://pix.iemoji.com/hang33/0262.png",
  iconWidth = 30, iconHeight = 30
)

clearIcon <- makeIcon(
  iconUrl = "https://www.emojibase.com/resources/img/emojis/apple/x2600.png.pagespeed.ic.GGgVrp9saD.png",
  iconWidth = 30, iconHeight = 30
)

fogIcon <- makeIcon(
  iconUrl = "http://emojipedia-us.s3.amazonaws.com/cache/dc/a6/dca6d0753f95f1b458b95b2d1d19bf22.png",
  iconWidth = 30, iconHeight = 30
)

clearNightIcon <- makeIcon(
  iconUrl = "http://iconbug.com/data/c4/128/625f4bf63872e54df73ced5d07eb455b.png",
  iconWidth = 30, iconHeight = 30
)

snowIcon <- makeIcon(
  iconUrl = "http://pix.iemoji.com/twit33/0139.png",
  iconWidth = 30, iconHeight = 30
)

sleetIcon <- makeIcon(
  iconUrl = "http://w1.bcn.cat/temps/img/temps_ico/aiguaneu.png",
  iconWidth = 30, iconHeight = 30
)

partlyCloudyNightIcon <- makeIcon(
  iconUrl = "http://media.nbcbayarea.com/designimages/new_wx_99.png",
  iconWidth = 30, iconHeight = 30
)

iconDataTable = data.frame(Meaning = c('Rain','Cloudy','Partly Cloudy','Windy', 'Clear Day','Foggy',
                                       'Clear Night','Snow','Sleet','Partly Cloudy Night'),
                           Icon = c('<img src = "http://pix.iemoji.com/twit33/0564.png" height = "30" width = "30"></img>',
                                    '<img src = "http://pix.iemoji.com/lg33/0082.png" height = "30" width = "30"></img>',
                                    '<img src = "http://pix.iemoji.com/lg33/0116.png" height = "30" width = "30"></img>',
                                    '<img src = "http://pix.iemoji.com/hang33/0262.png" height = "30" width = "30"></img>',
                                    '<img src = "https://www.emojibase.com/resources/img/emojis/apple/x2600.png.pagespeed.ic.GGgVrp9saD.png" height = "30" width = "30"></img>',
                                    '<img src = "http://emojipedia-us.s3.amazonaws.com/cache/dc/a6/dca6d0753f95f1b458b95b2d1d19bf22.png" height = "30" width = "30"></img>',
                                    '<img src = "http://iconbug.com/data/c4/128/625f4bf63872e54df73ced5d07eb455b.png" height = "30" width = "30"></img>',
                                    '<img src = "http://pix.iemoji.com/twit33/0139.png" height = "30" width = "30"></img>',
                                    '<img src = "http://w1.bcn.cat/temps/img/temps_ico/aiguaneu.png" height = "30" width = "30"></img>',
                                    '<img src = "http://media.nbcbayarea.com/designimages/new_wx_99.png" height = "30" width = "30"></img>'))




