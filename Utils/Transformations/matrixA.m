function A = matrixA(n, m)
%A matrix: Projects z onto z0. Constraint in NESTA: Ax=b.
PI = reshape(PI_czf(n,m),n*m,n^m);
k = kill_indices(n,m);
PI(k,:) = [];
A = kron(PI,PI);
end

