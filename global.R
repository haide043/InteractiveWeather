#global.R
library(rjson)

darkForecastAPIKey = fromJSON(file = "keys.json")$pw

radioSwitch = TRUE
