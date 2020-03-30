function P = P_pr(n,m)
%P_PR22N Summary of this function goes here
%   Detailed explanation goes here

P = zeros(n,n,m,m);

% Two inputs
if m==2
    for a = 0:n-1
        for b = 0:n-1
            for x = 0:m-1
                for y = 0:m-1
                    if mod(a-b,n) == x*y
                        P(1+a,1+b,1+x,1+y) = 1/n;
                    end
                end
            end   
        end
    end
% Two outputs
elseif n==2
    for a = 0:n-1
        for b = 0:n-1
            for x = 0:m-1
                for y = 0:m-1
                    if mod(a+b,2) == delta(x,1)*delta(y,1)
                        P(1+a,1+b,1+x,1+y) = 1/n;
                    end
                end
            end   
        end
    end
else % Other cases not known (to me)
    warning('PR box only implemented for 2 inputs or 2 outputs. Will return P = 0.')
end



end

function t = delta(a,b)
   if a==b
      t = 1;
   else
      t=0;
   end
end