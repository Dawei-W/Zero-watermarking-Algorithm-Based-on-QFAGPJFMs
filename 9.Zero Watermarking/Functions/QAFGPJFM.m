function [Z]=QAFGPJFM(I,K,alpha,h)
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

%%%����fc
tic;
[ER] = AGPJFM_D(R,K,alpha,h);
[EG] = AGPJFM_D(G,K,alpha,h);
[EB] = AGPJFM_D(B,K,alpha,h);

%%%��ɫͼ����Ԫ��ָ����E��ʵ����3���鲿
mm = 1/sqrt(3);         %ǿ��ͼ��ʸ��
AE = -mm*(imag(ER)+imag(EG)+imag(EB)); 
CE = real(ER)+mm*imag(EG)-mm*imag(EB);
DE = -mm*imag(ER)+real(EG)+mm*imag(EB);
EE = mm*imag(ER)-mm*imag(EG)+real(EB);
Z=sqrt(AE.^2+EE.^2+CE.^2+DE.^2);
end
