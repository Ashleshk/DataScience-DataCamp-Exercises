# Challenge: Join two datasets on a common variable.
# Difficulty: 2

# load survey data
load(file = "RCodeChallenge.rda")

# combine Acme Data
acmeData <- merge(x = AcmeData_Demographic,
                  y = AcmeData_Survey,
                  by = "surveyID")

# map Star Research columns to acmeData
names(StarResearch) <- c("firstName", "surveyID","Income","houseColor","Age")
StarResearch <- StarResearch[ , names(acmeData)]

# combine Acme & Star
allTheData <- rbind(acmeData, StarResearch)

# brief report
plot(x = allTheData$Age, y = allTheData$Income, col = allTheData$houseColor)

# extra credit - box plot
allTheData$houseColor <- factor(allTheData$houseColor)
plot(x = allTheData$houseColor, y = allTheData$Income)

