# CA2_1
library(igraph)

set.seed(2002)

g <- erdos.renyi.game(4, 0.5) # graph
num_of_vertices <- gorder(g)
num_of_edges <- gsize(g)
V(g)$name <- as.character(1:4)

## Some steiner nodes:
V(g)$prize <- sample(0:100, num_of_vertices)
E(g)$weight <- sample(1: 200, num_of_edges)
steiner.nodes <- V(g)[V(g)$prize > 0]$name
steiner.nodes
#E(g)$weight
#V(g)$prize
## Complete distance graph G'
new_Cost <- Inf
#?all_shortest_paths
?incident
?inc
all_distances <- distances(g)

all_distances
## Find a minimum spanning tree T' in G'
while(new_Cost < prev_Cost){
  Gi <- graph.full(num_of_vertices)
  V(Gi)$name <- steiner.nodes
  
  for (e in E(Gi)){
    print( (V(Gi)[get.edgelist(Gi)[e,][1]])$name )
    print( (V(Gi)[get.edgelist(Gi)[e,][2]])$name )
    print('kharoooo')
  }
  
  for(e in E(Gi)){
    end1 <- (V(Gi)[get.edgelist(Gi)[e,][1]])$name 
    end2 <- (V(Gi)[get.edgelist(Gi)[e,][2]])$name 
    E(Gi)[end1 %--% end2]$weight <- all_distances[end1, end2]
  }
  
  mst <- minimum.spanning.tree(Gi)
  edge_list <- get.edgelist(mst)
  
  Gs <- mst
  for (n in 1:nrow(edge_list)) {
    i <- edge_list[n,2]
    j <- edge_list[n,1]
    ##  If the edge of T' mst is shared by Gi, then remove the edge from T'
    ##    and replace with the shortest path between the nodes of g: 
    if (length(E(Gi)[which(V(mst)$name==i) %--% which(V(mst)$name==j)]) == 1) {
      ##  If edge is present then remove existing edge from the 
      ##    minimum spanning tree:
      Gs <- Gs - E(Gs)[which(V(mst)$name==i) %--% which(V(mst)$name==j)]
      
      ##  Next extract the sub-graph from g corresponding to the 
      ##    shortest path and union it with the mst graph:
      g_sub <- induced.subgraph(g, (get.shortest.paths(g, from=V(g)[i], to=V(g)[j])$vpath[[1]]))
      Gs <- graph.union(Gs, g_sub, byname=T)
    }
  }
  for(e in E(Gs)){
    end1 <- (V(Gs)[get.edgelist(Gi)[e,][1]])$name 
    end2 <- (V(Gs)[get.edgelist(Gi)[e,][2]])$name 
    E(Gs)[end1 %--% end2]$weight <- all_distances[end1, end2]
    
  }
  
  par(mfrow=c(1,2))
  plot(mst)
  plot(Gs)
}