function [Si] = Si_czcz(n,m)
%S Summary of this function goes here
%   Detailed explanation goes here
Si = zeros(n,m,n,m);
Si(1,1,1,1) = 1/sqrt(m*n^(m-1));
for c = 2:n
    for z = 1:m
        Si(c,z,c,z) = 1/sqrt(n^(m-1));
    end
end
end

