function [Z]=QAFGPJFM(I,K,alpha,h)
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
Z=sqrt(AE.^2+EE.^2+CE.^2+DE.^2);
end
