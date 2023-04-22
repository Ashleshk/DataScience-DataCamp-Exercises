# Challenge: Use R's subsetting operators to trim out unnecessary data
# Difficulty: 1

# retrieve world population data
load(file = "RCodeChallenge.rda")

# for one selected year, 
# ...which countries have population densities > median
# Use the "Medium" variant
# Return location and popDensity

# select those countries
finalData <- worldPop[ worldPop$Time == 2021 & 
                   worldPop$PopDensity > median(worldPop$PopDensity) &
                   worldPop$Variant == "Medium",
                 c("Location", "PopDensity") ]
