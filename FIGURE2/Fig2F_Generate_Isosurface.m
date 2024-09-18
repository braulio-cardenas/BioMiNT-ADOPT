clear;
clc;
close all;

[file,path] = uigetfile('*.tif'); %select file

N = 800; %number of frames to read
fs = 150; %frames/s
filename = "MovieS4.gif";

% Slice noise removal:
[projections,original_projections] = Denoise_Projections(file,path,N,fs);


load('Fig2F.mat', 'vol3D');

% Visualize 3D reconstruction:
Visualize_3D_reconstruction(vol3D,filename);
