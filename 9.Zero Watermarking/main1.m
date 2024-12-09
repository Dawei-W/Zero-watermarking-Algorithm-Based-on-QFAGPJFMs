close all;
clear all;
clc;
warning('off'); 
 addpath(genpath(pwd));
dbstop if error
%% KEY
c=1;
for ky=0.51:0.001:0.6
K1=[10,2,3];
K2=[5,1,2];
K3=[0.5,0.45];
K31=[ky,0.45];

%% INPUT

% I0=imread(['Images\Coil100\','5.png']);
I0=imread('lena.tif');
W=imread('logo64.bmp');
% I1 = imattack(I0);

%% ZERO-WATERMARK GENERATION
[ZW,GT,K]=generation(I0,W,K1,K2,K3);
% [ZW,GT,K]=generation(I0,W,K1,K2,K3);

%% ZERO-WATERMARK VERIFICATION UNDER ATTACK

I1 = imread('lena.tif');
% I1 = imattack(I0);
[VW,VT]=verification(I1,ZW,K1,K2,K31);

%% OUTPUT

zhenzhuang(c)=result(W,VW,ZW,I0,I1,GT,VT,K);
c=c+1;
end

