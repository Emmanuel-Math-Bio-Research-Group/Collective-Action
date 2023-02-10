function lcell = computeL(W,kMax)
tic
N = length(W); %Determines the number of vertices in W
%The goal of this function is to output all the expected values of l_k in a
%matrix. 
lcell(1,1)={zeros(N,1)}; %Since L_1 is always 0, we set the first row as equal to 0 using a zero matrix of N rows and 1 column
lcell(1,2)={(1:N)'}; %Prints the vertices vertically
[L2,A2]=l_solve2(W); %Solves l_solve2(W), prints them in the cell array
lcell(2, 1) = {L2}; %L2 is the matrix of l_2 values
lcell(2,2) = {A2}; %A2 is the list of subsets
for k = 3:kMax
    [lk,Ak] = l_solvek(W, k, lcell{k-1,1},lcell{k-1,2});
    lcell(k,1) = {lk};
    lcell(k,2) = {Ak}; 
end %This for loop follows similar logic as above, it calls on the previous values of l_k to solve the next set of values. Which is why l_solve2 must be calculated separately. 
toc
end