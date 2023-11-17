function W=removelongestedge(W) 
% This function removes the longest edge of a graph
% Input: Adjacency matrix weighted by "relatedness" among nodes
% Output: Adjacency matrix weighted by "relatedness" among nodes
% longest edge removed

% Convert edge weights to distances between nodes
Wdist=1./W; 
Wdist(isinf(Wdist))=0;

% Find edge with maximum distance
[M,Ind]=max(Wdist,[],'all');
[row,col]=ind2sub(size(Wdist),Ind);

% "Remove longest edge"
W(row,col)=0;
W(col,row)=0;
end