# CA2_2 Random Walk Centrality
library(igraph)
gnet <- read.graph("/Users/Negar/Desktop/AGT_CA2/gnet.graphml", format = c("graphml"))
num_of_vertices <- gorder(gnet)
gnet_adj_mat <- as_adjacency_matrix(gnet, attr="weight")
transition_matrix <- matrix(0, nrow = num_of_vertices, ncol = num_of_vertices)
rowsum_adj_mat <- matrix(0, nrow = num_of_vertices, ncol = 1)

#for (row in 1 : nrow(gnet_adj_mat)){
# rowsum_adj_mat[row] <- sum(gnet_adj_mat[row,])
#}
rowsum_adj_mat <- apply(gnet_adj_mat, 1, function(x) sum(x))

for(row in 1 : nrow(transition_matrix)){
  for (column in 1 : ncol(transition_matrix)){
    # M(i,j) = aij / sigma(aij), 1<=j<=n
    transition_matrix[row, column] <- gnet_adj_mat [row, column] / rowsum_adj_mat[row]
  }
  #print(row)
}

mean_firs_passage_t <- matrix(Inf, nrow = num_of_vertices - 1, ncol = num_of_vertices ) #-1
I <- diag(num_of_vertices - 1)
e <- matrix(1, nrow = num_of_vertices - 1, ncol = 1) # -1

for (j in 1 : ncol(mean_firs_passage_t)){
  mean_firs_passage_t[,j] <- solve(I - transition_matrix[-j:-j,-j:-j]) %*% e
  #print(j)
}

RWC <- matrix(0, nrow = 1, ncol = num_of_vertices)
RWC <- apply(mean_firs_passage_t, 2, function(x) num_of_vertices / sum(x))

#for(i in 1 : ncol(RWC)){
  #print(i)
 # RWC[1,i] <- num_of_vertices / sum(mean_firs_passage_t[,i])
#}

max_10_closeness <- whichpart(RWC)
max_10_closeness
