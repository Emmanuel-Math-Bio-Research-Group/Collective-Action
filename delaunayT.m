function [W, P, DT]=delaunayT(n)
%This function generates a Delaunay network of size n with edges weighted 
% inversely proportional to distance.
%Input:    n is the number of nodes
%Outputs:    W is an adjacency matrix weighted by inverse pairwise distances
%           P is the x and y coordinates of the node locations
%           DT is the delaunay triangulation
rng('shuffle')
P = rand([n 2]); %Generates two columns of random numbers from 0 to 1 up to n rows  
DT = delaunayTriangulation(P); %creates delaunay triangulation of the node locations in P
W=zeros(n); %Initialize nxn matrix called W
%Calculate the inverses of the euclidean distances between the connected
%points in P
for i=1:n % loop through starting nodes
    for j=1:n % loop through ending nodes
        if isConnected(DT,i,j) % if two nodes are connected by an edge
            W(i,j)=1./(sqrt((P(i,1)-P(j,1))^2+(P(i,2)-P(j,2))^2)); % inverse of the euclidean distances between two nodes
        end
    end
end
% Plot graph of W
G = graph(W);
LWidths = 5*(G.Edges.Weight/max(G.Edges.Weight)); 
Gr = plot(G, 'Layout','force','EdgeColor','black','LineWidth',LWidths,'NodeFontSize',16, 'MarkerSize', 12, 'WeightEffect','direct');
% Layout of graph with nodes being at points of P
Gr.XData=P(:,1);
Gr.YData=P(:,2);