# Challenge: Recover gracefully when an import fails
# Difficulty: 2

# Challenge: import the United Nations world population database
# all fields should be integer or numeric
# except variant = factor, location = character
# If the URL doesn't work, import a local copy of the file
# Use try catch to error trap a URL

# the URL to use is
# "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_TotalPopulationBySex.csv"

worldPopURL <- "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_TotalPopulationBySex.csv"
worldPopFile <- "worldPopulation.csv"
worldPopColClasses <- c("integer","character","integer", 
                        "factor", "integer", "numeric",
                        "numeric","numeric","numeric","numeric") 

worldPop <- tryCatch(read.csv(worldPopURL,colClasses = worldPopColClasses ),
                     error = function(e) {
                       message(paste("The error is:", e))
                       read.csv(worldPopFile,colClasses = worldPopColClasses )
                     }
                     )

