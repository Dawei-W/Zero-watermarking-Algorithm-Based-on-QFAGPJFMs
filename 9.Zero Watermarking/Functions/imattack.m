function I1 = imattack(I0)

% % % �������Ͻ�
% [SZ1,SZ2,~]=size(I0);
%   I1=I0;
%     L1=floor(SZ1*(1/2));
%     L2=floor(SZ2*(1/2));
%     I1(1:L1,1:L2,:)=0;

%%%%�ı�����
% I2=I0+10;
% I2(I0 < 0) = 0;
% I2(I0> 255) = 255;
% I1=I2;

%%%%��תͼ��(���)Vertical flipping   I1= flip(I0);

%%%��ת������
% I1=imrotate(I0,5,'bicubic');
% [n,m,~]=size(I0);
% I1=imresize(I1,[n,m]);


I1=imrotate(I0,1,'bicubic','crop');

% I1=imrotate(I0,1,'bicubic','loose');

% I1=imresize(I0,0.25,'bicubic');    %%%%���ź�ԭ
% I1=imresize(I0,4,'bicubic');    %%%%���ź�ԭ

% [n,m,~]=size(I0);
% I1=imresize(I1,[n,m]);

%��ֵ�˲�
% H=fspecial('average',[3 3]);
% I1=imfilter(I0,H);


%%��ֵ�˲�3*3
% SZ=3;
% I1R=medfilt2(I0(:,:,1),[SZ SZ]);
% I1G=medfilt2(I0(:,:,2),[SZ SZ]);
% I1B=medfilt2(I0(:,:,3),[SZ SZ]);
% I1=I0;
% I1(:,:,1)=I1R;
% I1(:,:,2)=I1G;
% I1(:,:,3)=I1B;

% % ��ֵһ
% R_data =    I0(:,:,1);
% G_data =    I0(:,:,2);
% B_data =   I0(:,:,3);
% %% Arithmetic mean filter for Gaussian noise
% a=[1 1 1;1 1 1;1 1 1];
% l=1/9*a;
% R_filter = conv2(double(R_data),double(l));R_cut = R_filter(2:257,2:257);
% G_filter = conv2(double(G_data),double(l));G_cut = G_filter(2:257,2:257);
% B_filter = conv2(double(B_data),double(l));B_cut = B_filter(2:257,2:257);
% 
% image_filter(:,:,1) = R_cut;
% image_filter(:,:,2) = G_cut;
% image_filter(:,:,3) = B_cut;
% 
% I1 = uint8(image_filter);

% I1 = medfilt2(I0, [5 5]);
%    I1=medfilt3(I0,[3 3 3]);  %%%��һ����ֵ�˲�������ͼ��
%%��˹ģ�����˲���
% H=fspecial('gaussian',[5,5],1.2);
% I1=imfilter(I0,H);

% I1 = imnoise(uint8(I0),'salt & pepper',0.03);
%   I1=imnoise(I0,'gaussian',0,0.03);%%����һ�ָ�˹����
% I1 = imnoise(uint8(I0),'gaussian',0.01);
% I1 = imnoise(uint8(I0),'poisson');%%��������
% I1=imnoise(I0,'speckle',0.005);%%%%speckle����
%%%%%ѹ��
% imwrite(uint8(I0),'ѹ����ʱ.jpg','jpg','Quality',10);
% I1 = imread('ѹ����ʱ.jpg','jpg');

%%%��
% H=[0,-1,0;-1,5,-1;0,-1,0];
% I1= imfilter(I0,H,'replicate');
%%%�Դ��񻯺���
% I1=imsharpen(I0, 'Radius', 1, 'Amount', 0.6, 'Threshold', 0.02);
% [SZ1,SZ2,~]=size(I0);
% Q=1/8;
% L1=SZ1*Q;L2=SZ2*Q;
% % L1=64;L2=64;
% I1=I0;
% I1(1:L1,:,:)=0;I1(end-L1:end,:,:)=0;I1(:,1:L2,:)=0;I1(:,end-L2:end,:)=0;

% [SZ1,SZ2,~]=size(I0);
% % Q=1/6;
% L1=64;L2=64;
% I1=I0;
% I1(SZ1/2-L1:SZ1/2+L1,SZ2/2-L2:SZ2/2+L2,:)=0;

% [SZ1,SZ2,~]=size(I0);
% RN=floor(SZ1*rand(1,6));
% RM=floor(SZ2*rand(1,6));
% I1=I0;
% I1(RN,:,:)=[];I1(:,RM,:)=[];
% I1=imresize(I1,[SZ1,SZ2]);


% % ��Ե����1/4
% [SZ1,SZ2,~]=size(I0);
% Q=1/8;
% L1=SZ1*Q;L2=SZ2*Q;
% I1=I0;
% I1(1:L1,:,:)=0;I1(end-L1:end,:,:)=0;I1(:,1:L2,:)=0;I1(:,end-L2:end,:)=0;
% 
%%%Histogram equalizationֱ��ͼ���⻯
% I1R=histeq(I0(:,:,1),256);
% I1G=histeq(I0(:,:,2),256);
% I1B=histeq(I0(:,:,3),256);
% I1=I0;
% I1(:,:,1)=I1R;
% I1(:,:,2)=I1G;
% I1(:,:,3)=I1B;


%ά���˲�
% SZ=3;
% I1R=wiener2(I0(:,:,1),[SZ SZ]);
% I1G=wiener2(I0(:,:,1),[SZ SZ]);
% I1B=wiener2(I0(:,:,1),[SZ SZ]);%��I1����ά���˲� 
% I1=I0;
% I1(:,:,1)=I1R;
% I1(:,:,1)=I1G;
% I1(:,:,1)=I1B;
% end

