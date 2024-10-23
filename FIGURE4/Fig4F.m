clear;
clc;
close all;

SNR_var = linspace(0.3,1.5,128);

figure,

load('cut_off_1Hz_param.mat');
plot(SNR_var, SNR_var, '--', 'color', [0.5, 0.5, 0.5]); hold on;
plot(SNR_input, SNR_output, '-o', 'MarkerFaceColor', 'w');

load('cut_off_2Hz_param.mat');
plot(SNR_input, SNR_output, '-o', 'MarkerFaceColor', 'w');

load('cut_off_5Hz_param.mat');
plot(SNR_input, SNR_output, '-o', 'MarkerFaceColor', 'w');

load('cut_off_10Hz_param.mat');
plot(SNR_input, SNR_output, '-o', 'MarkerFaceColor', 'w');

load('cut_off_20Hz_param.mat');
plot(SNR_input, SNR_output, '-o', 'MarkerFaceColor', 'w');

load('cut_off_50Hz_param.mat');
plot(SNR_input, SNR_output, '-o', 'MarkerFaceColor', 'w');

legend({'', '1 Hz', '2 Hz', '5 Hz', '10 Hz', '20 Hz', '50 Hz'});

xlabel('SNR input projection');
ylabel('SNR output projection');