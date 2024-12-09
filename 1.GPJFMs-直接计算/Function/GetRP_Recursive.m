function [output] = GetRP_Recursive(order,rho,alpha)
% obtain the order
n = order;
output= zeros(size(rho));
S=alpha;
for k = 0:n
     %c = (((-1)^(k))*factorial(2*n+S+3-k)) / (factorial(k)*factorial(n-k)*factorial(n+2-k));
   % output = output + c * rho .^ (n-k);
   c = (((-1)^(k))*factorial(S+n+k+3)) / (factorial(k)*factorial(n-k)*factorial(k+2));
   output = output + c * rho .^ (k);
end
output=((-1).^(n)*sqrt((1/2)*(n+1)*((n+2).^3)*(n+3)*(rho-rho.^2))).*((factorial(n)*2)/factorial(S+n+3)).*output;
   % output=output.*sqrt(2*(n+1)*(n+2)*(n+3)*(rho-rho.^2)).*(((n+S+4)*(-S-1))/(n+1));
A=sqrt(((2*n+S+4)*(n+S+3))/(4*pi*(n+3)));
B=sqrt(((n+S+2).*((1-rho).^S))./((n+2)^2));
output=A.*B.*output;

end 