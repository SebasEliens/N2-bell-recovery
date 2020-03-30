function [C] = copy(n)
%COPY Defines the three-legged copy tensor

C = zeros(n,n,n);
for c = 1:n
    C(c,c,c) = 1;
end
end

