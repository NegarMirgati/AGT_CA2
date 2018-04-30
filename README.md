# AGT_CA2

# Centralities 
*Hubs and Authorities
We now develop a scheme in which, given a query, every web page is assigned two scores. One is called its hub score and the other its authority score . For any query, we compute two ranked lists of results rather than one. The ranking of one list is induced by the hub scores and that of the other by the authority scores.
This approach stems from a particular insight into the creation of web pages, that there are two primary kinds of web pages useful as results for broad-topic searches. By a broad topic search we mean an informational query such as "I wish to learn about leukemia". There are authoritative sources of information on the topic; in this case, the National Cancer Institute's page on leukemia would be such a page. We will call such pages authorities; in the computation we are about to describe, they are the pages that will emerge with high authority scores.

On the other hand, there are many pages on the Web that are hand-compiled lists of links to authoritative web pages on a specific topic. These hub pages are not in themselves authoritative sources of topic-specific information, but rather compilations that someone with an interest in the topic has spent time putting together. The approach we will take, then, is to use these hub pages to discover the authority pages. In the computation we now develop, these hub pages are the pages that will emerge with high hub scores.

A good hub page is one that points to many good authorities; a good authority page is one that is pointed to by many good hub pages. We thus appear to have a circular definition of hubs and authorities; we will turn this into an iterative computation.

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



