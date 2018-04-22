# CA2_1
library(igraph)

set.seed(2018)

g <- erdos.renyi.game(15, 0.5)
plot(g)
num_of_vertices <- gorder(g)
num_of_edges <- gsize(g)
V(g)$name <- as.character(1:15)
V(g)$prize <- sample(0:200, num_of_vertices, replace = TRUE)
zeros <- sample(1:15, 5)
V(g)[intersect(V(g)$name , zeros)]$prize <- 0
E(g)$weight <- sample(1: 200, num_of_edges)
steiner.nodes <- V(g)[V(g)$prize > 0]$name
prev_Cost <- Inf
new_Cost <- sum(E(g)$weight)
all_distances <- distances(g)
#all_distances
#steiner.nodes

while(new_Cost < prev_Cost){
  prev_Cost <- new_Cost
  Gi <- graph.full(length(steiner.nodes))
  V(Gi)$name <- steiner.nodes

  for(e in E(Gi)){
    end1 <- (V(Gi)[get.edgelist(Gi)[e,][1]])$name 
    end2 <- (V(Gi)[get.edgelist(Gi)[e,][2]])$name 
    E(Gi)[end1 %--% end2]$weight <- all_distances[end1, end2]
  }
  plot(Gi, edge.label=E(Gi)$weight)
  
  mst <- minimum.spanning.tree(Gi)
  plot(mst, edge.label=E(Gi)$weight)
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
      g_sub <- induced.subgraph(g, (get.shortest.paths(g, from=V(g)[i], to=V(g)[j])$vpath[[1]]))
      Gs <- graph.union(Gs, g_sub, byname=T)
    }
  }
  #plot(Gs, vertex.label=V(Gs)$name)
  #V(Gs)$name
  for(e in E(Gs)){
    end1 <- (V(Gs)[get.edgelist(Gs)[e,][1]])$name 
    end2 <- (V(Gs)[get.edgelist(Gs)[e,][2]])$name 
    E(Gs)[end1 %--% end2]$weight <- all_distances[end1, end2]
    
  }
  
  steiner.nodes <- V(Gs)$name
  new_Cost <- sum(E(Gs)$weight)
  par(mfrow=c(1,2))
  #plot(mst)
  #plot(Gs, edge.label=E(Gs)$weight)
}

improve = TRUE
while(improve){
  improve = FALSE
  for(v in V(Gs)$name ){
    if(degree(Gs, which(V(Gs)$name==v)) == 1){
      if( incident(Gs, V(Gs)[which(V(Gs)$name==v )])$weight > V(g)[which(V(g)$name == v)]$prize ){
        Gs <-delete.vertices(Gs, which( (V(Gs)$name)==v ) )
        print('vertex deleted')
        improve = TRUE
        break
      }
    }
  }
}

plot(Gs, edge.label=E(Gs)$weight)
cat('Revenue = ')
cat(sum( V(g)[intersect(V(g), V(Gs))] $prize) - sum(E(Gs)$weight))      

