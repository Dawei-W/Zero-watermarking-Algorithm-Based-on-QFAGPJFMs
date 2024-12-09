%%
close all;
clear all;
clc; 
dbstop if error
warning('off'); 
addpath(genpath(pwd));
%% INPUT
alpha=10;
for K=5:5:50
I=imread('lena.tif');
%% MODE
%K = input('Please enter the maximum order K (K>=0): ');
%alpha=input('请输入广义参数alpha(整数)=');
%% COMPUTE

if K>=0 && alpha>-1
    [I,It,L,DT,RT ]=AGPJFM(I,K,alpha);
    [N, M]  = size(I);
    x       = -1+1/M:2/M:1-1/M;
    y       = 1-1/N:-2/N:-1+1/N;
    [X,Y]   = meshgrid(x,y);
    [~, r]  = cart2pol(X, Y);
    I(r>1)=0;
else
    disp('Error!');
    return;
end
%% OUTPUT
figure;
subplot(121);
imshow(uint8(abs(I)));
title('Original');
subplot(122);
imshow(uint8(abs(It)));
%filename = sprintf('alpha-%g-K-%g.png', alpha, K);
%imwrite(uint8(abs(It)),filename)%（保存生成的图片）
%imwrite(uint8(abs(It)),'50-90.png')（保存生成的图片）
different_a = (abs(abs( double(abs(It))-double(I)))).^2;
different_b = (double(I)).^2;
MSRE = sum(different_a(:))/sum(different_b(:));

disp(table([K;L;DT;RT;MSRE],'RowNames',{'K';'L';'DT';'RT';'MSRE'},'VariableNames',{'Value'}));
title({'Reconstructed'; ['K=',num2str(K),'  L=',num2str(L),'  MSRE=',num2str(MSRE)]});
end

