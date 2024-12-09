% 定义DICOM图像文件路径
filename = 'brain_014.dcm'; % 替换为你的DICOM文件的实际路径

% 使用dicomread函数读取图像数据
[I, hdr] = dicomread(filename);

% 获取图像的元数据信息
info = dicominfo(filename);

% 显示图像数据
figure;
imshow(I, []);

% 显示图像的元数据
disp(info);

% 若需显示特定序列/帧的图像（对于多序列或多帧的DICOM数据）
% I_subset = dicomread(filename, 'Frames', frameIndices);

% 其中frameIndices是要读取的帧序号列表，例如 frameIndices = [1, 3, 5];

% 若要显示的是3D DICOM图像序列
% 可以使用montage函数或者volume函数来查看3D视图
% montage(dicomread(filename, 'Index', 1 : size(hdr.ImagePositionPatient, 1)));

% 或者
% volume(dicomread(filename));