function k = kill_indices( n,m )
%KILL_INDICES: Implements the projection from a cz basis of singular vectors 
%   of D to the vectors corresponsing only to the non-zero singular values. 
%   This is achieved by deleting c = 0, z ~= 0 elements. Function outputs a 
%   list of indices, k = kill_indices(n,m) so that V() = [] deletes 
%   corresponding  elements of vector V.
k = [];
for z =1:m-1
   k = [k z*n+1];
end

end

