function lcell = computeL(W,kmax)
%%% This function calculates the coalescent lengths of all subsets 
%%% up to size kmax for a given graph with adjaceny matrix W
%
% Inputs:  W is the weighted adjacency matrix
%          kmax is the maximum subset size
% Output:  lcell is a cell array of coalescent lengths for all subsets
%              of size 2 through kmax. 

N = length(W); %number of vertices
lcell = cell(kmax,2); %initialize cell array of coalescent lengths

%subsets of size 1 have coalescent length of 0
lcell(1,1) = {zeros(N,1)};  
lcell(1,2) = {(1:N)'};

%subsets of size 2
[l,A] = l_solve2(W); 
lcell(2,1) = {l};
lcell(2,2) = {A};

%subsets of size 3 through kmax
for k = 3:kmax
    [l, A] = l_solvek(W,k,lcell{k-1,1},lcell{k-1,2});
    lcell(k,1) = {l};
    lcell(k,2) = {A};
end

end