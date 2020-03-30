function T = matrixT(n,m,protocolQ)
%T matrix: Projects P onto z0  = T*P [plus projection 
%   onto basis of non-zero singular values]  
U = U_axcz(n,m);
Si = Si_czcz(n,m);
tensorList = {U,U,Si,Si};
legLinks = {[-1,-3,1,3],[-2,-4,2,4],[1,3,-5,-7],[2,4,-6,-8]};
sequence = [1,3,2,4]; 
finalOrder = [-5,-7,-6,-8,-1,-2,-3,-4];
T = ncon(tensorList,legLinks,sequence,finalOrder);
T = reshape(T,n*m,n*m,n*n*m*m);
k = kill_indices(n,m);
T(k,:,:) = [];
T(:,k,:) = [];
T = reshape(T, (n*m -m+1)*(n*m-m+1),n*n*m*m);
end

