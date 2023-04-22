# Challenge: Use clustering to find hidden relationships
# Difficulty: 3

# Use Star Research data
# Compare Income against Age
# Show the clusters in a graph

# load survey data
load(file = "RCodeChallenge.rda")

clusterThis <- StarResearch[ , c("Income","age")]

clusterThis <- scale(clusterThis)

SRclusters <- kmeans(clusterThis, 8)

plot(x = StarResearch$age, y = StarResearch$Income, 
     col = SRclusters$cluster)

