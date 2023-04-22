# Challenge: Import a remote database
# Difficulty: 1

# import the United Nations world population database
# all fields should be integer or numeric
# except variant = factor, location = character


worldPop <- read.csv("https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_TotalPopulationBySex.csv",
                     colClasses = c("integer","character","integer", "factor", "integer", "numeric","numeric","numeric","numeric","numeric"))


# alternate
library(readr)
WPP2019_TotalPopulationBySex <- read_csv("https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_TotalPopulationBySex.csv",
                                         col_types = "icifnnnnnn")
