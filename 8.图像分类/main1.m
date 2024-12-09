%%    KNN=1
close all;
clear all;
clc; 
addpath(genpath(pwd));
dbstop if error
%% METHOD
MD={'1.PZM[1988]';'2.OFMM[1994]';'3.CHFM[2002]';'4.PJFM[2004]';'5.PCET[2010]';'6.GPCET[2014]';'7.FOFMM[2016]';'8.FCHFM[2019]';'9.FJFM-MLMF[QSR]';'10.PHFM[2019]';'11.FAG-PJFM[ours]'};for i=1:1:11, disp(MD{i}); end
MODE = input('Please select a mode (1 ~ 11): '); 
K = input('Please enter the maximum order K (K>=0): ');
if  K<0 
        disp('Error!');
        return;
end
if MODE==11
    NoF=(K+1)*(2*K+1);
%     h=0.5;
    alpha=1;
else
    [BF,NoF,p,q,alpha]=getBF(MODE,128,128,K);  %%%%%BF����ֵ  NoF����ֵ����
end
clc;
if MODE==6 || MODE==7 || MODE==8
    disp([MD{MODE},' (alpha=',num2str(alpha),')']);
elseif MODE==9
    disp([MD{MODE},' (p=',num2str(p),',q=',num2str(q),')']);
else
    disp(MD{MODE});
end  
disp(table([K;NoF],'RowNames',{'K';'NoF'},'VariableNames',{'Value'}));
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp(['	��д���ݼ�MNIST      ','   CCP(%)']);
flg=1;
UCCP=zeros(1,1);
%% ���ݼ�׼��
trainimage=loadMNISTImages('train-images.idx3-ubyte');
testimage=loadMNISTImages('t10k-images.idx3-ubyte');
%% training
[r,o]=ro(28,28);
pz1=r>1;
trainsum=length(trainimage);
trainLabels= loadMNISTLabels('train-labels.idx1-ubyte');%%%%%ѵ�����ݼ���ǩ
trainData=zeros(trainsum,NoF);
if MODE==11
    for i=1:1:trainsum
        I=trainimage(:, i);
        II=reshape(I,28,28);
               
        imshow(II);

        II(pz1)=0;%%%%��λԲ��
%         trainData(i, :) = AGPJFM_D(double(II), K, alpha, h)';  %%%%ÿһ���Ǿطֽ�ϵ�����ɵ�ѵ��������
         trainData(i, :) = GPJFM_D(double(II),K,alpha)';
   end
else
for i=1:1:OBJ
        I=imread(['Dateset\letters\training set\',num2str(i),'.tif']);
        I(pz1)=0;%%%%��λԲ��
        trainLabels(i,1)=i;     %%%%%ѵ����
        trainData(i,:)=features(double(I),NoF,BF)'; %%%%ÿһ���Ǿطֽ�ϵ�����ɵ�ѵ��������
end
end
%% testing
testsum=length(testimage);
testLabels =loadMNISTLabels('t10k-labels.idx1-ubyte');
testData=zeros(testsum,NoF);   %%%%%һ��������һ��ͼ������ת��ͬ�Ƕ��µĲ�������

if MODE==11 
 for i=1:1:testsum
        I=testimage(:, i);
        II=reshape(I,28,28);
        
        II(pz1)=0;   %%%%%��λԲ��
%         testData(i, :) = AGPJFM_D(double(II), K, alpha, h)';   %%%%ÿһ������ֵ����ͼ�����ع��ɲ��Լ�����
         testData(i, :) = GPJFM_D(double(II),K,alpha)';
end
else
for i=1:1:OBJ
    for j=0:1:180
        I=imread(['Dateset\letters\testing set\obj',num2str(i),'__',num2str(j),'.tif']);
%         NI=imnoise(I,'gaussian',0,VAR);   
%         NI = imnoise(I, 'salt & pepper',VAR);
        NI(pz1)=0;   %%%%%��λԲ��
        k=(i-1)*181+j+1;
        testLabels(k,1)=i;   %%%�ڼ���ͼ��
        testData(k,:)=features(double(NI),NoF,BF)';    %%%%ÿһ������ֵ����ͼ�����ع��ɲ��Լ�����
    end
end
end
%% OUTPUT
Mdl = fitcknn(trainData,trainLabels,'NumNeighbors',1);     %%%KNN
label = predict(Mdl,testData);     %%%%%����Ԥ��
accuracy = length(find(label == testLabels))/testsum*100;
UCCP(flg,1)=accuracy;
if mod(flg,2)==1
    disp(num2str(accuracy));
else
    disp(num2str(accuracy));
end
flg=flg+1;
close all;
beep;
        
