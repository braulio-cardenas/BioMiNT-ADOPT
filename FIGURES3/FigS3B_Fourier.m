close all;
clc;
clear;

load('FigS3B_des.mat');

degree =20;
fvec(1,:) = 0; % this removes the DC component, essentially bringing the reconstruction to the origin
idx = 1;
v = zeros(1,(degree+1)^2);

for k = 0:1:degree
    for m = -k:1:k
          v(idx) = m;
          idx = idx+1;
    end
end
aux_idx = abs(v)<21; % all L = 0, azimuthal

fx = fvec(:,1);
fy = fvec(:,2);
fz = fvec(:,3);

fxabs = abs(fx(aux_idx));
fyabs = abs(fy(aux_idx));
fzabs = abs(fz(aux_idx));



%% FREQUENCY FIGURE PART 1
figure, 
hold on;
pos1= 20;
pos2 = 40;
xlimend = 50;
plot(linspace(0,xlimend,numel(fxabs)),pos1*ones(size(fxabs)), 'color', [0.8, 0.8, 0.8]);
plot(linspace(0,xlimend,numel(fxabs)),pos2*ones(size(fxabs)), 'color', [0.8, 0.8, 0.8]);
plot(fxabs(1:xlimend), 'color',  [0, 0.4470, 0.7410]); hold on;

plot(fyabs(1:xlimend)+pos1, 'color',  [0.8500, 0.3250, 0.0980]);
plot(fzabs(1:xlimend)+pos2, 'color',  [0.9290, 0.6940, 0.1250]);

YTickPositions =0:5:70;
xlim([0 xlimend]);
h = gca;
XTickPositions = 0:5:xlimend;
XLimits = [0 xlimend];
YLimits = [0 75];
set(gca,'XTick',XTickPositions);
set(gca,'XLim',XLimits);
set(gca,'YLim',YLimits,'YTick',YTickPositions);

[XTicksStrs] = tickLabelAlternated(XTickPositions);

set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'linewidth',0.5);
set(gca,'TickDir','out');
set(gca, 'fontsize', 7);
box('off');

set(gca,'XTickLabel',XTicksStrs);
set(gca, 'XTickLabelRotation', 0);
set(gca,'YTickLabel','');
h.YAxis.FontSize = 7;
xlabel('Spherical harmonic number (adim.)');
ylabel('Intensity (a.u.)', 'FontSize', 7);

h = gca;
set(gca,'ticklength',1.25*get(gca,'ticklength'));
set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'linewidth',0.5);
set(gca,'TickDir','out');
set(gca, 'fontsize', 7);
box('off')
h.YAxis.FontSize = 7;
hfig = gcf;
BoxDim = [2.5, 3]; 
BoxPos = [1, 1, BoxDim(1), BoxDim(2)];
haxis = gca;
set(hfig, 'Units', 'centimeters', ...
    'Color', [1,1,1]);
set(haxis, ...
    'Units'              , 'centimeters',...
    'Position'           , BoxPos);
pos = get(hfig, 'Position');
outerpos = get(haxis, 'OuterPosition');
outerpos(3) = 2.5;
outerpos(4) = 3;
set(haxis, 'OuterPosition',[0, 0, outerpos(3), outerpos(4)]);
set(hfig, 'Position', [pos(1), pos(2), outerpos(3), outerpos(4)]);
set(hfig, 'PaperPositionMode', 'auto');
hold off;

%% FREQUENCY FIGURE PART 2

figure, 
hold on;
pos1= 20;
pos2 = 40;
xlimend = 441;
plot(linspace(0,xlimend,numel(fxabs)),pos1*ones(size(fxabs)), 'color', [0.8, 0.8, 0.8]);
plot(linspace(0,xlimend,numel(fxabs)),pos2*ones(size(fxabs)), 'color', [0.8, 0.8, 0.8]);
plot(100:441,fxabs(100:end), 'color',  [0, 0.4470, 0.7410]); hold on;
plot(100:441,fyabs(100:end)+pos1, 'color',  [0.8500, 0.3250, 0.0980]);
plot(100:441,fzabs(100:end)+pos2, 'color',  [0.9290, 0.6940, 0.1250]);
YTickPositions =0:5:70;
xlim([100 441]);
h = gca;
XTickPositions = 100:50:441;
XLimits = [100 441];
YLimits = [0 75];
set(gca,'XTick',XTickPositions);
set(gca,'XLim',XLimits);
set(gca,'YLim',YLimits,'YTick',YTickPositions);
[XTicksStrs] = tickLabelAlternated(XTickPositions);
set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'linewidth',0.5);
set(gca,'TickDir','out');
set(gca, 'fontsize', 7);
box('off');
set(gca,'XTickLabel',XTicksStrs);
set(gca, 'XTickLabelRotation', 0);
set(gca,'YTickLabel','');
h.YAxis.FontSize = 7;
xlabel('Spherical harmonic number (adim.)');
ylabel('Intensity (a.u.)', 'FontSize', 7);
h = gca;
set(gca,'ticklength',1.25*get(gca,'ticklength'));
set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'linewidth',0.5);
set(gca,'TickDir','out');
set(gca, 'fontsize', 7);
box('off')
h.YAxis.FontSize = 7;
hfig = gcf;
BoxDim = [2.5, 3]; 
BoxPos = [1, 1, BoxDim(1), BoxDim(2)];

haxis = gca;
set(hfig, 'Units', 'centimeters', ...
    'Color', [1,1,1]);
set(haxis, ...
    'Units'              , 'centimeters',...
    'Position'           , BoxPos);
pos = get(hfig, 'Position');
outerpos = get(haxis, 'OuterPosition');
outerpos(3) = 2.5;
outerpos(4) = 3;
set(haxis, 'OuterPosition',[0, 0, outerpos(3), outerpos(4)]);
set(hfig, 'Position', [pos(1), pos(2), outerpos(3), outerpos(4)]);
set(hfig, 'PaperPositionMode', 'auto');
hold off;

