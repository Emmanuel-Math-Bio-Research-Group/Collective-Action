function [l,A] = l_solve2(W)
%W = matrix of edgeweights, we are calculating subsets of size 2 in this function. l is the coalescent length
%of each subset. 
Wsum= sum(W, 2);  %Sums up each row of the matrix

P = W./Wsum;
%P = The matrix of step probabilities
%N = The number of rows and columns of W
N = size(W, 1); %Size of the matrix with W rows and 1 column
Nck = nchoosek(N,2); 
M = eye(Nck); %identity vector of Nck size
Z = ones(Nck, 1); %one vector of Nck rows and 1 column
A = nchoosek(1:N,2); %nchoosek of all potential subsets
for j = (1 : Nck)
    Svec = A(j,:); %This follows the same principle of l_solve3_Alt. it calculates a list of subsets
    %And if any i value is within sMinusH it computes the necessary value of
    %Z. Else it will compute the corresponding value of M
    for h=Svec
        sMinusH=Svec(Svec~=h);
        for i = (1:N)
            if all(i~=sMinusH) 
                ind = findJ(A,[sMinusH,i]);
                M(j, ind) = M(j,ind) - P(h,i)/2;
            end
        end
    end
end
l = M\Z; %and then it computes the matrix operation
end