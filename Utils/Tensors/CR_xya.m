function [CR] = CR_xya(n,m)
%CR Summary of this function goes here
%   Detailed explanation goes here
CR = zeros(m,m,n);
CR(:,:,1) = R_ab(m);
for c = 2:n
    CR(:,:,c) = eye(m);
end
end

