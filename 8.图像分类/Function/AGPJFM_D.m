%%%%%%%%����ڲ�ֵ������������ں���hua�У�Ҳ����ѡ���������ӵĲ�ֵ������
function [ A_nm ] = AGPJFM_D(img,maxorder,alpha,h)
%�ֽ�
I = double(img);
[m,n] = size(I);
V=4;  %�ֳ��Ĵ��
U=ceil(n/2);  %һ��u��
uu=ceil((n-1)*V);
G = zeros(U,uu);
theta1 = zeros(U,uu);
theta2 = zeros(U,uu);
[G,theta1,theta2]=hua(I,m,n,V,U,G,theta1,theta2);
c=1;
for order=0:1:maxorder
    gauu=gau(I,order,alpha,h);
    for repetition=-maxorder:1:maxorder
          if repetition==0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
              pupil =(theta2-theta1);
        else
              pupil =1j/repetition.*(exp(-1j*repetition*theta2)-exp(-1j*repetition*theta1));
        end
       Product1=  pupil.*gauu;
        Product = double(G).*  Product1;
       output(order+1,repetition+maxorder+1)=sum(Product(:));
      A_nm(c) =output(order+1,repetition+maxorder+1);
      c=c+1;
    end
end
A_nm=abs(A_nm);
end