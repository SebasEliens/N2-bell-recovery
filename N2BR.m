function [NEG,q] = N2BR(n,m,P,options)
% N2BR = Bipartite (N=2) Bell Recovery. 
%      
%   *** Requires: 
%   *** = NESTA (arxiv.org/abs/0904.3367)
%   *** = NCON (arxiv.org/abs/1402.0939)
%
%
%   Finds quasi probability q for the hidden variable in a bipartite Bell scenario
%   and computes the negativity NEG(q) which is a measure of non-locality.
%   Alice and Bob have n outputs and m inputs.
%
%   The mathematical problem is the following L1 optimization
%
%           - Minimize     ||q||_1
%           - Subject to   (D \otimes D)q = P
%
%   Here q(a1...am b1...bm) is the hidden quasi probability 
%   and P(ab|xy) is the bipartite behavior we want to test. 
%   D is the deterministic tensor for each party. 
%
%   The optimization is done using the NESTA algorithm. 
%   It solves min_x ||Ux||_1 such that ||Ax - b|| <= delta
%   (take delta = 0 for equality Ax = b). We first compute b = T*P 
%   the vector of generalized two-party correlations set by P.
%
%   Generating matrices T,A,U uses tensor network manipulations with NCON.
%
%   Inputs: 
%       - n: Number of outputs Alice and Bob
%       - m: Number of inputs Alice and Bob 
%       - P: Behavior to be tested, P can be 
%               + column vector or matrix of column vectors
%               + row vector or matrix of row vectors [problem when numP = n*n*m*m]
%               + matrix of size nn x mm or array of these 
%               + tensor of size n,n,m,m or array of these
%       - options: We can precalculate the matrices that go into NESTA and
%                  set some NESTA parameters.
%               + options.T: Matrix T for preparation b = T*P in NESTA
%               + options.A: Matrix A for constraint A*x = b in NESTA
%               + options.U: Matrix U for minimization ||Ux||_1 in NESTA
%               + options.muf: smoothing parameter muf in NESTA
%               + options.TolVar: defines precission in NESTA
%               + options.Verbose: Show NESTA output (0 by default, put 1
%               to see iteration details of NESTA)
%
%   Output: 
%       - NEG: sum of negative elements of q. 
%       - q: quasi behavior q(a1...am b1...bm).
%
% Written by: Sebas Eli\"ens 
% Institution: International Institute of Physics (IIP), Natal, Brazil
% Email: sebas.eliens@gmail.com
% Created: December 2019


%% Function body

if exist('options','var') == 0, options = []; end
if isempty(options) && isnumeric(options), options = struct; end

muf =  setOptions('muf', @()1e-10);
delta = 0;          %We require strict equality Ax = b
opts = [];
opts.Verbose = setOptions('Verbose', @()0);
opts.TolVar = setOptions('TolVar', @()1e-10); 
opts.normU = 1;
opts.U = setOptions('U', @()matrixU(n,m));
opts.Ut = setOptions('U', @() []);
A = setOptions('A', @()matrixA(n,m));
T = setOptions('T', @()matrixT(n,m));

% Prepaire vector (matrix) B = [b] for NESTA [works for different forms of P by
% checking its shape]
% We first put P in column vector form and then apply T to prepare for NESTA.
sizeP = size(P);
dimsP = length(sizeP);
if dimsP == 2
   if sizeP(1) == n*n*m*m % default case: column vector
       B = T*P;
   elseif all(sizeP ==[n*n m*m]) % single matrix
       B = T*reshape(P,n*n*m*m,1);
   elseif dimsP == n*n*m*m % row vector(s): take transpose
       B = T*P';
   end
elseif dimsP == 3 % array of matrices   
   if all(sizeP == [n*n m*m sizeP(3)]) 
       B = T*reshape(P,n*n*m*m,sizeP(5));
   end
elseif dimsP == 4 % 4leg tensor
   if all(sizeP == [n n m m]) 
      B = T*reshape(P,n*n*m*m,1);
   end
elseif dimsP == 5 % array of tensors
   if all(sizeP == [n n m m sizeP(5)]) 
       B = T*reshape(P,n*n*m*m,sizeP(5));
   end
else
    error('Seems P is not in the right shape')
end
numP = size(B,2);


% NESTA is used to obtain hidden variable quasi probability in correlation
% basis Z. Then we transform to find q.
Z = zeros(n^(2*m),numP);
for j=1:numP
    Z(:,j) = NESTA(A,[],B(:,j),muf,delta,opts);
end

if ~isa(opts.U,'function_handle')
    q = opts.U*Z;
else
    q = opts.U(Z)
end

NEG = neg(q);

%---- internal routine for setting defaults (from setOpts in NESTA.m)
%---- !: assume default is function handle to not generate big matrices.
function var = setOptions(field,default)
    % has the option already been set?
    if ~isfield(options,field) 
        % see if there is a capitalization problem:
        names = fieldnames(options);
        for i = 1:length(names)
            if strcmpi(names{i},field)
                options.(field) = options.(names{i});
                options = rmfield(options,names{i});
                break;
            end
        end
    end
    if isfield(options,field) && ~isempty(options.(field))
        var = options.(field);  % set if user defined the default
    else
        var = default();
    end
end
end