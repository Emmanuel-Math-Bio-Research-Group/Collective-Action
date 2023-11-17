function [maxQ, maxcommunity, Q, community]=findmaxQ(W)
% This function implements the spatial version of the Girvan-Newman 
% algorithm described in section 9.8.1 of the SI.
% Input: W is the weighted adjacency matrix
% Output: maxQ  is the maximum modularity measure
%         maxcommunity is the vector corresponding to the community
%         associated with the maximum Q
%         Q is a vector of all modularity measures calculated
%         community is a matrix in which a row represents a division in the
%         communities for a particular Q value.
G=graph(W); % Graph of W
community(1,:)=conncomp(G); % Initiating original community of all
Q(1)=calculateQ(W,community); % Q for original graph
ncomm=max(community); % Number of communities
Wnew=W;
i=2;
while ncomm<length(W) % While number of communitites is less than size of W
    Wnew=removelongestedge(Wnew); % remove the longest edge of Wnew
    bins=conncomp(graph(Wnew)); % Determining communities after longest edge is removed
    if max(bins)>ncomm % if number of communities increased after edge removal
        community(i,:)=bins;
        ncomm=max(community(i,:)); % New number of communities
        Q(i)=calculateQ(W,community(i,:)); % Calculation of Q with new communities after edge removal
        i=i+1;
    end
end
% Finding maximum Q value with the corresponding community
[maxQ, ind]=max(Q);
maxcommunity=community(ind,:);
end



