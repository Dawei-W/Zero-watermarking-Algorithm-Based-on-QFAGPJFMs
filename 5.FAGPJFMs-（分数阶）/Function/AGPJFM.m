function [I,It,L,DT,RT] =AGPJFM(I,K,alpha,h)
%% PRE
%[N, M]  = size(I);
%x       = -1+1/M:2/M:1-1/M;
%y       = 1-1/N:-2/N:-1+1/N;
%[X,Y]   = meshgrid(x,y);
%[~, r]  = cart2pol(X, Y);
%I(r>1)=0;
%% DE（分解）
tic;
X=AGPJFM_D(I,K,alpha,h);
DT=toc;
[L,~]=size(find(X~=0));
%% RE（重构）
tic;
Y=AGPJFM_R(I,X,K,alpha,h);
RT=toc;
It=abs(Y);
end

