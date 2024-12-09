%%
close all;
clear all;
clc; 
addpath(genpath(pwd));
%% INPUT
alpha=10;
for K=5:5:50
I=imread('lena.tif');
%% MODE
% K = input('Please enter the maximum order K (K>=0): ');
% alpha=input('alpha(整数)=');
%% COMPUTE
if K>=0 && alpha>-1
    [I,It,DT,RT ]=GPJFM(I,K,alpha);
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
%imwrite(uint8(abs(It)),'30-90.png')用来保存生成的图片
different_a = (abs(abs( double(abs(It))-double(I)))).^2;
different_b = (double(I)).^2;
MSRE = sum(different_a(:))/sum(different_b(:));
disp(table([alpha;K;DT;RT;MSRE],'RowNames',{'alpha';'K';'DT';'RT';'MSRE'},'VariableNames',{'Value'}));
% clc;
% title({'Reconstructed'; ['K=',num2str(K),'  MSRE=',num2str(MSRE)]});
end
