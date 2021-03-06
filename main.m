% Wonjoong Cheon, Ph.D
% wonjoongcheon@gmail.com 
clc
clear
close all
%%
addpath('dicom_tools')

CTimageList = dir(fullfile("D:\RT-data", "*.dcm"))
RDfile = CTimageList(155);
RDfile_relative = CTimageList(156);
DPfile = CTimageList(157);
RSfile = CTimageList(158);
CTimageList(155) = []
CTimageList(155) = []
CTimageList(155) = []
CTimageList(155) = []
%%
% CT Image 
CtImagePath = "D:\RT-data"
CtImageNames = {CTimageList(:).name}
image = LoadDICOMImages(CtImagePath, CtImageNames);

% Rt-structure
RtstName = RSfile.name;
structures = LoadDICOMStructures(CtImagePath, RtstName, image);
image.structures = structures;  % the loaded rt-structure was inserted to the image structure

% RdName = RDfile_relative.name
RdName = RDfile.name;
dose = LoadDICOMDose(CtImagePath, RdName);

dest = 'dvh.csv';
WriteDVH(image, dose, dest)  % Cummulataive mode was only supported. 
dvh = WriteDVH(image, dose, dest);
%
for k = 1:numel(structures)
    structures_name{k} = structures{k}.name
end

figure, hold on
x_axis = dvh(:, end)
for iter1 = 1: numel(structures)
    plot(x_axis , dvh(:,iter1))
end

xlabel('Absolute dose [Gy]')
ylabel('Relative volume [%]')
ylim([0, 100])
xlim([0, max(x_axis)])
legend(structures_name)
grid on