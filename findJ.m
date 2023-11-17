function j = findJ(A,vec) 
%inputs: matrix A and vector vec
%output: the row(s) of A that match vec (after vec is sorted)
j = find(ismember(A, sort(vec), 'rows'));  
end 