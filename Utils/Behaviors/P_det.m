function [P] = det_prob(n,m,f,g)
%DET_PROB Summary of this function goes here
%   Detailed explanation goes here
P = zeros(n,n,m,m);


for a = 0:n-1
    for b = 0:n-1
        for x = 0:m-1
            for y = 0:m-1
                if mod(floor(f/n^(m-x-1)),n) == a & mod(floor(g/n^(m-y-1)),n) == b 
                    P(a+1,b+1,x+1,y+1) = 1;
                end
            end
        end
    end
end

end


