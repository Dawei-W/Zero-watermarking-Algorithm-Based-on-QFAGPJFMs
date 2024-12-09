%%
close all;
clear all;
clc; 
dbstop if error
warning('off'); 
addpath(genpath(pwd));
save=zeros(4,5);
qw=1;
%% INPUT
alpha=10;
 h=1.5;
 for K=5:5:100
%        for K=10:10:100
%     for NM=1:1:18
% I=imread([sprintf('%d', NM), '.png']);
I=imread('lena128.png');
[SZ,~]=size(I);
%% MODE
% K = input('Please enter the maximum order K (K>=0): ');
% alpha=input('请输入广义参数alpha(整数)=');
% h=input('请输入分数阶参数h=');

%%%%%%%%%%%%%R,G,B分量
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

%%%计算fc
tic;
[ER] = AGPJFM_D(R,K,alpha,h);
[EG] = AGPJFM_D(G,K,alpha,h);
[EB] = AGPJFM_D(B,K,alpha,h);

%%%彩色图像四元数指数矩E的实部和3个虚部
mm = 1/sqrt(3);         %强度图像矢量
AE = -mm*(imag(ER)+imag(EG)+imag(EB)); 
CE = real(ER)+mm*imag(EG)-mm*imag(EB);
DE = -mm*imag(ER)+real(EG)+mm*imag(EB);
EE = mm*imag(ER)-mm*imag(EG)+real(EB);
% Z=sqrt(AE.^2+EE.^2+CE.^2+DE.^2);
% Z00(NM,1)=Z(1,2);
% Z01(NM,1)=Z(1,3);
% Z11(NM,1)=Z(2,2);
% disp(Z);
DT=toc;
tic;
%%图像重构
AE1 = AGPJFM_R(R,AE,K,alpha,h);
CE1 = AGPJFM_R(R,CE,K,alpha,h);
DE1 = AGPJFM_R(R,DE,K,alpha,h);
EE1 = AGPJFM_R(R,EE,K,alpha,h);
fa = real(AE1)-mm*imag(CE1)-mm*imag(DE1)-mm*imag(EE1);
fc = mm*imag(AE1)+real(CE1)+mm*imag(DE1)-mm*imag(EE1);
fd = mm*imag(AE1)-mm*imag(CE1)+real(DE1)+mm*imag(EE1);
fe = mm*imag(AE1)+mm*imag(CE1)-mm*imag(DE1)+real(EE1);
rimg(:,:,1) = fc;
rimg(:,:,2) = fd; 
rimg(:,:,3) = fe;
RT=toc;

[r,~]=ro(SZ,SZ);
pz=r>1;
IR=I(:,:,1); IG=I(:,:,2); IB=I(:,:,3);
IR(pz)=0; IG(pz)=0; IB(pz)=0;
I(:,:,1)=IR; I(:,:,2)=IG; I(:,:,3)=IB; 
%% OUTPUT
% figure;
% subplot(121);
% imshow(uint8(abs(I)));
% title('Original');
% subplot(122);
% imshow(uint8(abs(rimg)));
% folder = '重构结果图像';
% filename = sprintf('alpha=%g-h=%g-K=%g.png', alpha, h, K);
% fullpath = fullfile(folder, filename);
% imwrite(uint8(abs(rimg)), fullpath);

filename = sprintf('alpha-%g-h-%g-K-%g.png', alpha, h, K);
imwrite(uint8(abs(rimg)),filename)%（保存生成的图片）

% different_ar = (abs(abs( double(abs(rimg(:,:,1)))-double(I(:,:,1))))).^2;
% different_br = (double(I(:,:,1))).^2;
% MSRE_r = sum(different_ar(:))/sum(different_br(:));
% 
% different_ag = (abs(abs( double(abs(rimg(:,:,2)))-double(I(:,:,2))))).^2;
% different_bg = (double(I(:,:,2))).^2;
% MSRE_g = sum(different_ag(:))/sum(different_bg(:));
% 
% different_ab = (abs(abs( double(abs(rimg(:,:,3)))-double(I(:,:,3))))).^2;
% different_bb = (double(I(:,:,3))).^2;
% MSRE_b = sum(different_ab(:))/sum(different_bb(:));
% MSRE=(MSRE_r+MSRE_g+MSRE_b)/3;
different_a = (abs(abs( double(abs(rimg))-double(I)))).^2;
different_b = (double(I)).^2;
MSRE = sum(different_a(:))/sum(different_b(:));

save(1,qw)=K;
save(2,qw)=DT;
save(3,qw)=RT;
save(4,qw)=MSRE;
qw=qw+1;
disp(table([alpha;h;K;DT;RT;MSRE],'RowNames',{'alpha';'h';'K';'DT';'RT';'MSRE'},'VariableNames',{'Value'}));
title({'Reconstructed'; ['  Alpha=',num2str(alpha),'  H=',num2str(h),'K=',num2str(K),' MSRE=',num2str(MSRE)]});
 end
  
