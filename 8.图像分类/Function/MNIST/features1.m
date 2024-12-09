function [A_nm] = features1(I,LE,BF,K)
Z= zeros(LE,1);
for i=1:1:LE
    temp = I.*BF{i};
    Z(i,1) = sum(temp(:));
end
Z=abs(Z);

ZZ=reshape(Z,K+1,2*K+1);
%%%%%%%%  abs(n)+abs(m)<=K;选取特征值
Rhf1 = zeros(K+1,2*K+1);
for i=0:K
    for j=-K:K
        if abs(i)+abs(j)<=K
            Rhf1(i+1,j+K+1) = ZZ(i+1,j+K+1);
        end
    end
end
%%%%%排成一列
c = 1;
for k=1:(K+1)
    for m=1:(2*K+1)
        A_nm(c) = Rhf1(k,m);
        c = c+1;
    end
end
X=find(A_nm==0);
A_nm(X)=[];
A_nm=A_nm';
% Z=(Z-min(Z))/(max(Z)-min(Z));
end
