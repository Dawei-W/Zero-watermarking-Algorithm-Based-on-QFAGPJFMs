close all;
clear all;
clc;
warning('off'); 
 addpath(genpath(pwd));
dbstop if error
%% KEY
% for NM=1:1:18
K1=[10,2,3];
K2=[5,1,2];
K3=[0.5,0.45];

%% INPUT
% I0 = imread(['Images\xia2019\', sprintf('%d', NM), '.tif']);
% I0 = I0(:,:,1:3);  % 只保留前三个颜色通道分量
I0=imread('lena.tif');
% I2=imresize(I0,[144,144]);
% imwrite(uint8(I0),'123.tif');
% I0=imread('lena.tif');
% W=imread('W.bmp');
W=imread('logo64.bmp');
% W=imread('QR2_2.png');
% W= W(:,:,1);
% I1 = imattack(I0);

%% ZERO-WATERMARK GENERATION
% [ZW,GT,K]=generation(I0,W,K1,K2,K3);
  [ZW,GT,K]=generation(I0,W,K1,K2,K3);

%% ZERO-WATERMARK VERIFICATION UNDER ATTACK

% I1 = imread('0.tif');
I1 = imattack(I0);
% I3=imresize(I1,[144,144]);
[VW,VT]=verification(I1,ZW,K1,K2,K3);

%% OUTPUT

% result(NM,W,VW,ZW,I0,I1,GT,VT,K);
 result(W,VW,ZW,I0,I1,GT,VT,K);
% end
