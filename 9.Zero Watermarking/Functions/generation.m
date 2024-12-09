function [ZW,GT,K]=generation(I,W,K1,K2,K3)
tic;
% I=rgb2gray(I);
[~,~,SZ1]=size(I);
[SZ2,~]=size(W);
NoIT1=K1(1);a1=K1(2);b1=K1(3);
NoIT2=K2(1);a2=K2(2);b2=K2(3);
N=SZ2;x0=K3(1);mu=K3(2);
% K=2;
K=ceil((sqrt(SZ2*8/5)-4)/4);
UZ=cell(SZ2,5);
% alpha=[0,0,0,0,0];
alpha=[5,10,15,20,50];%%64
% alpha=[0,1,2,3,7];
% alpha=[5,10,15,20,25];
% alpha=[30,30,30,30,30];
% alpha=[10,15,50,70,100];
% h=[0.1,0.5,1,1.5,2];%%%%32
h=[0.25,0.5,1,2,4];

if SZ1==1
        for j=1:1:5
            ZZ{1,j} =AGPJFM_D(I,K,alpha(j),h(j));
        end
 
    for i=1:SZ2
        for j=1:5
        UZ{i,j} =ZZ{1,j};
        end
    end
elseif SZ1==3
        for j=1:1:5
           ZZ{1,j} = QAFGPJFM(I,K,alpha(j),h(j));
        end
%                disp(ZZ);
%         ZZ=[ZZ1;ZZ2;ZZ3;ZZ4];
    for i=1:SZ2
        for j=1:5
        UZ{i,j} =ZZ{1,j};
        end
    end
%         disp(UZ);

else
    return;
end
mask64_1=logical([0 0 0 0 0;0 0 0 0 0;1 0 0 0 1]);
mask64_2=logical([0 0 0 0 0;0 0 0 0 0;1 0 0 1 1]);
B=zeros(SZ2,SZ2);
level=zeros(SZ2,1);
if SZ2==64
    for i=1:1:SZ2
        Z1=UZ{i,1};Z2=UZ{i,2};Z3=UZ{i,3};Z4=UZ{i,4};Z5=UZ{i,5};
%        disp(Z4); disp(Z5);
        Z1(mask64_1)=[];Z2(mask64_1)=[];Z3(mask64_1)=[];Z4(mask64_1)=[];Z5(mask64_2)=[];
        Z=abs([Z1,Z2,Z3,Z4,Z5]);

        level(i,1)=mean(Z);
        B(i,:)=Z;
    end
elseif SZ2==32
    for i=1:1:SZ2
        Z1=UZ{i,1};Z2=UZ{i,2};Z3=UZ{i,3};Z4=UZ{i,4};Z5=UZ{i,5};
        Z1=reshape(Z1,1,[]);Z2=reshape(Z2,1,[]);Z3=reshape(Z3,1,[]);Z4=reshape(Z4,1,[]);Z5=reshape(Z5,1,[]);
        Z=abs([Z1,Z2,Z3,Z4,Z5,0,0]);
%                 disp(Z);
        level(i,1)=mean(Z);
        B(i,:)=Z;
    end
end
% disp(level);
% disp(B);
melevel=median(level);
B=B>melevel;
W=logical(W);
B=logical(B);
[map]=AsymmetricTentMap(N,x0,mu);
map=uint8(floor(map.*SZ2));
for i=2:1:SZ2
    if mod(i,3)==2
        temp=zeros(1,SZ2);
        temp(1:end-map(i))=B(i,map(i)+1:end);
        B(i,:)=temp;
    elseif mod(i,3)==0
        temp=zeros(1,SZ2);
        temp(end-map(i):end)=B(i,1:map(i)+1);
        B(i,:)=temp;
    elseif mod(i,3)==1 
        temp=circshift(B(i,:)',map(i));
        B(i,:)=temp';
    else
        return;
    end
end
[WS] = Arnold_Scrambling(W,a1,b1,NoIT1);
[BS] = Arnold_Scrambling(B,a2,b2,NoIT2);
imwrite(logical(W),'W.png');
imwrite(logical(B),'B.png');
imwrite(logical(WS),'WS.png');
imwrite(logical(BS),'BS.png');
ZW=xor(BS,WS);
imwrite(ZW,'ZW.png');
GT=toc;
end

