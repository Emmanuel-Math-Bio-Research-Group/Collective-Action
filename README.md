# Collective-Action
This reposity contains MATLAB code (v2022a) to compute coalescence lengths and benefit-cost thresholds for collective help or harm on a given graph.

Developed by Benjamin Allen, Abdur-Rahman Khwaja, James Donahue, Yulia A. Dementieva, and Christine Sample of Emmanuel College, Boston MA, USA.

function computeL computes coalescence lengths on a given (possibly weighted) graph for all subsets up to a given size.  Inputs are the graph’s adjacency matrix W and the maximal size k.  The output is a cell array containing colaescence lengths for each subset up to size k.  

function critBC computes the benefit-cost thresholds for collective help or harm for a given set S on a given graph, using Eq. (8.10b) from the SI. It also (optionally) computes the benefit-cost ratio for the threshold public goods game, using Eq. (8.13b) from the SI. The inputs for critBC are the cell array of coalescence lengths that is output from computeL, the graph’s adjacency matrix W, and a vector containing the indices of the set S.  The output is a vector of  (b/c)_{S,g} for each vertex g, and (optionally) the threshold public goods ratio (b/c)_S.

To compute benefit-cost thresholds (b/c)_{S,g} for a given set S on a given graph, first run computeL, with W being the graph’s weighted adjacency matrix and k being one more than the size of S.  Then, use the output from computeL as input to critBC, along with the adjacency matrix W and the set S (in the form of a vector of indices).

The other functions are subroutines used by computeL and critBC.
