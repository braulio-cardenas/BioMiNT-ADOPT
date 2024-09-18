clear;
clc;
close all;

degree = 20;

load('FigS4C.mat', 'ConcavityMatrix');

Conc_avg_1 = mean(ConcavityMatrix);
Conc_std_1 = std(ConcavityMatrix,0,1);

figure,
x = 1:degree;
y = Conc_avg_1;

upper_bound = y + Conc_std_1;
lower_bound = y - Conc_std_1;

fill([x, fliplr(x)], [upper_bound, fliplr(lower_bound)], 'r', 'FaceAlpha', 0.15, 'EdgeAlpha', 0); hold on;

plot(x,y, 'r', 'LineWidth',1);

hold off; % Release the plot

XTickPositions = 0:2:20;
YTickPositions = 0:0.1:0.6;

XLimits = [0 20];
YLimits = [0 0.55];

[YTicksStrs] = tickLabelAlternated(YTickPositions);
[XTicksStrs] = tickLabelAlternated(XTickPositions);

set(gca,'XTick',XTickPositions);
set(gca,'YTick',YTickPositions);

set(gca,'XLim',XLimits);
set(gca,'YLim',YLimits);

set(gca,'XTickLabel',XTicksStrs);
set(gca,'YTickLabel',YTicksStrs);

set(gca,'linewidth',0.25);
set(gca,'TickDir','out');
set(gca, 'fontsize', 8);
box('off')

xlabel('Spherical harmonic degree (adim.)', 'FontSize', 8);
ylabel('Negative curvature area (norm.)', 'FontSize', 8);

h = gca;

set(gca,'ticklength',1.25*get(gca,'ticklength'));

set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'linewidth',0.5);
set(gca,'TickDir','out');
set(gca, 'fontsize', 7);
box('off')
h.YAxis.FontSize = 7;

hfig = gcf;

BoxDim = [3.22, 1.42]; 
BoxPos = [1, 1, BoxDim(1), BoxDim(2)];

haxis = gca;
set(hfig, 'Units', 'inches', ...
    'Color', [1,1,1]);
set(haxis, ...
    'Units'              , 'inches',...
    'Position'           , BoxPos);

pos = get(hfig, 'Position');
outerpos = get(haxis, 'OuterPosition');

outerpos(3) = 3.22;
outerpos(4) = 1.42;
set(haxis, 'OuterPosition',[0, 0, outerpos(3), outerpos(4)]);
set(hfig, 'Position', [pos(1), pos(2), outerpos(3), outerpos(4)]);
set(hfig, 'PaperPositionMode', 'auto');

