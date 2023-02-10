function j = findJ(A,vec) %inputs a matrix A and vector vec
j = find(ismember(A, sort(vec), 'rows'));  %Returns the row(s) of A that match vec (after vec is sorted)
end 