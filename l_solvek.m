function [l,A] = l_solvek(W, k, lkMinusOne, AkMinusOne)
%W = matrix of edgeweights, k = size of subsets, lkminusone is the l_k
%before the k we want to caclulate. Akminusone is the A matrix before the k
%we want to calculate
Wsum= sum(W, 2);  %Sums up each row of the matrix
P = W./Wsum;
%P = The matrix of step probabilities
%N = The number of rows and columns of W
N = size(W, 1); %Size of the matrix with W rows and 1 column
Nck = nchoosek(N,k); 
M = eye(Nck); %identity vector of Nck size
Z = ones(Nck, 1); %one vector of Nck rows and 1 column
A = nchoosek(1:N,k); %nchoosek of all potential subsets
for j = (1 : Nck)
    Svec = A(j,:); %This follows the same principle of l_solve3_Alt. it calculates a list of subsets
    %And if any i value is within sMinusH it computes the necessary value of
    %Z. Else it will compute the corresponding value of M
    for h=Svec
        sMinusH=Svec(Svec~=h);
        for i = (1:N)
            if any(i==sMinusH) 
                Z(j) = Z(j) + 1/k*(P(h,i))*lkMinusOne(findJ(AkMinusOne,sMinusH));
            else 
                ind = findJ(A,[sMinusH,i]);
                M(j, ind) = M(j,ind) - P(h,i)/k;
            end
        end
    end
end
l = M\Z; %and then it computes the matrix operation
end