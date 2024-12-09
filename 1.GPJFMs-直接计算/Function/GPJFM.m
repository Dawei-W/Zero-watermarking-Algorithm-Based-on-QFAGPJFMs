function [I,It,DT,RT] =GPJFM(I,K,alpha)
%% PRE
[N, M]  = size(I);
x       = -1+1/M:2/M:1-1/M;
y       = 1-1/N:-2/N:-1+1/N;
[X,Y]   = meshgrid(x,y);
[~, r]  = cart2pol(X, Y);
I(r>1)=0;
%% DE（分解）
tic;
X=GPJFM_D(I,K,alpha);
DT=toc;
%% RE（重构）
tic;
Y=GPJFM_R(I,X,K,alpha);
RT=toc;
It=abs(Y);
end

