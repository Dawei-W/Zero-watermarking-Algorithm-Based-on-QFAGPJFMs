% ����DICOMͼ���ļ�·��
filename = 'brain_014.dcm'; % �滻Ϊ���DICOM�ļ���ʵ��·��

% ʹ��dicomread������ȡͼ������
[I, hdr] = dicomread(filename);

% ��ȡͼ���Ԫ������Ϣ
info = dicominfo(filename);

% ��ʾͼ������
figure;
imshow(I, []);

% ��ʾͼ���Ԫ����
disp(info);

% ������ʾ�ض�����/֡��ͼ�񣨶��ڶ����л��֡��DICOM���ݣ�
% I_subset = dicomread(filename, 'Frames', frameIndices);

% ����frameIndices��Ҫ��ȡ��֡����б����� frameIndices = [1, 3, 5];

% ��Ҫ��ʾ����3D DICOMͼ������
% ����ʹ��montage��������volume�������鿴3D��ͼ
% montage(dicomread(filename, 'Index', 1 : size(hdr.ImagePositionPatient, 1)));

% ����
% volume(dicomread(filename));