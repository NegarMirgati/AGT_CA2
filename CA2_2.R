#CA1_2

library(igraph)
library(magrittr)
library(R2HTML)
rm(list = ls())

got_net <- read.graph("/Users/Negar/Desktop/AGT_CA2/gnet.graphml", format = c("graphml"))
got_net_undir <- as.undirected(got_net, mode="collapse")
#is.directed(got_net_undir)
E(got_net_undir)$weight
E(got_net)$weight
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
#directed_density <- ecount(got_net)/(vcount(got_net)*(vcount(got_net)-1))
#undirected_density <- edge_density(got_net)
#directed_density
#undirected_density

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
dir_deg <- degree(got_net, mode="all")
undir_deg <- degree(got_net_undir) 
max_10_dir_degrees <- whichpart(dir_deg)
max_10_undir_degrees <- whichpart(undir_deg)


max_10_dir_degrees
max_10_undir_degrees 



# Betweenness
directed_btwnnss <- betweenness(got_net, directed=TRUE)
undirected_btwnnss <- betweenness(got_net_undir, directed=FALSE)
max_10_directedbtwnnss <- whichpart(directed_btwnnss)
max_10_undirectedbtwnnss <- whichpart(undirected_btwnnss)


max_10_directedbtwnnss
max_10_undirectedbtwnnss


# closeness
closeness_dir <- closeness(got_net, mode="all")
closeness_undir <- closeness(got_net_undir)
max_10_closeness_dir <- whichpart(closeness_dir)
max_10_closeness_undir <- whichpart(closeness_undir)


# Eigenvector Centrality

directed_eigen_list <- centr_eigen(got_net, directed = TRUE, scale = TRUE,
            options = arpack_defaults)$vector
undirected_eigen_list <- centr_eigen(got_net_undir, directed = FALSE, scale = TRUE,
                                   options = arpack_defaults)$vector

max_10_dir_eigenlist <- whichpart(directed_eigen_list)
max_10_undir_eigen_list <- whichpart(undirected_eigen_list)
max_10_dir_eigenlist
max_10_undir_eigen_list
###identical(directed_eigen_list, undirected_eigen_list)

# Page Rank
dir_pr <- page_rank(got_net, algo = c("prpack", "arpack", "power"), vids = V(got_net),
          directed = TRUE, damping = 0.85, personalized = NULL,
          options = NULL)$vector

undir_pr <- page_rank(got_net, algo = c("prpack", "arpack", "power"), vids = V(got_net),
                    directed = FALSE, damping = 0.85, personalized = NULL,
                    options = NULL)$vector
identical(dir_pr, undir_pr)
max_10_dir_pr <- whichpart(dir_pr)
max_10_undir_pr <- whichpart(undir_pr)
max_10_dir_pr
max_10_undir_pr

# Alpha-Centrality
alpha_dir <- alpha_centrality(got_net, nodes = V(got_net), alpha = 1,
                 exo = 1, sparse = TRUE)

alpha_undir <- alpha_centrality(got_net_undir, nodes = V(got_net_undir), alpha = 1,exo = 1, sparse = TRUE)

max_10_alpha_dir <- whichpart(alpha_dir)
max_10_alpha_undir <- whichpart(alpha_undir)
max_10_alpha_dir
max_10_alpha_undir

# Hubs and Authorities 
hub_score_dir <- hub_score(got_net)$vector
hub_score_undir <- hub_score(got_net_undir)$vector
max_10_hubscr_dir <- whichpart(hub_score_dir)
max_10_hubscr_undir <- whichpart(hub_score_undir)
max_10_hubscr_dir
max_10_hubscr_undir

# Authority Score
###
##The authority scores of the vertices are defined as the principal eigenvector of t(A)*A, ##where A is the adjacency matrix of the graph.
###
auth_score_dir <- authority_score(got_net, scale = TRUE, options = arpack_defaults)$vector
auth_score_undir <- authority_score(got_net_undir, scale = TRUE, options = arpack_defaults)$vector
max_10_auth_dir <- whichpart(auth_score_dir)
max_10_auth_undir <- whichpart(auth_score_undir)
max_10_auth_dir
max_10_auth_undir


# Power Centrality
pwr_cntr_dir <- power_centrality(got_net, nodes = V(got_net), exponent = 1,
                             rescale = FALSE)
pwr_cntr_undir <- power_centrality(got_net_undir, nodes = V(got_net_undir), exponent = 1,
                             rescale = FALSE)

max_10_pwr_cntr_dir <- whichpart(pwr_cntr_dir)
max_10_pwr_cntr_undir <- whichpart(pwr_cntr_undir)

max_10_pwr_cntr_dir
max_10_pwr_cntr_undir

# Subgraph Centrality
###Subgraph centrality of a vertex measures the number of subgraphs a vertex participates in, weighting them according to their size.
###

sub_cntr_dir <- subgraph_centrality(got_net, diag = FALSE)
sub_cntr_undir <- subgraph_centrality(got_net_undir, diag = FALSE)
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


