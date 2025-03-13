install.packages("dendextend")
install.packages("cluster")

# Import packages
library(readr)
library(dendextend)
library(tibble)
library(dplyr)
library(purrr)
library(cluster)
library(ggplot2)
library(tidyverse)

nba = read.csv("D:/R Project/nba_players_2023.csv")
head(nba)

nba['pra_per_game']= nba['rebounds_per_game']+nba['assists_per_game']+nba['points_per_game']
head(nba)

# Set row names manually and remove the column
rownames(nba) = nba$name
nba$name = NULL
head(nba)

nban=scale(nba)
head(nban)

# Define a function to compute WSS for a given number of clusters
compute_wss = function(k) {
  kmeans_result = kmeans(nban, centers = k, nstart = 10)  # Run k-means
  return(kmeans_result$tot.withinss)  # Extract total within-cluster sum of squares
}


# Compute WSS for k = 1 to 10
k_values = 1:10
wss_values = numeric(length(k_values))  # Initialize an empty numeric vector

for (i in seq_along(k_values)) {
  wss_values[i] = compute_wss(k_values[i])  # Compute WSS for each k
}

# Print WSS values
print(wss_values)


# Create a data frame for visualization
wss_df = data.frame(k = k_values, WSS = wss_values)

# Plot the Elbow Curve
ggplot(wss_df, aes(x = k, y = WSS)) +
  geom_line() +
  geom_point() +
  ggtitle("Elbow Method for Optimal Clusters") +
  xlab("Number of Clusters (k)") +
  ylab("Within-Cluster Sum of Squares (WSS)") +
  theme_minimal()

#optimal number of cluster from the elbow method
num_clusters=2

# Compute Euclidean distance (excluding the Player column)
distance_matrix = dist(nban, method = "euclidean")

# Print the distance matrix
print(distance_matrix)


# Apply hierarchical clustering using complete linkage
hclust_result = hclust(distance_matrix, method = "average")

# Print the result
print(hclust_result)


# Convert the result to a dendrogram
dend = as.dendrogram(hclust_result)

# Define the number of clusters
num_clusters = 2  # Change this number based on desired clusters

# Color branches according to the number of clusters
colored_dend = color_branches(dend, k = num_clusters)

# Plot the colored dendrogram
plot(colored_dend, main = "Hierarchical Clustering of Players with Colored Branches")


# Add labels to indicate cluster assignments
player_clusters = cutree(hclust_result, k = num_clusters)

# Print cluster assignments for each player
print(player_clusters)



nba['label']=player_clusters
nba

# Summarize statistics for each variable by cluster
cluster_summary = nba %>%
  group_by(label) %>%
  summarise(
    age_Mean = mean(age), age_SD = sd(age), age_Median = median(age),
    age_Min = min(age), age_Max = max(age),
    
    minutes_played_per_game_Mean = mean(minutes_played_per_game), minutes_played_per_game_SD =           sd(minutes_played_per_game), minutes_played_per_game_Median = median(minutes_played_per_game),
    minutes_played_per_game_Min = min(minutes_played_per_game), minutes_played_per_game_Max = max(minutes_played_per_game),
    
    rebounds_per_game_mean = mean( rebounds_per_game),  rebounds_per_game_SD = sd( rebounds_per_game),  rebounds_per_game_Median = median( rebounds_per_game),
    rebounds_per_game_Min = min( rebounds_per_game),  rebounds_per_game_Max = max( rebounds_per_game),
    
    assists_per_game_Mean = mean(assists_per_game), assists_per_game_SD = sd(assists_per_game), assists_per_game_Median = median(assists_per_game),
    assists_per_game_Min = min(assists_per_game), assists_per_game_Max = max(assists_per_game),
    
    points_per_game_Mean = mean(points_per_game), points_per_game_SD = sd(points_per_game), points_per_game_Median = median(points_per_game),
    points_per_game_Min = min(points_per_game), points_per_game_Max = max(points_per_game),
    
    pra_per_game_Mean = mean(pra_per_game), pra_per_game_SD = sd(pra_per_game), pra_per_game_Median = median(pra_per_game),
    pra_per_game_Min = min(pra_per_game), pra_per_game_Max = max(pra_per_game)
  )

# Print the summary statistics
print(cluster_summary)



# Summarize statistics for each variable by cluster
cluster_ranges = nba %>%
  group_by(label) %>%
  summarise(
    age_Min = min(age), age_Max = max(age),
    
    minutes_played_per_game_Min = min(minutes_played_per_game), minutes_played_per_game_Max =    max(minutes_played_per_game),
    
    rebounds_per_game_Min = min( rebounds_per_game),  rebounds_per_game_Max = max( rebounds_per_game),
    
    assists_per_game_Min = min(assists_per_game), assists_per_game_Max = max(assists_per_game),
    
    points_per_game_Min = min(points_per_game), points_per_game_Max = max(points_per_game),
    
    pra_per_game_Min = min(pra_per_game), pra_per_game_Max = max(pra_per_game)
  )

# Print the summary statistics
cluster_ranges

strongest_influence=c('points_per_game','pra_per_game','minutes_played_per_game')

print(strongest_influence)








