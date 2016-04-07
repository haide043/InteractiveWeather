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

last7Days = function(latitude, longitude){
  weatherDataFrame = NULL
  
  currentTime = c(as.numeric(as.POSIXct(Sys.time())))
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
  
  currentTime = c(as.numeric(as.POSIXct(Sys.time())))
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
