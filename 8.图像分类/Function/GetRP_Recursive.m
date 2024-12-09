function [output] = GetRP_Recursive(order,rho,alpha,h)
% obtain the order
n = order;
S=alpha;
if n>=2
    P0=sqrt(12*(rho.^h-(rho.^(2.*h))));
    P1=sqrt(12*(rho.^h-(rho.^(2.*h)))).*((S+5)*rho.^h-3);
    PN1=P1;PN2=P0;
    for s = 2:n
        L1=(((2*s+S+3)*(2*s+S+2))/((s+1)*(s+S+3)))*(sqrt((s+3)/s));
        L2=((((S+1)^2)-4-(2*s+S+3)*(2*s+S+1))/(2*(2*s+S+1)*(2*s+S+3)))*L1;
        L3=-(((s+S)*(s-1)*(s+1))/(s*(2*s+S+1)*(2*s+S+2)))*(sqrt((s+2)/(s-1)))*L1;
        PN=(L1.*(rho.^h)+L2).*PN1+L3.*PN2;
        PN2=PN1;
        PN1=PN;
    end
elseif n==1
    PN=sqrt(12*(rho.^h-(rho.^(2.*h)))).*((S+5)*rho.^h-3);
elseif n==0
    PN=sqrt(12*(rho.^h-(rho.^(2.*h))));
end
A=sqrt(((2*n+S+4)*(n+S+3))/(4*pi*(n+3)));
B=sqrt(((n+S+2)*h*((1-rho.^h).^alpha).*rho.^(2*h-2))./((n+2).^2));
output=A.*B.*PN;

end 