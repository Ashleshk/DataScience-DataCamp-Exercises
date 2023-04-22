# Challenge: Use SQL to generate a report on R data
# Difficulty: 3

# apply an SQL statement against an R data.frame
# use worldPop
# determine the Male and Female population as % of total population
# only use the year 2020, variant = median
# and remove missing data
# sort by the female percentage

# install.packages("sqldf")
library(sqldf)

load("/Users/ashleshkhajbage/Documents/R_Data_Sci_Code_Challenges/Exercise Files/RCodeChallenge.rda")

doThisSQL <- "select Location,
                     round(PopMale/PopTotal*100) as Male_Percent,
                     round(PopFemale/PopTotal*100) as Female_Percent 
               from worldPop
               where Variant is 'Medium'
               and Time = 2020
               and PopMale IS NOT NULL
               and PopFemale IS NOT NULL
               order by Female_Percent"

resultSQLDF <- sqldf(doThisSQL)
