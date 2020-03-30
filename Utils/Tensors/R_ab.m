function [R] = R(n)
%R Summary of this function goes here
%   Detailed explanation goes here
R = zeros(n,n);
R(:,1) = ones(n,1)/sqrt(n);
for j = 2:n
    for i = 1:j-1
        R(i,j) = 1/sqrt(j*j-j);
    end
    R(j,j) = (1-j)/sqrt(j*j-j);
end

