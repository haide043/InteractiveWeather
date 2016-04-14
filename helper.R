#Gathering Data from Dark Sky Forecast API

library('RCurl')
library('rjson')


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

getWeatherDataFromJSONFuture <- function(weatherJSON) {
  JSONList <- fromJSON(weatherJSON)
  weatherDataFrame = NULL
  
  currentIcon = NA
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


next7Days = function(latitude, longitude){
  weatherDataFrame = NULL
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/db60aece2f6cc54dc9a1c3706172b59c/",latitude, ",",longitude, sep=""))
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
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/db60aece2f6cc54dc9a1c3706172b59c/",latitude, ",",longitude,",",as.integer(currentTime[i]), sep=""))
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
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/db60aece2f6cc54dc9a1c3706172b59c/",latitude, ",",longitude,",",as.integer(currentTime[i]), sep=""))
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
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/db60aece2f6cc54dc9a1c3706172b59c/",latitude, ",",longitude,",",as.integer(currentTime[i]), sep=""))
    JSONData = getWeatherDataFromJSON(weatherJSON)
    JSONData = cbind(JSONData, weatherDate = Sys.Date()-i+1)
    weatherDataFrame = rbind(weatherDataFrame, JSONData)
  }
  return(weatherDataFrame)
}



lastYear = function(){
  weatherDataFrame <<- NULL
  
  currentTime = c((as.POSIXct(Sys.time())))
  epoch = 24*60*60
  currentTime = currentTime + epoch
  for(i in 1:365){
    newDay = currentTime[i] - epoch
    currentTime = append(currentTime, newDay)
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/db60aece2f6cc54dc9a1c3706172b59c/44.9668,-93.25",",",as.integer(currentTime[i]), sep=""))
    JSONData = getWeatherDataFromJSONYear(weatherJSON)
    JSONData = cbind(JSONData, weatherDate = Sys.Date()-i+1)
    weatherDataFrame <<- rbind(weatherDataFrame, JSONData)
  }
  return(weatherDataFrame)
}


getWeatherDataFromJSONYear <- function(weatherJSON) {
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
    weatherSunrise = toString(as.POSIXct(as.numeric(toString(weatherSunrise)), origin = "1970-01-01"))
  }
  if(!is.null(JSONList$daily$data[[1]]$sunsetTime)){
    weatherSunset = JSONList$daily$data[[1]]$sunsetTime
    weatherSunset = toString(as.POSIXct(as.numeric(toString(weatherSunset)), origin = "1970-01-01"))
    
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

test = read.csv("USLatLong.csv")

test = test[which(complete.cases(test)==T),]
test[2] = test[2]*-1

latitudeList = test[1]
longitudeList = test[2]


getWeatherDataFromJSONCurrent <- function(weatherJSON) {
  JSONList <- fromJSON(weatherJSON)
  
  weatherSummary = NA
  weatherIcon = NA
  weatherMoonPhase = NA
  weatherPrecip = NA
  weatherTemperature = NA
  weatherApparentTemperature = NA
  weatherDewPoint = NA
  weatherHumidity = NA
  weatherWindSpeed = NA
  weatherWindBearing = NA
  weatherVisibillity = NA
  weatherCloudCover = NA
  weatherPressure= NA
  weatherOzone = NA
  weatherPrecipType = NA
  
  if(!is.null(JSONList$currently$summary)){
    weatherSummary = JSONList$currently$summary
  }
  if(!is.null(JSONList$currently$icon)){
    weatherIcon = JSONList$currently$icon
  }
  if(!is.null(JSONList$currently$sunsetTime)){
    weatherPrecipType = JSONList$currently$weatherPrecipType
  }
  if(!is.null(JSONList$currently$precipIntensity)){
    weatherPrecip = JSONList$currently$precipIntensity
  }
  if(!is.null(JSONList$currently$temperature)){
    weatherTemperature = JSONList$currently$temperature
  }
  if(!is.null(JSONList$currently$apparentTemperature)){
    weatherApparentTemperature = JSONList$currently$apparentTemperature
  }
  if(!is.null(JSONList$currently$dewPoint)){
    weatherDewPoint = JSONList$currently$dewPoint
  }
  if(!is.null(JSONList$currently$humidity)){
    weatherHumidity = JSONList$currently$humidity
  }
  if(!is.null(JSONList$currently$windSpeed)){
    weatherWindSpeed = JSONList$currently$windSpeed
  }
  if(!is.null(JSONList$currently$windBearing)){
    weatherWindBearing = JSONList$currently$windBearing
  }
  if(!is.null(JSONList$currently$visibility)){
    weatherVisibillity = JSONList$currently$visibility
  }
  if(!is.null(JSONList$currently$cloudCover)){
    weatherCloudCover = JSONList$currently$cloudCover
  }
  if(!is.null(JSONList$currently$pressure)){
    weatherPressure = JSONList$currently$pressure
  }
  if(!is.null(JSONList$currently$ozone)){
    weatherOzone = JSONList$currently$ozone
  }
  
  weatherDF = cbind.data.frame(weatherCloudCover,weatherVisibillity,weatherWindBearing,
                               weatherWindSpeed,weatherHumidity,weatherDewPoint,weatherApparentTemperature,
                               weatherTemperature,weatherPrecip,weatherPrecipType,
                               weatherIcon,weatherSummary, weatherPressure, weatherOzone)
  
  colnames(weatherDF) = col.names = c('weatherCloudCover','weatherVisibillity','weatherWindBearing',
                                      'weatherWindSpeed','weatherHumidity','weatherDewPoint','weatherApparentTemperature',
                                      'weatherTemperature','weatherPrecip','weatherPrecipType','weatherIcon','weatherSummary','weatherPressure','weatherOzone')
  return(weatherDF)
}



USCities = function(){
  weatherDataFrame <<- NULL
  for(i in 1:nrow(latitudeList)){
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/db60aece2f6cc54dc9a1c3706172b59c/",latitudeList[i,],",",longitudeList[i,], sep=""))
    JSONData = getWeatherDataFromJSONCurrent(weatherJSON)
    JSONData = cbind(JSONData, weatherLat = latitudeList[i,], weatherLong = longitudeList[i,])
    weatherDataFrame <<- rbind(weatherDataFrame, JSONData)
  }
  return(weatherDataFrame)
}

#Ran on 4/13/16 @ 2:06PM







