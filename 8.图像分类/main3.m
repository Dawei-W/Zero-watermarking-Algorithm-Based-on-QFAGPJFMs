%%  ��ֵͼ�� ��ת2�� 181�� ��������0~0.25  KNN=1
close all;
clear all;
clc; 
addpath(genpath(pwd));
dbstop if error
%% METHOD
VARrang=0.15:0.05:0.25;
% VARrang=0.25;
%%%%%��˹��������
MD={'1.PZM[1988]';'2.OFMM[1994]';'3.CHFM[2002]';'4.PJFM[2004]';'5.PCET[2010]';'6.GPCET[2014]';'7.FOFMM[2016]';'8.FCHFM[2019]';'9.FJFM-MLMF[QSR]';'10.PHFM[2019]';'11.FAG-PJFM[ours]'};for i=1:1:11, disp(MD{i}); end
MODE = input('Please select a mode (1 ~ 11): '); 
K = input('Please enter the maximum order K (K>=0): ');
if  K<0 
        disp('Error!');
        return;
end
if MODE==11
    NoF=(K+1)*(2*K+1)*5;
    h1=[0.25,0.5,1,2,4];
    alpha1=[5,10,15,20,50];
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
disp(['	SNR      ','   CCP(%)']);
flg=1;
UCCP=zeros(size(VARrang,2),1);
 for VAR=VARrang
% VAR=0.25;
%% training
[r,o]=ro(64,64);
pz1=r>1;
OBJ=26;
trainLabels =zeros(OBJ,1);
trainData=zeros(OBJ,NoF);

if MODE==11
    for i=1:1:OBJ
        I=imread(['Dateset\letters\training set\',num2str(i),'.tif']);
        I(pz1)=0;%%%%��λԲ��
        trainLabels(i,1)=i;     %%%%%ѵ����
        trainData(i, :) = hun_AGPJFM_D(double(I), K, alpha1, h1)'; %%%%ÿһ���Ǿطֽ�ϵ�����ɵ�ѵ��������
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
testLabels =zeros(OBJ*181,1);
testData=zeros(OBJ*181,NoF);   %%%%%һ��������һ��ͼ������ת��ͬ�Ƕ��µĲ�������

if MODE==11 
 for i=1:1:OBJ
    for j=0:1:180
        I=imread(['Dateset\letters\testing set\obj',num2str(i),'__',num2str(j),'.tif']);
%         NI=imnoise(I,'gaussian',0,0.05);   
        NI = imnoise(I, 'salt & pepper',VAR);
        imshow(uint8(abs(NI)));
        pz1=r>1;
        NI(pz1)=0;   %%%%%��λԲ��
%         imshow(uint8(abs(NI)));
        k=(i-1)*181+j+1;
        testLabels(k,1)=i;   %%%�ڼ���ͼ��
        testData(k, :) = hun_AGPJFM_D(double(NI), K, alpha1, h1)';  %%%%ÿһ������ֵ����ͼ�����ع��ɲ��Լ�����
    end
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
accuracy = length(find(label == testLabels))/(OBJ*181)*100;
UCCP(flg,1)=accuracy;
if mod(flg,2)==1
    disp(['	',num2str(VAR),'			',num2str(accuracy)]);
else
    disp(['	',num2str(VAR),'		    ',num2str(accuracy)]);
end
flg=flg+1;
close all;
end
beep;
        
