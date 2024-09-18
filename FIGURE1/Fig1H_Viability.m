catA = [98.6
95.792
98];

catB = [90.13157895
94.35483871
97.65957447];

stdA = std(catA);
stdB = std(catB);

std_data = [stdA, stdB];

bar_data = mean([catA, catB]);

errhigh = std_data;
errlow  = std_data;

x = 1:numel(categories);

[hyp,p] = ttest2(catA,catB, 'Tail', 'right', 'Vartype', 'unequal', 'Alpha', 0.05);

y1 = catA;
y2 = catB;

x1 = ones(1,numel(y1));
x2 = 2*ones(1,numel(y2));

figure,

Q_ctrl =quantile(y1,[0.25,0.5, 0.75]);
Q_sample = quantile(y2,[0.25,0.5, 0.75]);

Qpos_ctrl = Q_ctrl(3) - Q_ctrl(2);
Qneg_ctrl = Q_ctrl(2) - Q_ctrl(1);

Qpos_sample = Q_sample(3) - Q_sample(2);
Qneg_sample = Q_sample(2) - Q_sample(1);


b1 = bar(x(1),bar_data(1)); hold on;
b1.BarWidth  = 0.4;
b1.FaceColor = [1, 1, 1];
b1.EdgeColor = 'k';
b1.LineWidth = 1.5;

b2 = bar(x(2),bar_data(2));
b2.BarWidth  = 0.4;
b2.FaceColor = [1,1,1];
b2.EdgeColor = 'r';
b2.LineWidth = 1.5;


er1 = errorbar(x(1),bar_data(1),errlow(1),errhigh(1) ,'capsize', 20, 'color', 'k');
er1.Color = [0 0 0];                            
er1.LineStyle = 'none';  
er1.LineWidth = 1.5;

er2 = errorbar(x(2),bar_data(2),errlow(2),errhigh(2) ,'capsize', 20, 'color', 'r');   
er2.Color = 'r';                            
er2.LineStyle = 'none';  
er2.LineWidth = 1.5;

s1 = swarmchart(x1,y1,50, 'filled', 'MarkerFaceColor', 'k');
s2 = swarmchart(x2,y2,50, 'filled', 'MarkerFaceColor', 'r');

s1.XJitterWidth = 0.3;
s2.XJitterWidth = 0.3;

XTickPositions = [1 2];
YTickPositions = 0:25:100;

XLimits = [0.5 2.5];
YLimits = [0 110];

set(gca,'XTick',XTickPositions);
set(gca,'XLim',XLimits);
set(gca,'YLim',YLimits,'YTick',YTickPositions);
[YTicksStrs] = tickLabelAlternated(YTickPositions);
set(gca,'XTickLabel',{'Ctrl','2 hrs'});
set(gca,'YTickLabel',YTicksStrs);

box('off');
h = gca;
set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'linewidth',1);
set(gca,'TickDir','out');
set(gca, 'fontsize', 22);
box('off')

set(gca,'YTickLabel',YTicksStrs);
h.YAxis.FontSize = 22;
ylabel('Cell viability (%)', 'FontSize', 24);

