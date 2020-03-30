function U = U_axcz(n,m)
%U Summary of this function goes here
%   Detailed explanation goes here

U = ncon({R_ab(n),C_abc(n),CR_xya(n,m)},{[-1,1],[1,2,-3],[-2,-4,2]});

end

