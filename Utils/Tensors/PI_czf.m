function PI = PI_czf(n,m)
%PI Summary of this function goes here
%   Detailed explanation goes here
PI = zeros(n,m,n^m);
PI(1,1,1) = 1;
for c = 2:n
  for z = 1:m
    PI(c,z,1 + (c-1)*n^(m-z)) = 1;
  end
end
end

