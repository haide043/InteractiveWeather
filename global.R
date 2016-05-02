#global.R
library(rjson)

darkForecastAPIKey = fromJSON(file = "keys.json")$pw
Cities = read.csv("USCities.csv")


cloudyLat = Cities[which(Cities$weatherIcon == "cloudy"),"weatherLat"]
cloudyLon = Cities[which(Cities$weatherIcon == "cloudy"),"weatherLong"]

partlycloudyLat = Cities[which(Cities$weatherIcon == "partly-cloudy-day"),"weatherLat"]
partlycloudyLon = Cities[which(Cities$weatherIcon == "partly-cloudy-day"),"weatherLong"]

rainLat = Cities[which(Cities$weatherIcon == "rain"),"weatherLat"]
rainLon = Cities[which(Cities$weatherIcon == "rain"),"weatherLong"]

clearLat = Cities[which(Cities$weatherIcon == "clear-day"),"weatherLat"]
clearLon = Cities[which(Cities$weatherIcon == "clear-day"),"weatherLong"]

windLat = Cities[which(Cities$weatherIcon == "wind"),"weatherLat"]
windLon = Cities[which(Cities$weatherIcon == "wind"),"weatherLong"]

fogLat = Cities[which(Cities$weatherIcon == "fog"),"weatherLat"]
fogLon = Cities[which(Cities$weatherIcon == "fog"),"weatherLong"]
