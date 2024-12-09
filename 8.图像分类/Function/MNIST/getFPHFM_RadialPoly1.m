function [A_nm] = getFPHFM_RadialPoly1(I,Nmax)
% obtain the order and repetition
I = double(I);
[n,m] = size(I);
M = 4*n;
fp = zeros(M,M);
Gp = zeros(M,M);
for u = 1:M
    for v = 1:M
        rr = ((u-1)/M).^(1/2);
        ooo = (2*pi*(v-1))/M;
        kk = ceil(rr*(n/2)*sin(ooo));
        ll = ceil(rr*(n/2)*cos(ooo));
        fp(u,v) = I((-1)*kk+(n/2)+1,ll+(n/2));
        Gp(u,v) = fp(u,v).*(1/2);
    end
end
Ekm1 = fft2(Gp);
Ekm = Ekm1/(M^2);
E = zeros(2*Nmax+1,2*Nmax+1);
E(1:Nmax,1:Nmax) = Ekm(M-Nmax+1:M,M-Nmax+1:M);
E(1:Nmax,Nmax+1:2*Nmax+1) = Ekm(M-Nmax+1:M,1:Nmax+1);
E(Nmax+1:2*Nmax+1,1:Nmax) = Ekm(1:Nmax+1,M-Nmax+1:M);
E(Nmax+1:2*Nmax+1,Nmax+1:2*Nmax+1) = Ekm(1:Nmax+1,1:Nmax+1);


Rhf = zeros(Nmax+1,2*Nmax+1);
Rhf(1,:) = 2.*sqrt(2).*E(Nmax+1,:);
NNNN = Nmax+1;
for i=2:NNNN
    j = floor(i/2);
    if(mod(i,2)==0) %%% Rhf(n,m)=sqrt(-1)*(E(k,m)-E(-k,m))    n=2*k-1,k=1,2,...
        Rhf(i,:) =  2.*sqrt(-1).*(E(NNNN+j,:)-E(NNNN-j,:));
    else %%% Rhf(n,m)=E(k,m)+E(-k,m)               n=2*k  ,k=1,2,...
        Rhf(i,:) =  2.*(E(NNNN+j,:)+E(NNNN-j,:));
    end
end

%%%%%%%%  abs(n)+abs(m)<=K;选取特征值
Rhf1 = zeros(Nmax+1,2*Nmax+1);
for i=0:Nmax
    for j=-Nmax:Nmax
        if abs(i)+abs(j)<=Nmax
            Rhf1(i+1,j+Nmax+1) = Rhf(i+1,j+Nmax+1);
        end
    end
end
Rhf=Rhf1;
    

c = 1;
for k=1:(Nmax+1)
    for m=1:(2*Nmax+1)
        zmlist(c,1:2) = [k-1 m-Nmax-1];
        A_nm(c) = Rhf(k,m);
        c = c+1;
    end
end
A_nm=abs(A_nm');

X=find(A_nm==0);
A_nm(X)=[];
end