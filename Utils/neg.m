function n = neg(q)
%NEG Computes negativity of q. Can handle matrix q but assumes that each
%   column is separate q vector and so outputs vector of negativities.

n = - sum(min(q,zeros(size(q))),1);

end

