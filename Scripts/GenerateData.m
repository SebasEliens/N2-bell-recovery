% This script is used to generated P for the bipartite Bell scenario
% We use a varying number of inputs n and fix m=2

% Generate data on path from WhiteNoise to PRBox via c*Deterministic
nmin = 2;
nmax = 12;
numpoints = 51;
c_values = [0.0, 0.25, 0.5, 0.75, 1.0];
for n=nmin:nmax
    m = 2;
    P0 = reshape(P_wn(n,m), n*n*m*m,1);
    P1 = reshape(P_pr(n,m), n*n*m*m,1);
    Pc = reshape(P_det(n,m,0,0), n*n*m*m,1);
    for c=c_values
        Ps = zeros(numpoints, n*n*m*m);
        for j=1:numpoints
            t = (j-1)/(numpoints-1);
            P = ((1-t)*P0 + t*P1)*(1 - c*(0.5 - abs(t - 0.5))) +  c*(0.5 - abs(t - 0.5))*Pc;
            Ps(j,:) = P';
        end
        filename = sprintf('../Data/P_line/22n_Bell_line_with_kink_n%d_c%0.2f.txt', n, c);
        dlmwrite(filename, Ps, ',') 
    end
end  
  