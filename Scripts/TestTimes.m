% This script is used to compute the negativity on generated Ps to test
% computation times
nmin = 8;
nmax = 12;

c_values = [0.0, 0.5, 1.0];
for n=nmin:2:nmax
    m = 2;
    A = matrixA(n,m);
    %-->U = matrixU(n,m); 
    %--> Will use kronmult for multiplication with this MP operator
    %--> This is not so efficient for small n but becomes much more 
    %--> efficient when n becomes large
    T = matrixT(n,m);
    R = R_ab(n);
    R2m = cell(2*m,1);
    [R2m{:}] = deal(R);
    R2mt = cell(2*m,1);
    [R2mt{:}] = deal(R');
    
    muf =  1e-10;
    delta = 0;          %We require strict equality Ax = b
    opts = [];
    opts.Verbose = 0;
    opts.TolVar = 1e-10; %Stop criterion
    opts.normU = 1;
    %-->opts.U = U;
    %-->opts.Ut = U';
    opts.U = @(z)(kronmult(R2m,z));
    opts.Ut = @(q)(kronmult(R2mt,q));
    

    for c=c_values
        datafile = sprintf('../Data/P_line/22n_Bell_line_with_kink_n%d_c%0.2f.txt', n, c);
        resultsfile = sprintf('../Data/times/timeit_22n_Bell_line_with_kink_n%d_c%0.2f.txt', n, c);
        %Ps = readmatrix(datafile) %% Recommended to use instead of dlmread for Matlab >2019
        Ps = dlmread(datafile);
        numpoints = size(Ps,1);
        results = zeros(numpoints,2);
        for j=1:numpoints
            P = Ps(j,:)';
            z0 = T*P;
            f = @() NESTA(A,[],z0,muf,delta,opts);
            if n < 7
                time = timeit(f); %% Recommended way to measure time
            else
                tic;f();time = toc; %% Quick and dirty way to measure time. 
            end
            %-->Neg = neg(U*f());
            Neg = neg(kronmult(R2m, f()));
            results(j,:) = [Neg,time];
            fprintf('|')
        end
        dlmwrite(resultsfile, results);
        fprintf('\n')
        display(sprintf('n:%d, c:%0.2f done!', n, c))
    end
end  
  