function P = transformPfrom_q(n,m,q)
%transformPfrom_q: Obtains the behavior P(ab|xy) from hidden variable q. 
D = D_axf(n,m);
q = reshape(q, n^m,n^m);
P = ncon({D,D,q},{[-1,-3,1],[-2,-4,2],[1,2]});
end

