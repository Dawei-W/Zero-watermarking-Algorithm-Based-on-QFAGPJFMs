clc;
close all;
clear;
addpath(genpath(pwd));
for i=1:1:26
    I=imread(['original\core\',num2str(i),'.tif']);
    for r=0:2:360
        II=imrotate(I,r,'bicubic','crop');
        imwrite(uint8(II),['testing set\obj',num2str(i),'__',num2str(r/2),'.tif'])
    end
end