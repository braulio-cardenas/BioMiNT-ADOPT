clear;
clc;
close all;

load("Fig3G.mat")

figure,

area(R_x_resample, SNR_R_avg + SNR_R_std/sqrt(3), 'EdgeColor','r', 'FaceColor','r','FaceAlpha',.1, 'LineStyle','--'); hold on;
area(R_x_resample, SNR_R_avg, 'EdgeColor','none', 'FaceColor', [1 1 1]);

area(R_x_resample, SNR_R_avg, 'EdgeColor','r', 'FaceColor','r','FaceAlpha',.1); hold on;
area(R_x_resample, SNR_R_avg - SNR_R_std/sqrt(3) , 'EdgeColor','r', 'FaceColor', [1 1 1], 'LineStyle','--');

semilogy(R_x_resample, SNR_R_avg, 'color', [0.4 0.4 0.4], 'LineWidth',1);  hold on;

area((1:numel(M2))./numel(M2), SNR_Z_avg + SNR_Z_std/sqrt(3), 'EdgeColor','b', 'FaceColor','b','FaceAlpha',.1, 'LineStyle','--'); hold on;
area((1:numel(M1))./numel(M1), SNR_Z_avg, 'EdgeColor','none', 'FaceColor', [1 1 1]);

area((1:numel(M1))./numel(M1), SNR_Z_avg, 'EdgeColor','b', 'FaceColor','b','FaceAlpha',.1); hold on;
area((1:numel(M3))./numel(M3), SNR_Z_avg - SNR_Z_std/sqrt(3) , 'EdgeColor','b', 'FaceColor', [1 1 1], 'LineStyle','--');

semilogy((1:numel(M1))./numel(M1), SNR_Z_avg, 'k', 'LineWidth',1);  hold on;

ylim([0.1 10]);
set(gca,'yscale', 'log')

XTickPositions = 0:0.1:1;

XLimits = [0 1];

YLimits = [0.1 10];

h = gca;

[XTicksStrs] = tickLabelAlternated(XTickPositions);

set(gca,'XTick',XTickPositions);
set(gca,'XLim',XLimits);
set(gca,'XTickLabel',XTicksStrs);

set(gca,'linewidth',1);
set(gca,'TickDir','out');
set(gca, 'fontsize', 22);
box('off')

h.YAxis.FontSize = 22;
h.XAxis.FontSize = 22;
ylabel('SNR', 'FontSize', 24);
xlabel('Norm. slice number', 'FontSize', 24);
set(gca,'XTickLabelRotation', 0);


