function Q=calculateQ(W,community)
% This function calculates the Q modularity for a division into communitites
% according to Newman (2004)
% Input: W is the weighted adjacency matrix
%        community is a vector indicating which nodes are in which
%        community
% Output: Q is the modularity measure

m=0.5*sum(sum(W)); % sum of all edge weights
k=sum(W); % vector of node degrees

Q=0; % initialize Q

% looping through every element of matrix W
for i=1:length(W)
    for j=1:length(W)
        % check if node i and j are of the same community
        if community(i)==community(j) 
        % Add the corresponding term
            Q=Q+W(i,j)-k(i)*k(j)./(2*m);
        end
    end
end
% Divide by the denominator
Q=Q./(2*m); 
end
