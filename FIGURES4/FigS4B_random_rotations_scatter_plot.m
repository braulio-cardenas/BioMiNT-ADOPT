clear;
clc;
close all;

load('FigS4B.mat','theta','points');

figure,
c = theta;
S = 15*ones(1,numel(theta));
scatter3(points(1:583,1),points(1:583,2),points(1:583,3),S(1:583),c(1:583), 'filled'); axis equal;
colormap(viridis(1024));
view(3);

set(gca,'ticklength',1.25*get(gca,'ticklength'));
set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'linewidth',0.5);
set(gca,'TickDir','out');
set(gca, 'fontsize', 7);
box('off')
h.YAxis.FontSize = 7;

hfig = gcf;

clim([0 360]);
xlabel('x');
ylabel('y');
zlabel('z');

BoxDim = [5, 5];

BoxPos = [1, 1, BoxDim(1), BoxDim(2)];

haxis = gca;
set(hfig, 'Units', 'centimeters', ...
    'Color', [1,1,1]);
set(haxis, ...
    'Units'              , 'centimeters',...
    'Position'           , BoxPos);

pos = get(hfig, 'Position');
outerpos = get(haxis, 'OuterPosition');
outerpos(3) = 5;
outerpos(4) = 5;
set(haxis, 'OuterPosition',[0.1, 0, outerpos(3), outerpos(4)]);
set(hfig, 'Position', [pos(1), pos(2), outerpos(3), outerpos(4)]);
set(hfig, 'PaperPositionMode', 'auto');
