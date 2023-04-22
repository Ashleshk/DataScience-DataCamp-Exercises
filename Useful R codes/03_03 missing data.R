# Challenge: restore missing data in the World Population Database
# Difficulty: 3

load("RCodeChallenge.rda")

# how many rows aren't complete
sum(!complete.cases(worldPop))

# show which columns aren't complete
colSums(is.na(worldPop))

# show sample of which rows aren't complete
head(worldPop[!complete.cases(worldPop),])

# fill in missing data ----------------
# install.packages("VIM")
library(VIM)

missWorldPop <- aggr(worldPop)
imputedWorldPop <- hotdeck(worldPop, c("PopMale","PopFemale"))

# confirm VIM replaced missing data
missWorldPop <- aggr(imputedWorldPop)
colSums(is.na(imputedWorldPop))

