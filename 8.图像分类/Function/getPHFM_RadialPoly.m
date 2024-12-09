function [t] = getPHFM_RadialPoly(K,rho)
% obtain the order and repetition
for x=1:K+1
    if x==1
        t{x} = (1/sqrt(2));
    elseif mod(x,2)==0
         t{x} = sin((x)*pi.*(rho.^2));
    else
         t{x} = cos((x-1)*pi.*(rho.^2));
    end
end
end