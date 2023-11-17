function [l,A] = l_solve2(W)
%%% This function calculates the coalescent lengths of all subsets
%%% of size 2 for a given graph with adjaceny matrix W
%
% Input:   W is the weighted adjacency matrix
% Outputs: l is a vector of coalescent lengths
%          A is a matrix of subsets of size 2 used for enumeration

N = size(W,1);  %number of vertices
P = W./sum(W,2); %step probabilities
Nck = nchoosek(N,2);  %number of coalescent lengths l to calculate
A = nchoosek(1:N,2); %indexing of all possible subsets of size 2
M = eye(Nck); %coefficient matrix to solve for l's
z = ones(Nck,1); %RHS column vector of ones

%construct M coefficient matrix
for s = 1: Nck
    Svec = A(s,:);
    for j = Svec
        SminusJ = Svec(Svec ~= j);
        for i = 1:N
            if all(i ~= SminusJ)   %if vertex i is not in set SminusJ
                ind = findJ(A, [SminusJ, i]);
                M(s,ind) = M(s,ind) - P(j,i)/2;
            end
        end
    end
end

%Solve Ml = z for coalescent lengths
l = M\z;

end