#CA1_2
library(igraph)
library(htmlTable)
rm(list = ls())
got_net <- read.graph("/Users/Negar/Desktop/AGT_CA2/gnet.graphml", format = c("graphml"))

?read.graph
## MY FUNCTIONS
whichpart <- function(x, n=10) {
  which(x >= -sort(-x, partial=n)[n])
}
# Density - The proportion of present edges from all possible edges in the network.
directed_density <- ecount(got_net)/(vcount(got_net)*(vcount(got_net)-1))
undirected_density <- edge_density(got_net)
directed_density
undirected_density

# Reciprocity - Directed
recip <- reciprocity(got_net)
recip
# Transitivity
##global : ratio of triangles (direction disregarded) to connected triples.
## Local : ratio of triangles to connected triples each vertex is part of.
global_trans <- transitivity(got_net, type ="undirected")
local_trans <- transitivity(got_net, type="local")
global_trans
max_10_local_trans <- whichpart(local_trans)
max_10_local_trans
# for directed graph
tri <- triad_census(got_net)

# Degree Centrality
all_deg <- degree(got_net, mode="all")
in_deg <- degree(got_net, mode="in") 
out_deg <- degree(got_net, mode="out") 
max_10_degrees <- whichpart(all_deg)
max_10_indegrees <- whichpart(in_deg)
max_10_outdegrees <- whichpart(out_deg)

max_10_degrees
max_10_indegrees 
max_10_outdegrees


# Betweenness
directed_btwnnss <- betweenness(got_net, directed=TRUE, weights=NA)
undirected_btwnnss <- betweenness(got_net, directed=FALSE, weights=NA)
max_10_directedbtwnnss <- whichpart(directed_btwnnss)
max_10_undirectedbtwnnss <- whichpart(undirected_btwnnss)
max_10_directedbtwnnss
max_10_undirectedbtwnnss

# Diameter
diameter(got_net, directed=F)
diameter(got_net, directed=T)

# closeness
closeness_list <- closeness(got_net, mode="all")
max_10_closeness <- whichpart(closeness_list)
max_10_closeness

# Eigenvector Centrality
directed_eigen_list <- centr_eigen(got_net, directed = TRUE, scale = TRUE,
            options = arpack_defaults, normalized = TRUE)$vector
undirected_eigen_list <- centr_eigen(got_net, directed = FALSE, scale = TRUE,
                                   options = arpack_defaults, normalized = TRUE)$vector

directed_eigen_list 
undirected_eigen_list

# Page Rank
dir_pr <- page_rank(got_net, algo = c("prpack", "arpack", "power"), vids = V(got_net),
          directed = TRUE, damping = 0.85, personalized = NULL, weights = NULL,
          options = NULL)$vector

undir_pr <- page_rank(got_net, algo = c("prpack", "arpack", "power"), vids = V(got_net),
                    directed = FALSE, damping = 0.85, personalized = NULL, weights = NULL,
                    options = NULL)$vector
# Alpha-Centrality
alpha_list <- alpha_centrality(got_net, nodes = V(got_net), alpha = 1, loops = FALSE,
                 exo = 1, weights = NULL, tol = 1e-07, sparse = TRUE)
alpha <- alpha.centrality(got_net)

# Hubs and Authorities 
hs <- hub_score(got_net, weights=NA)$vector
as <- authority_score(got_net, weights=NA)$vector

#
