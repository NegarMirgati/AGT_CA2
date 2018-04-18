#CA1_2
install.packages("lsa")
library(igraph)
library(magrittr)
library(R2HTML)
library(lsa)

rm(list = ls())

g_net <- read.graph("/Users/Negar/Desktop/AGT_CA2/gnet.graphml", format = c("graphml"))
g_net_undir <- as.undirected(g_net, mode="collapse")
#is.directed(g_net_undir)
E(g_net_undir)$weight
E(g_net)$weight
## MY FUNCTIONS
#whichpart <- function(x, n=10) {
##  nx <- length(x)
##  p <- nx-n
##  xp <- sort(x, partial=p)[p]
##  which(x > xp)
#}

whichpart <- function(x, n = 10){
  tail( order(x), n )
}

# Density - The proportion of present edges from all possible edges in the network.
#directed_density <- ecount(g_net)/(vcount(g_net)*(vcount(g_net)-1))
#undirected_density <- edge_density(g_net)
#directed_density
#undirected_density

# Reciprocity - Directed
recip <- reciprocity(g_net)
recip
# Transitivity
##global : ratio of triangles (direction disregarded) to connected triples.
## Local : ratio of triangles to connected triples each vertex is part of.
global_trans <- transitivity(g_net, type ="undirected")
local_trans <- transitivity(g_net, type="local")
global_trans
max_10_local_trans <- whichpart(local_trans)
max_10_local_trans
# for directed graph
tri <- triad_census(g_net)

# Degree Centrality
dir_deg <- degree(g_net, mode="all")
undir_deg <- degree(g_net_undir) 
max_10_dir_degrees <- whichpart(dir_deg)
max_10_undir_degrees <- whichpart(undir_deg)


max_10_dir_degrees
max_10_undir_degrees 



# Betweenness
directed_btwnnss <- betweenness(g_net, directed=TRUE)
undirected_btwnnss <- betweenness(g_net_undir, directed=FALSE)
max_10_directedbtwnnss <- whichpart(directed_btwnnss)
max_10_undirectedbtwnnss <- whichpart(undirected_btwnnss)


max_10_directedbtwnnss
max_10_undirectedbtwnnss


# closeness
closeness_dir <- closeness(g_net, mode="all")
closeness_undir <- closeness(g_net_undir)
max_10_closeness_dir <- whichpart(closeness_dir)
max_10_closeness_undir <- whichpart(closeness_undir)


# Eigenvector Centrality

directed_eigen_list <- centr_eigen(g_net, directed = TRUE, scale = TRUE,
            options = arpack_defaults)$vector
undirected_eigen_list <- centr_eigen(g_net_undir, directed = FALSE, scale = TRUE,
                                   options = arpack_defaults)$vector

max_10_dir_eigenlist <- whichpart(directed_eigen_list)
max_10_undir_eigen_list <- whichpart(undirected_eigen_list)
max_10_dir_eigenlist
max_10_undir_eigen_list
###identical(directed_eigen_list, undirected_eigen_list)

# Page Rank
dir_pr <- page_rank(g_net, algo = c("prpack", "arpack", "power"), vids = V(g_net),
          directed = TRUE, damping = 0.85, personalized = NULL,
          options = NULL)$vector

undir_pr <- page_rank(g_net, algo = c("prpack", "arpack", "power"), vids = V(g_net),
                    directed = FALSE, damping = 0.85, personalized = NULL,
                    options = NULL)$vector
identical(dir_pr, undir_pr)
max_10_dir_pr <- whichpart(dir_pr)
max_10_undir_pr <- whichpart(undir_pr)
max_10_dir_pr
max_10_undir_pr

# Alpha-Centrality
alpha_dir <- alpha_centrality(g_net, nodes = V(g_net), alpha = 1,
                 exo = 1, sparse = TRUE)

alpha_undir <- alpha_centrality(g_net_undir, nodes = V(g_net_undir), alpha = 1,exo = 1, sparse = TRUE)

max_10_alpha_dir <- whichpart(alpha_dir)
max_10_alpha_undir <- whichpart(alpha_undir)
max_10_alpha_dir
max_10_alpha_undir

# Hubs and Authorities 
hub_score_dir <- hub_score(g_net)$vector
hub_score_undir <- hub_score(g_net_undir)$vector
max_10_hubscr_dir <- whichpart(hub_score_dir)
max_10_hubscr_undir <- whichpart(hub_score_undir)
max_10_hubscr_dir
max_10_hubscr_undir

