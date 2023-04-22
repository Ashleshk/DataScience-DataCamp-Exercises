# Challenge: Import two pages from an Excel spreadsheet and decode a message
# Difficulty: 3

# Import two pages from a "secretCode.xlsx"
# Page one is a list of words
# page two is the encoded message. Each row is an index (R,C) to the list of words
# You need to import the sheets, then decode the message

# get the secret code -------------------------------------------------------------

library(readxl)

randomWords <- as.data.frame(read_excel("secretCode.xlsx", sheet = "words", col_names = FALSE))

codeString <- as.data.frame(read_excel("secretCode.xlsx", sheet = "secretCode", col_names = FALSE))

# here's the code to retrieve the secret words
getWord <- function(x) {randomWords[x[1],x[2]]}

apply(codeString, 1, getWord)

  
