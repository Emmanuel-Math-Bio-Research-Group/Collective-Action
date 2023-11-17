function [kappa, maxQ, S, KappaPOS, NONNEIGHBOR] = Kappatablemaker(W,lcell) 
% Input: W is a weighted adjacency matrix
%        lcell is a cell array of coalescence lengths and corresponding 
%        subsets (output of ComputeL.m)
% Output: kappa is a vector of the cost-benefit ratio for the collective
%     action dilemma for actor set S and each target g.
%     maxQ is the maximum Q modularity for the spatial Girvan-Newman
%     algorithm.
%     S is the division of communities corresponding to maxQ
%     KappaPOS is the number of verticies that set S helps
%     outside of S
%     NONNEIGHBOR is the number of non-connected nodes a set offers help to

% This finds the maximum Q modularity and associated community
[maxQ, maxcommunity, ~, ~] = findmaxQ(W);
vec = 1:length(W); 
% Loop through number of communities
for i = 1:max(maxcommunity) 
    % Identifying nodes in community
    S{i} = vec(maxcommunity==i); 
    %Computes the cost-benefit ratio kappa_{S,g}
    [kappa{i}]= kappaSg(lcell, S{i}, W);
    kappa{i}=reshape(kappa{i},[length(W) 1]);
    % Identify the number of verticies being helped
    KappaPOS(i)=sum(kappa{i}(vec(maxcommunity~=i))>0);
    % Identify those that are not neighbors
    NONNEIGHBOR(i)=sum((sum(W(S{i},:),1)==0)&(maxcommunity~=i)&(kappa{i}'>0));
end