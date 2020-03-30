function V = V_fg(n,m)
%V_fg Summary of this function goes here
%   Detailed explanation goes here
R = R_ab(n);
V = R;
for j=2:m
    V = kron(V,R);
end
end

