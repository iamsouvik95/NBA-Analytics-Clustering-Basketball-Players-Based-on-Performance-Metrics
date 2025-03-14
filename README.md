# NBA-Analytics-Clustering-Basketball-Players-Based-on-Performance-Metrics using R
This project explores NBA player performance analytics through K-Means Clustering, hierarchical clustering, leveraging Tidyverse functions and data visualization to uncover patterns among players based on key metrics. Using the nba_players_2023.csv dataset, which includes season statistics for 50 players, we aim to identify distinct player groupings and key attributes influencing cluster formation.

![a-logo-for-the-r-project-nba-analytics-c_ds7pW3QFS727VyvaIGRLSA__iDzjJKzQkOMKHpyBq56Ig](https://github.com/user-attachments/assets/ba9e2d7d-888c-4b1c-99aa-f5140c4da7c4)



Key objectives include:

(i).Calculating combined per-game stats for points, rebounds, and assists.
(ii).Determining the optimal number of clusters (num_clusters).
(iii).Identifying the most influential performance metrics (strongest_influence) that best separate clusters.

Using K-means clustering and the elbow method, the plot clearly indicates that the optimal number of clusters is two.

![image](https://github.com/user-attachments/assets/8934a3cb-2924-4645-8355-d5ce6acb1999)

Now, we will apply hierarchical clustering, which has produced the following dendrogram. By analyzing the structure of the dendrogram, it is evident that the dataset naturally groups into two distinct clusters, reinforcing the findings from the K-means clustering and elbow method. This further validates the optimal number of clusters in our analysis.

![image](https://github.com/user-attachments/assets/e3e8ee0e-e6e1-4cdc-8845-cfa3544947b9)

To identify the key performance metrics that most clearly distinguish the clusters, we will analyze the six numeric columns and assign the most influential ones to the strongest_influence object as a vector of strings.

To achieve this, we will compute the cluster-wise minimum and maximum range for each variable. If there is no overlap between clusters for a given feature, it strongly indicates its role in differentiating player groups.

Additionally, we will summarize each variable for each cluster by calculating key statistics, including mean, standard deviation, median, minimum, and maximum. This analysis will help us determine the features that have the strongest influence on cluster separation.

After analysis, we identified three key metrics that have the strongest influence in distinguishing clusters:

1.points_per_game
2.pra_per_game (points + rebounds + assists per game)
3.minutes_played_per_game

Conclusion

In this project, we applied K-means and hierarchical clustering to group NBA players based on their performance metrics. The elbow method and dendrogram confirmed that the optimal number of clusters is two. We then analyzed cluster-wise statistics to determine the most influential features, identifying points per game, PRA per game, and minutes played per game as the key differentiators. This clustering analysis provides valuable insights into player categorization, aiding in scouting, strategy, and performance evaluation.
