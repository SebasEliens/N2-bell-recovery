function P = P_ns(n,m)
%RANDOM_PROB Summary of this function goes here
%   Detailed explanation goes here
P = P_rand(n,m);
U = U_axcz(n,m);
PI = S_czcz(n,m);
PI(PI ~= 0) = 1;
tensorList = {P,U,U,PI,PI,U,U};
legLinks = {[1,2,3,4],[1,3,5,7],[2,4,6,8],[5,7,9,11],[6,8,10,12],[-1,-3,9,11],[-2,-4,10,12]};
sequence = [1,3,5,7,9,11,2,4,6,8,10,12];
P = ncon(tensorList,legLinks,sequence);
end
