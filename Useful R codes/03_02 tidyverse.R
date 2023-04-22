# Challenge: Use Tidyverse syntax to rewrite the SQL challenge
# Difficulty: 4

# use worldPop
# determine the Male and Female population as % of total population
# only use the year 2020, variant = median
# and remove missing data
# sort by the female percentage

load("/Users/ashleshkhajbage/Documents/R_Data_Sci_Code_Challenges/Exercise Files/RCodeChallenge.rda")

# install.packages("tidyverse")
library(tidyverse)

sortedWorldPop <- worldPop |> 
  drop_na() |>
  filter(Time == 2020) |>
  filter(Variant %in% "Medium") |>
  mutate(Male_Percent = round(PopMale/PopTotal*100)) |>
  mutate(Female_Percent = round(PopFemale/PopTotal*100)) |>
  arrange(Female_Percent) |>
  select(c(Location,Male_Percent , Female_Percent))


