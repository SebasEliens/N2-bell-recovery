function [S] = S_czcz(n,m)
%S Summary of this function goes here
%   Detailed explanation goes here
S = zeros(n,m,n,m);
S(1,1,1,1) = sqrt(m*n^(m-1));
for c = 2:n
    for z = 1:m
        S(c,z,c,z) = sqrt(n^(m-1));
    end
end
end

