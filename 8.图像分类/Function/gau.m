function [output]= gau(I,order,S,h)
[N,~]=size(I);
U=ceil(N/2);
V=ceil((2*U-1)*4);
R=ones(U,V);
RR=ones(U,V);


G=[0.0666713443 0.1494513492 0.2190863625 0.2692667193 0.2955242247 0.2955242247 0.2692667193 0.2190863625 0.1494513492 0.0666713443];
Z=[-0.9739065285 -0.8650633667 -0.6794095683 -0.4333953941 -0.1488743390 0.1488743390 0.4333953941 0.6794095683 0.8650633667 0.9739065285];
for u=1:1:U
    for v=1:1:(2*u-1)*4
          R(u,v)=(u-1)/U;
          RR(u,v)=u/U;
    end
end
 
A=(R-RR)/2;B=(R+RR)/2;

for i=1:1:10
    rho{i}=A.*Z(i)+B;
    T{i}=rho{i}.*GetRP_Recursive(order,rho{i},S,h);
    output{i}=G(i).*T{i};
end
 output=A.*(output{1}+output{2}+output{3}+output{4}+output{5}+output{6}+output{7}+output{8}+output{9}+output{10});
 
end

