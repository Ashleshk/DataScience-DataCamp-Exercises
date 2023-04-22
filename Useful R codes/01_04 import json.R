# Challenge: Import a JSON file
# Difficulty: 2

# retrieve the most current water level from the USGS API
# error trap the retrieval
# extract both the level and date from results

#install.packages("jsonlite")
library(jsonlite)

bullrunURL <- "https://waterservices.usgs.gov/nwis/iv/?format=json&sites=14138850&parameterCd=00060,00065&siteStatus=all"

bullrunWater <- tryCatch(fromJSON(bullrunURL),
                         error = function(e) {message(paste("Error:", e))}
)

brw_waterLevel <- as.numeric(bullrunWater$value$timeSeries$values[[1]]$value[[1]]$value)
brw_time <- as.Date(bullrunWater$value$timeSeries$values[[1]]$value[[1]]$dateTime )
