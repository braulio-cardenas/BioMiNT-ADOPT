clear;
clc;
close all;

load('Fig2G.mat');

figure,patch('Faces', faces, 'Vertices', verts, 'FaceVertexCData', colors, ...
      'FaceColor', 'interp', 'EdgeColor', 'none');
hex_colors = {'#0E3580', '#0F4BA3', '#1D6DC4', '#389CE8', '#4DB2F8',...
    '#7ED0F8', '#9AEDFB', '#C8F9FD', '#FFFFFF', '#FFFCDD', '#FFEA7F', ...
    '#FFC03E', '#FFA105', '#FE6100', '#FF3300', '#DF1500', '#C10000'};
cmap = hex2colormap(hex_colors,512);
colormap(cmap);
clim([-0.6363    0.7044]);
view(3);

grid on;
axis equal;
axis tight;
camlight; % Add a light
lighting gouraud; % Apply Gouraud lighting
h = gca;
set(gca,'ticklength',1.25*get(gca,'ticklength'));
set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'linewidth',0.5);
set(gca,'TickDir','out');
set(gca, 'fontsize', 7);
box('off')
h.YAxis.FontSize = 7;
hfig = gcf;
BoxDim = [6, 5.3]; 
BoxPos = [1, 1, BoxDim(1), BoxDim(2)];
haxis = gca;
set(hfig, 'Units', 'centimeters', ...
    'Color', [1,1,1]);
set(haxis, ...
    'Units'              , 'centimeters',...
    'Position'           , BoxPos);

pos = get(hfig, 'Position');
outerpos = get(haxis, 'OuterPosition');
outerpos(3) = 6;
outerpos(4) = 5.3;
set(haxis, 'OuterPosition',[0, 0, outerpos(3), outerpos(4)]);
set(hfig, 'Position', [pos(1), pos(2), outerpos(3), outerpos(4)]);
set(hfig, 'PaperPositionMode', 'auto');
 
