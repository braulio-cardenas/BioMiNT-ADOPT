load('Fig2H.mat');

umPerPixel = 0.1053;
isoval = 0.32;
s_start = 0.25;
s_end = 0.75;
Nvals = 32;

[~,~,~] = surfaceProfileFunction_plot(vol3D,umPerPixel,s_start,s_end,Nvals,isoval);

h = gca;
set(gca,'ticklength',1.25*get(gca,'ticklength'));
set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'linewidth',0.5);
set(gca,'TickDir','out');
set(gca, 'fontsize', 7);
box('off')
h.YAxis.FontSize = 7;
xlim([-6    6]);
ylim([-4.2   4.2]);
zlim([ -7.5    7]);

hfig = gcf;
BoxDim = [4.5, 5.5]; 
BoxPos = [1, 1, BoxDim(1), BoxDim(2)];

haxis = gca;
set(hfig, 'Units', 'centimeters', ...
    'Color', [1,1,1]);
set(haxis, ...
    'Units'              , 'centimeters',...
    'Position'           , BoxPos);

pos = get(hfig, 'Position');
outerpos = get(haxis, 'OuterPosition');

outerpos(3) = 4.5;
outerpos(4) = 5.5;

set(haxis, 'OuterPosition',[0, 0, outerpos(3), outerpos(4)]);
set(hfig, 'Position', [pos(1), pos(2), outerpos(3), outerpos(4)]);
set(hfig, 'PaperPositionMode', 'auto');