# Authority Score
###
##The authority scores of the vertices are defined as the principal eigenvector of t(A)*A, ##where A is the adjacency matrix of the graph.
###
auth_score_dir <- authority_score(g_net, scale = TRUE, options = arpack_defaults)$vector
auth_score_undir <- authority_score(g_net_undir, scale = TRUE, options = arpack_defaults)$vector
max_10_auth_dir <- whichpart(auth_score_dir)
max_10_auth_undir <- whichpart(auth_score_undir)
max_10_auth_dir
max_10_auth_undir


# Power Centrality
pwr_cntr_dir <- power_centrality(g_net, nodes = V(g_net), exponent = 1,
                             rescale = FALSE)
pwr_cntr_undir <- power_centrality(g_net_undir, nodes = V(g_net_undir), exponent = 1,
                             rescale = FALSE)

max_10_pwr_cntr_dir <- whichpart(pwr_cntr_dir)
max_10_pwr_cntr_undir <- whichpart(pwr_cntr_undir)

max_10_pwr_cntr_dir
max_10_pwr_cntr_undir

# Subgraph Centrality
###Subgraph centrality of a vertex measures the number of subgraphs a vertex participates in, weighting them according to their size.
###

sub_cntr_dir <- subgraph_centrality(g_net, diag = FALSE)
sub_cntr_undir <- subgraph_centrality(g_net_undir, diag = FALSE)
max_10_sub_cntr_dir <- whichpart(sub_cntr_dir)
max_10_sub_cntr_undir <- whichpart(sub_cntr_undir)

max_10_sub_cntr_dir
max_10_sub_cntr_undir



#### HTML
html_file <- HTMLInitFile(outdir = "/Users/Negar/Desktop/AGT_CA2/", filename="output2",                                  extension="html",
                          HTMLframe=FALSE, BackGroundColor = "FFFFFF",Title = "R output", 
                          CSSFile="R2HTML.css", useLaTeX=TRUE, useGrid=TRUE)
html_code <- paste("<table border>
      <th>         </th>
                   <th>Top 10 nodes in directed graph </th>
                   <th>Top 10 nodes in undirected graph </th>
                   </tr>
                   <tr>
                   <td>Degree Centrality</td>", "</td><td>", 
                   paste( unlist(max_10_dir_degrees), collapse=", "), 
                   "<td>",
                   paste( unlist(max_10_undir_degrees), collapse=", "),
                  "</tr>
                  <tr>
                   <td>Betweenness Centrality</td>",
                  "</td><td>", 
                  paste( unlist(max_10_directedbtwnnss), collapse=", "), 
                  "<td>",
                  paste( unlist(max_10_undirectedbtwnnss), collapse=", "),
                  "</tr>
                  <tr> ",
                  "<td>Closeness Centrality</td>", "</td><td>", 
                  paste( unlist(max_10_closeness_dir), collapse=", "), 
                  "<td>",
                  paste( unlist(max_10_closeness_undir), collapse=", "),
                  "</tr>
                  <tr> 
                  <td>Eigenvector Centrality</td>",
                  "</td><td>",
                  paste( unlist(max_10_dir_eigenlist), collapse=", "), 
                  "<td>",
                  paste( unlist(max_10_undir_eigen_list), collapse=", "),
                  "</tr>
                  <tr> 
                  <td>Page Rank</td>",
                  "</td><td>",
                  paste( unlist(max_10_dir_pr), collapse=", "), 
                  "<td>",
                  paste( unlist(max_10_undir_pr), collapse=", "),
                  "</tr>
                  <tr> 
                  <td>Alpha Centrality</td>",
                  "</td><td>",
                  paste( unlist(max_10_alpha_dir), collapse=", "), 
                  "<td>",
                  paste( unlist(max_10_alpha_undir), collapse=", "),
                  "</tr>
                  <tr> 
                  <td>Authority Score</td>",
                  "</td><td>",
                  paste( unlist(max_10_auth_dir), collapse=", "), 
                  "<td>",
                  paste( unlist(max_10_auth_undir), collapse=", "),
                  "</tr>
                  <tr> 
                  <td>Power Centrality</td>",
                  "</td><td>",
                  paste( unlist(max_10_pwr_cntr_dir), collapse=", "), 
                  "<td>",
                  paste( unlist(max_10_pwr_cntr_undir), collapse=", "),
                  "</tr>
                  <tr> 
                  <td>Subgraph Centrality</td>",
                  "</td><td>",
                  paste( unlist(max_10_sub_cntr_dir), collapse=", "), 
                  "<td>",
                  paste( unlist(max_10_sub_cntr_undir), collapse=", "),
                  "</tr>
                  <tr> 
                  <td>Hub Score</td>",
                  "</td><td>",
                  paste( unlist(max_10_hubscr_dir), collapse=", "), 
                  "<td>",
                  paste( unlist(max_10_hubscr_undir), collapse=", "),
                   "</table>", sep="")

