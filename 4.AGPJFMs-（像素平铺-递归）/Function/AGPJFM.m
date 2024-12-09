function [I,It,L,DT,RT,t] =AGPJFM(I,K,alpha)
%% PRE
%[N, M]  = size(I);
%x       = -1+1/M:2/M:1-1/M;
%y       = 1-1/N:-2/N:-1+1/N;
%[X,Y]   = meshgrid(x,y);
%[~, r]  = cart2pol(X, Y);
%I(r>1)=0;
%% DE���ֽ⣩
tic;
[X,t]=AGPJFM_D(I,K,alpha);
DT=toc;
[L,~]=size(find(X~=0));
%% RE���ع���
tic;
Y=AGPJFM_R(I,X,K,alpha);
RT=toc;
It=abs(Y);
end

