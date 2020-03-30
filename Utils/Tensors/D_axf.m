function D = D_axf(n,m)
%D_axf Computes the deterministic tensor D for n inputs and m outputs
%   Conventions are such that f = a1...am = a1 + a2*n + ... + am*n^(m-1)
%   Due to column normal order, the case 222 gives [D(ax|a1a2)] as
%
%           D(00|00)   DD(00|01)    D(00|10)    D(00|11)
%           D(10|00)   DD(10|01)    D(10|10)    D(10|11)
%           D(01|00)   DD(01|01)    D(01|10)    D(01|11)
%           D(11|00)   DD(11|01)    D(11|10)    D(11|11)
%
%   in Matlab, obtained as reshape(D_axf(2,2),4,4).

D = zeros(n,m,n^m);
for a = 0:n-1
  for x = 0:m-1
     for f = 0:n^m-1
         if mod(floor(f/n^(m-x-1)),n) == a 
            D(a+1,x+1,f+1) = 1;
         end
     end 
  end
end
end

