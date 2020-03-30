function [P] = P_rand(n,m)
%RANDOM_PROB Summary of this function goes here
%   Detailed explanation goes here
P = rand(n*n,m*m);
P = P./ repmat(sum(P,1),n*n,1);
P = reshape(P,n,n,m,m);
end
