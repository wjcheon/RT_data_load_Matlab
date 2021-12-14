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