HTML(html_code,file= html_file)

########
got_net <- read.graph("/Users/Negar/Desktop/AGT_CA2/got.graphml", format = c("graphml"))

coords = layout_with_fr(got_net)
par(mfrow=c(1,2), cex=.50)
# plot the graph
plot(got_net, layout=layout_on_grid, vertex.size=20, vertex.label=V(got_net)$name,
     edge.color="black", vertex.color = "yellow")

# greedy method (hiearchical, fast method)
c1 = cluster_fast_greedy(got_net)
plot(c1, got_net, layout=coords, edge.arrow.size = 0)
plot(got_net, vertex.color=membership(c1), layout=coords, edge.arrow.size = 0)

###Spectral community detection

c2 <- cluster_leading_eigen(got_net, options=list(maxiter=1000000))
plot(c2, got_net, layout=coords, edge.arrow.size = 0)
plot(got_net, vertex.color=membership(c2), layout=coords, edge.arrow.size = 0)

###Betweenness community detection

c3 = cluster_edge_betweenness(got_net)

# plot communities with shaded regions
plot(c3, got_net, layout=coords)
# plot communities without shaded regions
plot(got_net, vertex.color=membership(c3), layout=coords)


### Hierarchical clustering

A = get.adjacency(got_net, sparse=FALSE)

# cosine similarity
S = cosine(A)

# distance matrix
D = 1-S

# distance object
d = as.dist(D)

# average-linkage clustering method
cc = hclust(d, method = "average")

# plot dendrogram
plot(cc)

# draw blue borders around clusters
clusters.list = rect.hclust(cc, k = 4, border="blue")

# cut dendrogram at 4 clusters
clusters = cutree(cc, k = 4)

# plot graph with clusters
plot(got_net, vertex.color=clusters, layout=coords, edge.arrow.size=0)


# Pearson similarity
S = cor(A, method="pearson")

# distance matrix
D = 1-S

# distance object
d = as.dist(D)

# average-linkage clustering method
cc = hclust(d, method = "average")

# plot dendrogram
plot(cc)

# draw blue borders around clusters
clusters.list = rect.hclust(cc, k = 4, border="blue")

# cut dendrogram at 4 clusters
clusters = cutree(cc, k = 4)

# plot graph with clusters
plot(got_net, vertex.color=clusters, layout=coords, edge.arrow.size=0)

# global similarity
I = diag(1, vcount(got_net));

# leading eigenvalue
l = eigen(A)$values[1]

# 85% of leading eigenvalue
alpha = 0.85 * 1/l

# similarity matrix
S = solve(I - alpha * A)

# largest value
max = max(as.vector(S))

# distance matrix
D = max-S

# set null distance from a node to itself
d = diag(D)
D = D + diag(-d, vcount(got_net))


# distance object
d = as.dist(D)

# average-linkage clustering method
cc = hclust(d, method = "average")

# plot dendrogram
plot(cc)

# draw blue borders around clusters
clusters.list = rect.hclust(cc, k = 4, border="blue")

# cut dendrogram 
clusters = cutree(cc, k = 4)

# plot graph with clusters
plot(got_net, vertex.color=clusters, layout=coords, edge.arrow.size=0)

# Optimal community detection
c4 = cluster_optimal(got_net)

# plot communities with shaded regions
plot(c4, got_net, layout=coords)

# plot communities without shaded regions
plot(got_net, vertex.color=membership(c4), layout=coords, edge.arrow.size=0)

# greedy performance
round(modularity(c1) / modularity(c4),3)

# spectral performance
round(modularity(c2) / modularity(c4),3)

# betweenness performance
round(modularity(c3) / modularity(c4),3)
