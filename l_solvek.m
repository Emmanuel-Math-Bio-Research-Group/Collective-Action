function [l, A] = l_solvek(W,k,lprev,Aprev)
%%% This function calculates the coalescent lengths of all subsets 
%%% of size k for a given graph with adjaceny matrix W
%
% Inputs:  W is the weighted adjacency matrix
%          k is subset size
%          lprev is vector of coalescent lengths for subsets of size k-1
%          Aprev is matrix of subsets of size k-1 used for enumeration
% Outputs: l is a vector of coalescent lengths
%          A is a matrix of subsets of size k used for enumeration

N = size(W,1);  %number of vertices
P = W./sum(W,2); %step probabilities
Nck = nchoosek(N,k);  %number of coalescent lengths l to calculate
A = nchoosek(1:N,k); %indexing of all possible subsets of size k
M = eye(Nck); %coefficient matrix to solve for l's
z = ones(Nck,1); %initialize RHS column vector

%construct M coefficient matrix
for s = 1: Nck
    Svec = A(s,:);
    for j = Svec
        SminusJ = Svec(Svec ~= j);
        for i = 1:N
            if any(i == SminusJ)  %if vertex i is in set SminusJ
                z(s) = z(s) + 1/k*P(j,i)*lprev(findJ(Aprev,SminusJ));
            else 
                ind = findJ(A, [SminusJ, i]);
                M(s,ind) = M(s,ind) - P(j,i)/k;
            end
        end
    end
end

%Solve Ml = z for coalescent lengths
l = M\z;

end