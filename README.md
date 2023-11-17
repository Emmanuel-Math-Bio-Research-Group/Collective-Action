This repository contains MATLAB code (v2022a) to compute coalescence lengths and cost-benefit thresholds for collective help or harm on a given graph. 

Developed by Benjamin Allen, Abdur-Rahman Khwaja, James Donahue, Theodore J. Kelly, Sasha R. Hyacinthe, Jacob Proulx, Yulia A. Dementieva, and Christine Sample of Emmanuel College, Boston MA, USA. 

This code is used in the manuscript “Natural Selection for Collective Action” by Benjamin Allen, Abdur-Rahman Khwaja, James Donahue, Theodore J. Kelly, Sasha R. Hyacinthe, Jacob Proulx, Cassidy Lattanzio, Yulia A. Dementieva, and Christine Sample, available at: https://arxiv.org/abs/2302.14700 

The following functions are included: 

    Function computeL.m computes coalescence lengths on a given (possibly weighted) graph for all subsets up to a given size. Inputs are the graph’s adjacency matrix W and the maximal size k. The output is a cell array containing coalescence lengths for each subset up to size k. 

    Function kappaSg.m computes the cost-benefit ratio for the collective action dilemma of a set S to a node g given by Eq. (9.10) of the Supplementary Information to the manuscript. The inputs are lcell, a cell array of coalescence lengths produced by the computeL.m function, S, the actor set of vertices (as a vector), and W, the weighted adjacency matrix of the graph. Our output, kappa, is a vector with an entry for each target vertex g for the cost-benefit ratio kappa_{S,g}. 

    Function calculateQ.m calculates the modularity measure Q (Newman, 2004) for a division into communities. The inputs are the weighted adjacency matrix and a vector indicating which nodes are in which community. This function is used within the findmaxQ.m function. 

    Function findmaxQ.m implements the spatial version of the Girvan-Newman algorithm described in section 9.8.1 of the SI. The input is the specified weighted adjacency matrix. The output is a vector of all modularity measures which were calculated, a matrix in which the rows represent a division in the communities for a particular modularity value, the maximum modularity measure, and a vector corresponding to the community associated with the maximum modularity measure. 

    Function Kappatablemaker.m calculates many outputs to be organized in a table. Output kappa is a vector of the cost-benefit ratio for the collective action dilemma for actor set S and each target g, maxQ is the maximum Q modularity for the spatial Girvan-Newman algorithm, S is the division of communities corresponding to maxQ, KappaPOS is the number of vertices that set S may help outside of S, and NONNEIGHBOR is the number of vertices set S may help that are neither inside nor adjacent to S. 

    Function delaunayT.m generates and plots a Delaunay network of a given size n, with edges weighted inversely proportional to distance. The input is the number of nodes n. The outputs are an adjacency matrix weighted by inverse pairwise distances, a set of the x and y coordinates of the node locations, and the Delaunay triangulation as a MATLAB triangulation object. 

    The other functions (findJ.m, l_solve2.m, l_solvek.m, removelongestedge.m) are subroutines used by computeL.m and kappaSg.m. 

 

 

 

An adjacency matrix for a sociable weaver nest chamber network is included as a demonstration of the code in the file WeaverDemo.mat. Cost-benefit ratios, kappa_{S,g}, can be computed for this network by the following steps: 


    1. First, enter ‘[maxQ, maxcommunity] = findmaxQ(W21)’ in the Command Window of MATLAB to determine the division of the network into communities with the largest modularity. The output maxcommunity shows that community 2 is the largest, with 5 members. This takes approximately 0.07 seconds to run on a 2020 MacBook Air. 

    2. Next, enter ‘lcell21 = computeL(W21, 6)’ to obtain the corresponding coalescence lengths as a cell array. The second argument is the largest set size needed for coalescence lengths, which is one more than the largest community size. This takes approximately 0.411 seconds to run on a 2020 MacBook Air. 

    3. Lastly, enter ‘[kappa, maxQ, S, KappaPOS, NONNEIGHBOR] = Kappatablemaker(W21, lcell21)” to find the critical cost-benefit ratios ‘kappa’ from each community to each node, as well as other outputs described above. This takes approximately 0.036 seconds to run on a 2020 MacBook Air. 

 
 

 

 

 

 