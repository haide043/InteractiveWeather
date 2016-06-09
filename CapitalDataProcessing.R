capitals = read.csv('USCapitals.csv', stringsAsFactors = F)





lastYear = function(){
  for(j in 1:50){
    weatherDataFrame = NULL
    
    currentTime = c((as.POSIXct(Sys.time())))
    epoch = 24*60*60
    currentTime = currentTime + epoch
  for(i in 1:367){
    newDay = currentTime[i] - epoch
    currentTime = append(currentTime, newDay)
    weatherJSON = getURL(url = paste("https://api.forecast.io/forecast/",darkForecastAPIKey,"/",capitals[j,'Latitude'], ",",capitals[j,'Longitude'],",",as.integer(currentTime[i]), sep=""))
    JSONData = getWeatherDataFromJSON(weatherJSON)
    JSONData = cbind(JSONData, weatherDate = Sys.Date()-i+1)
    weatherDataFrame = rbind(weatherDataFrame, JSONData)
  }
  write.csv(weatherDataFrame, paste(capitals[j,1], '.csv', sep = ""))
  }
}