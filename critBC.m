function [CHG, PGG]= critBC(lcell, S, W)
%Computes the benefit-cost ratio (b/c)^*_{S,g} for the collective help/harm
%scenario on a given graph. Computations are based on Eq. (8.10b) of the
%SI.

%lcell a cell array of coalescence lengths and corresponding subsets (output of ComputeL.m) 
%S is the set of vertices (as a vector)
%W is the weighted adjacency matrix of the graph
%CHG is the benefit-cost ratio (b/c)^*_{S,g} for the collective help game 
%CHG is a vector with an entry for each target vertex g
%PGG is the benefit-cost ratio for the threshold public goods game played
%by S


N = length(W); %Number of vertices in G
Wsum = sum(W,2); %Weighted degree of each vertex
vg= N*Wsum./sum(sum(W)); %Reproductive value of each vertex
P = W./Wsum; %Matrix of random walk step probabilities
P2 = P^2; %Two-step random walk probabilities
sSize = length(S); %Number of vertices in S
Sindex= findJ(lcell{sSize,2},S); %The index of S in lcell
lS = lcell{sSize,1}(Sindex); %lS = the coalescence length of S

CHnum=0; %numerator of Eq. (8.10b) in SI for (b/c)^*_{S,g}
CHdenom=zeros(sSize,1); %demoninator of Eq. (8.10b) in SI for (b/c)^*_{S,g}

for h= S 
    for k = 1:N %evaluates inner sum in numerator
        if k ~= h
            J = findJ(lcell{2,2},[k,h]); %index of l_{h,k} in lcell
            CHnum = CHnum+vg(h)*lcell{2,1}(J)*P2(h,k)/sSize;
        end
    end 
    for g=1:N %runs over possible targets g
        if any(g == S) 
            lSg = lS; %if g is in S then l_{S \cup {g}}=l_S
        else
            J = findJ(lcell{sSize+1,2},[S,g]);%finds index of S \cup {g} in lcell
            lSg= lcell{sSize+1,1}(J); %retrieves value of l_{S \cup {g}} from lcell
        end
        CHdenom(g)=-vg(g)*lSg; %l_{S \cup {g}} term in denominator
        for k = 1:N %evaluates sum in denominator
            if any(k == S) %if k is in S then l_{S \cup {k}}=l_S
                lSk=lS;
            else
                J = findJ(lcell{sSize+1,2},[S,k]);%finds index of S \cup {k} in lcell
                lSk = lcell{sSize+1,1}(J); %retrieves value of l_{S \cup {k}} from lcell
            end
            CHdenom(g) = CHdenom(g)+vg(g)*lSk*P2(g,k); %l_{S \cup {k}} term of sum in denominator
        end
    end
end

CHG=CHnum./CHdenom; %evaluates Eq. (8.10b) for given S and all values of g

PGdenom=0; %demoninator of Eq. (8.13b) in SI for (b/c)^*_{S}
for g=S %outer sum in denominator
    PGdenom=PGdenom-vg(g)*lS; %lS term in denominator
    for k = 1:N %inner sum in denominator
            if any(k == S) %if k is in S then l_{S \cup {k}}=l_S
                lSk=lS;
            else
                J = findJ(lcell{sSize+1,2},[S,k]);%finds index of S \cup {k} in lcell
                lSk = lcell{sSize+1,1}(J); %retrieves value of l_{S \cup {k}} from lcell
            end
            PGdenom = PGdenom+vg(g)*lSk*P2(g,k); %l_{S \cup {k}} term in inner sum of denominator
    end
end

PGG=sSize*CHnum/PGdenom; %evaluates Eq. (8.13b). Note that the numerator in 
% Eq. (8.13b) is equal to the size of S times the numerator of Eq. (8.10b)
