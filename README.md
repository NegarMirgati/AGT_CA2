# AGT_CA2

# Centralities 
*Hubs and Authorities : https://nlp.stanford.edu/IR-book/html/htmledition/hubs-and-authorities-1.html  
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
The Jaccard similarity coefficient of two vertices is the number of common neighbors divided by the number of vertices that are neighbors of at least one of the two vertices being considered. The jaccard method calculates the pairwise Jaccard similarities for some (or all) of the vertices.

The Dice similarity coefficient of two vertices is twice the number of common neighbors divided by the sum of the degrees of the vertices. Methof dice calculates the pairwise Dice similarities for some (or all) of the vertices.

The inverse log-weighted similarity of two vertices is the number of their common neighbors, weighted by the inverse logarithm of their degrees. It is based on the assumption that two vertices should be considered more similar if they share a low-degree common neighbor, since high-degree common neighbors are more likely to appear even by pure chance. Isolated vertices will have zero similarity to any other vertex. Self-similarities are not calculated.

# Vertex Clustering Tutorial and Methods used
https://users.dimi.uniud.it/~massimo.franceschet/R/communities.html

Edge Betweenness:  
The edge betweenness score of an edge measures the number of shortest paths through it, see edge_betweenness for details. The idea of the edge betweenness based community structure detection is that it is likely that edges connecting separate modules have high edge betweenness as all the shortest paths from one module to another must traverse through them. So if we gradually remove the edge with the highest edge betweenness score we will get a hierarchical map, a rooted tree, called a dendrogram of the graph. The leafs of the tree are the individual vertices and the root of the tree represents the whole graph.

cluster_edge_betweenness performs this algorithm by calculating the edge betweenness of the graph, removing the edge with the highest edge betweenness score, then recalculating edge betweenness of the edges and again removing the one with the highest score, etc.  

Cluster Walktrap:  
The idea is that short random walks tend to stay in the same community.  

Cluster Spinglass:  
This function tries to find communities in a graph. A community is a set of nodes with many edges inside the community and few edges between outside it (i.e. between the community itself and the rest of the graph.)

This idea is reversed for edges having a negative weight, ie. few negative edges inside a community and many negative edges between communities. Note that only the ‘neg’ implementation supports negative edge weights.

The spinglass.cummunity function can solve two problems related to community detection. If the vertex argument is not given (or it is NULL), then the regular community detection problem is solved (approximately), i.e. partitioning the vertices into communities, by optimizing the an energy function.

If the vertex argument is given and it is not NULL, then it must be a vertex id, and the same energy function is used to find the community of the the given vertex. See also the examples below.  

Cluster leading Eigen:  
The function documented in these section implements the ‘leading eigenvector’ method developed by Mark Newman, see the reference below.

The heart of the method is the definition of the modularity matrix, B, which is B=A-P, A being the adjacency matrix of the (undirected) network, and P contains the probability that certain edges are present according to the ‘configuration model’. In other words, a P[i,j] element of P is the probability that there is an edge between vertices i and j in a random network in which the degrees of all vertices are the same as in the input graph.

The leading eigenvector method works by calculating the eigenvector of the modularity matrix for the largest positive eigenvalue and then separating vertices into two community based on the sign of the corresponding element in the eigenvector. If all elements in the eigenvector are of the same sign that means that the network has no underlying comuunity structure.  

Cluster_label_prop:  
This is a fast, nearly linear time algorithm for detecting community structure in networks. In works by labeling the vertices with unique labels and then updating the labels by majority voting in the neighborhood of the vertex.  

Cluster Louvain:  
This function implements the multi-level modularity optimization algorithm for finding community structure, see VD Blondel, J-L Guillaume, R Lambiotte and E Lefebvre: Fast unfolding of community hierarchies in large networks, http://arxiv.org/abs/arXiv:0803.0476 for the details.

Optimal Community:  
This function calculates the optimal community structure for a graph, in terms of maximal modularity score.  


It is based on the modularity measure and a hierarchial approach. Initially, each vertex is assigned to a community on its own. In every step, vertices are re-assigned to communities in a local, greedy way: each vertex is moved to the community with which it achieves the highest contribution to modularity. When no vertices can be reassigned, each community is considered a vertex on its own, and the process starts again with the merged communities. The process stops when there is only a single vertex left or when the modularity cannot be increased any more in a step. 

# Random Walk Closeness Centrality
https://en.wikipedia.org/wiki/Random_walk_closeness_centrality

Random walk closeness centrality is a measure of centrality in a network, which describes the average speed with which randomly walking processes reach a node from other nodes of the network. It is similar to the closeness centrality except that the farness is measured by the expected length of a random walk rather than by the shortest path.
The concept was first proposed by Noh and Rieger (2004).

Consider a network with a finite number of nodes and a random walk process that starts in a certain node and proceeds from node to node along the edges. From each node, it chooses randomly the edge to be followed. In an unweighted network, the probability of choosing a certain edge is equal across all available edges, while in a weighted network it is proportional to the edge weights. A node is considered to be close to other nodes, if the random walk process initiated from any node of the network arrives to this particular node in relatively few steps on average.
Random Walk Closeness Centrality for Node i :
![alt text](https://wikimedia.org/api/rest_v1/media/math/render/svg/48f834d0fc3024f0908945384790079e08234b60)
Where H is :
![alt text](https://wikimedia.org/api/rest_v1/media/math/render/svg/0d47d947b6e2961a31a55781b35ca5a6a34f408a)



