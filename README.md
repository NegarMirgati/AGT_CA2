# AGT_CA2

# Similarity igraph methods used
```
 similarity(got_net, method = "dice")
 similarity(got_net, method = "jaccard")
 similarity(got_net, method = "invlogweighted")
```

# Vertex Clustering Tutorial and Methods used
https://users.dimi.uniud.it/~massimo.franceschet/R/communities.html

# Random Walk Closeness Centrality
https://en.wikipedia.org/wiki/Random_walk_closeness_centrality

Random walk closeness centrality is a measure of centrality in a network, which describes the average speed with which randomly walking processes reach a node from other nodes of the network. It is similar to the closeness centrality except that the farness is measured by the expected length of a random walk rather than by the shortest path.
The concept was first proposed by Noh and Rieger (2004).

Consider a network with a finite number of nodes and a random walk process that starts in a certain node and proceeds from node to node along the edges. From each node, it chooses randomly the edge to be followed. In an unweighted network, the probability of choosing a certain edge is equal across all available edges, while in a weighted network it is proportional to the edge weights. A node is considered to be close to other nodes, if the random walk process initiated from any node of the network arrives to this particular node in relatively few steps on average.
Random Walk Closeness Centrality for Node i :
![alt text](https://wikimedia.org/api/rest_v1/media/math/render/svg/48f834d0fc3024f0908945384790079e08234b60)
Where H is :
![alt text](https://wikimedia.org/api/rest_v1/media/math/render/svg/0d47d947b6e2961a31a55781b35ca5a6a34f408a)



