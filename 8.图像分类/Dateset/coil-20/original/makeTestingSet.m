clc;
close all;
clear;
addpath(genpath(pwd));
for i=1:1:20
    I=imread(['original\core\obj',num2str(i),'__0','.png']);
    for r=0:10:360
        II=imrotate(I,r,'bicubic','crop');
        SS=0.5+(1.5*r)/360;
        III=imresize(II,SS,'bilinear');
        imwrite(uint8(III),['testing set\obj',num2str(i),'__',num2str(r/10),'.png'])
    end
end