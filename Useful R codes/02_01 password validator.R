# Challenge: Diagnose a list of passwords
# Difficulty: 3

# given a vector containing values that look like passwords
# ...confirm each element of the vector is a valid password
# ...save the invalid passwords with a diagnostic message into a data.frame

# a valid password has:
# more than 10 characters
# at least one lowercase letter
# at least one uppercase letter
# at least one number
# at least one punctuation character

# load survey data
load(file = "RCodeChallenge.rda")

# Environment now has three files
# note that surveyID and Identifier look like valid passwords
testThesePasswords <- AcmeData_Demographic$surveyID

diagnosePassword <- function(aPassword) {
  return(c(length = nchar(aPassword) > 10,
           lowercase = grepl(pattern = "[[:lower:]]", x = aPassword ),
           uppercase = grepl(pattern = "[[:upper:]]", x = aPassword ),
           number = grepl(pattern = "[[:digit:]]", x = aPassword ),
           punctuation = grepl(pattern = "[[:punct:]]", x = aPassword ) 
           ) )
 
}

for (aPassword in testThesePasswords) {
  passwordTest <- diagnosePassword(aPassword)
  if (! all(passwordTest)) {
    if (exists("passwordTestResults")) {
      newRow <- c(aPassword,passwordTest)
      passwordTestResults <- rbind(passwordTestResults,newRow)
    } else {
      passwordTestResults <- data.frame(password = aPassword,
                                        length = passwordTest["length"],
                                        lowercase = passwordTest["lowercase"],
                                        uppercase = passwordTest["uppercase"],
                                        number = passwordTest["number"],
                                        punctuation = passwordTest["punctuation"],
                                        row.names = NULL)
    }

  }
}

