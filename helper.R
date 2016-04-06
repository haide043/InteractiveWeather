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
  
  weatherDF = as.data.frame(rbind(c(weatherCloudCover,weatherVisibillity,weatherWindBearing,
                                    weatherWindSpeed,weatherHumidity,weatherDewPoint,weatherTempMax,
                                    weatherTempMin,weatherPrecip,weatherMoonPhase,weatherSunset,
                                    weatherSunrise,weatherIcon,weatherSummary, weatherPressure, weatherOzone)))
  
  colnames(weatherDF) = col.names = c('weatherCloudCover','weatherVisibillity','weatherWindBearing',
                                      'weatherWindSpeed','weatherHumidity','weatherDewPoint','weatherTempMax',
                                      'weatherTempMin','weatherPrecip','weatherMoonPhase','weatherSunset',
                                      'weatherSunrise','weatherIcon','weatherSummary','weatherPressure','weatherOzone')
  return(weatherDF)
}


weatherDataFrame = NULL

weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/db60aece2f6cc54dc9a1c3706172b59c/",clat, ",",clng,",","1458968400", sep=""))

weatherDataFrame = getWeatherDataFromJSON(weatherJSON)
