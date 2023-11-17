function [kappa]= kappaSg(lcell, S, W)
% For a given graph, this function computes the cost-benefit ratio
% kappa_{S,g} for the collective action dilemma of a set S to a
% node g given by Eq. (9.10) of the SI.  
%
% Inputs:  lcell is a cell array of coalescence lengths and 
%                 corresponding subsets (output of ComputeL.m) 
%          S is the actor set of vertices (as a vector)
%          W is the weighted adjacency matrix of the graph
% Output:  kappa is a vector with an entry for each target vertex g for the 
%          cost-benefit ratio kappa_{S,g} 


%% Initialization

N = length(W); %Number of vertices in G
Wsum = sum(W,2); %Weighted degree of each vertex
v = N*Wsum./sum(sum(W)); %Reproductive value of each vertex
P = W./Wsum; %Matrix of random walk step probabilities
P2 = P^2; %Two-step random walk probabilities
m = length(S); %Number of vertices in S
Sindex = findJ(lcell{m,2},S); %The index of S in lcell
lS = lcell{m,1}(Sindex); %coalescence length of S


%% Calculate kappa

Knum = zeros(m,1); %initialize numerator of kappa
Kdenom = 0; %initialize denominator of kappa

%sum over all vertices in set S
for h = S 
    %sum over all vertices in graph G to calculate denominator
    for k = 1:N 
        if k ~= h
            J = findJ(lcell{2,2},[k,h]); %index of l_{h,k} in lcell
            Kdenom = Kdenom + v(h)*lcell{2,1}(J)*P2(h,k)/m;
        end
    end 
    %calculate numerator for all possible target nodes g
    for g = 1:N 
        % Calculate v_g * l_{S U {g}} term in numerator
        if any(g == S) 
            lSg = lS; %if g in S then l_{S U {g}} is l_S
        else 
            J = findJ(lcell{m+1,2},[S,g]); 
            lSg = lcell{m+1,1}(J); 
        end
        Knum(g) = -v(g)*lSg; 

        %sum over all vertices in graph to calculate sum in numerator
        for k = 1:N 
            % Calculate l_{S U {k}}
            if any(k == S) 
                lSk = lS; %if k in S then l_{S U {k}} is l_S
            else
                J = findJ(lcell{m+1,2},[S,k]); 
                lSk = lcell{m+1,1}(J); 
            end
            Knum(g) = Knum(g) + v(g)*lSk*P2(g,k); 
        end
    end
end

kappa = Knum./Kdenom; 


