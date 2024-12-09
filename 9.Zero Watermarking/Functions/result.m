function [AR] = result(W,VW,ZW,I0,I1,GT,VT,K)
[SZ1,SZ2]=size(W);
ERR=xor(W,VW)==1;
BER=sum(ERR(:))/(SZ1*SZ2);
W=logical(W);
NC=sum(sum(uint8(W).*VW))/sqrt(sum(sum(uint8(W).^2))*sum(sum(VW.^2)));
AR=1-BER;
[SZ3,SZ4,~]=size(I0);
PSNR=psnr(uint8(I0),uint8(imresize(I1,[SZ3,SZ4])));
figure;
subplot(121);imshow(uint8(I0));title('Original');
subplot(122);imshow(uint8(I1));title({'Attacked';['PNSR= ',num2str(PSNR),' dB']});
figure;
subplot(221);imshow(logical(W));title('Original');
subplot(222);imshow(logical(ZW));title('Zero-watermarking');
subplot(223);imshow(logical(VW));title('Retrieved');
subplot(224);imshow(logical(ERR));title({'Error';['BER= ',num2str(BER)]});
% clc;
disp(table([K;GT;VT;BER;AR;NC;PSNR],'RowNames',{'K';'GT';'VT';'BER';'AR';'NC';'PSNR'},'VariableNames',{'Value'}));

% filename = sprintf('��ת����45-%d.tif',NM);
% % % imwrite(uint8(I1),strcat('USCSIPI\Lena\I\�Ǽ���2��','.tiff'));
filename = sprintf('ZW.tif');
% imwrite(uint8(I1),fullfile('experiment imge', '3', '����ͼ��',filename), 'tif');
% imwrite(logical(VW),fullfile('experiment imge', '3', '���ˮӡ',filename), 'png');
% imwrite(logical(VW), fullfile('Whole Brain', 'VW', filename), 'tif');
% imwrite(logical(ZW), fullfile('Whole Brain', 'ZW', filename), 'tif');
% imwrite(logical(ERR), fullfile('Whole Brain', 'ERR', filename), 'tif');
% imwrite(logical(VW), fullfile('USCSIPI', 'VW', filename), 'tif');
% imwrite(logical(ZW), fullfile('USCSIPI', 'ZW', filename), 'tif');
% imwrite(logical(ERR), fullfile('USCSIPI', 'ERR', filename), 'tif');

% filename = sprintf('����0.5����.tif');
% filename1 = sprintf('����0.5���ˮӡ.tif');
%  imwrite(uint8(I1),filename)%���������ɵ�ͼƬ��
 imwrite(logical(ZW),filename)

end

