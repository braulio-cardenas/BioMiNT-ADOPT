close all;
clear;
clc;

fileNameList = {'K562cell_spherical_CALD_LSF_des.mat', 'K562cell_concave_CALD_LSF_des.mat'};

for k = 1:numel(fileNameList)
    load(fileNameList{k});
    fvec(1,:) = 0;
    
    hex_colors = {'#0E3580', '#0F4BA3', '#1D6DC4', '#389CE8', '#4DB2F8', '#7ED0F8', '#9AEDFB', '#C8F9FD', '#FFFFFF', '#FFFCDD', '#FFEA7F', '#FFC03E', '#FFA105', '#FE6100', '#FF3300', '#DF1500', '#C10000'};
    cmap = hex2colormap(hex_colors,512);

    figure, imagesc(log(abs(fvec'))); colormap(cmap);
    colorbar;
    clim([-7.5   3]);
    [x, y] = size(fvec');

    hold on;
    plot([0.5 441.5], [1.5 1.5], 'k-', LineWidth=0.5);
    plot([0.5 441.5], [2.5 2.5], 'k-', LineWidth=0.5);
    plot([0.5 441.5], [3.5 3.5], 'k-', LineWidth=0.5);
    set(gca, 'YTick', []);
    h = gca;
    set(gca,'ticklength',1.25*get(gca,'ticklength'));
    set(gca,'LooseInset',get(gca,'TightInset'));
    set(gca,'linewidth',0.5);
    set(gca,'TickDir','out');
    set(gca, 'fontsize', 7);
    box('on');
    h.YAxis.FontSize = 7;
    hfig = gcf;
    BoxDim = [6.5, 1.75];
    BoxPos = [1, 1, BoxDim(1), BoxDim(2)];
    haxis = gca;
    set(hfig, 'Units', 'centimeters', ...
        'Color', [1,1,1]);
    set(haxis, ...
        'Units'              , 'centimeters',...
        'Position'           , BoxPos);
    pos = get(hfig, 'Position');
    outerpos = get(haxis, 'OuterPosition');
    outerpos(3) = 6.5;
    outerpos(4) = 1.75;
    set(haxis, 'OuterPosition',[0.05, 0.05, outerpos(3), outerpos(4)]);
    set(hfig, 'Position', [pos(1), pos(2), outerpos(3)+0.1, outerpos(4)+0.1]);
    set(hfig, 'PaperPositionMode', 'auto');
    hold off;
end