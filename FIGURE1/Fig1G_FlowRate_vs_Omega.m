eta_i =  0.89e-3; %mPa*s water
eta_o = 1.3e-3; %mPa*s oil
Ro = 30e-6; %m
U_o = 80e-6; %m/s
Shear = (-3).*eta_i.*eta_o.*(2.*eta_i.*Ro+2.*eta_o.*Ro).^(-1).*U_o;

umPerPixel = 10/38.12; %um/px
Omega = [1, 1.652405488, 3.686814929, 8.800049876]; %Average, normalized omega values
err = [0.092832455	0.228472087	0.64088056	2.312716302]; %Recorded errors

Omega0 = 0.440668735; %Normalization value
Q =[1, 2, 5, 10]; %uL/min
Qv = linspace(min(Q),max(Q),128);

fun = @(x,xdata) (pi*5/3*1e-11*x(1)*xdata)./(Omega0.*Ro*(1 + eta_i/eta_o)); % factor of 5/3*1e-11 is added so that Q can be inserted directly in uL/min and everything is in SI
x0 = 1e5; %arbitrary start value for lsq curve fitting.

[x,SSres, resid,~,~,~,J] = lsqcurvefit(fun,x0,Q,Omega);

SStot = sum((Omega-mean(Omega)).^2);
Rsquared = 1 - SSres/SStot;
ci_99= nlparci(x,resid,'jacobian',J, 'alpha', 0.01);

%% Plotting:
figure,
errorbar(Q,Omega,err,'o', 'color', 'k', 'markersize', 5); hold on;
plot(Qv,fun(x,Qv), 'r', 'linestyle', '--'); hold on;
plot(Q,Omega,'o', 'markerfacecolor', 'w', 'markeredgecolor', 'k', 'markersize', 5); hold on;
xlabel('');
ylabel(''); 
set(gca,'TickDir','out');
set(gca, 'fontsize', 8, 'fontname', 'Arial');

YTickPositions = 0:1:12;
XTickPositions = 0:1:10;
XLimits = [0.5 10.5];
YLimits = [0 12.5];

[XTicksStrs] = tickLabelAlternated(XTickPositions);
[YTicksStrs] = tickLabelAlternated(YTickPositions);

set(gca,'XLim',XLimits,'XTick',XTickPositions);
set(gca,'YLim',YLimits,'YTick',YTickPositions);

set(gca,'XTickLabel',XTicksStrs);
set(gca,'YTickLabel',YTicksStrs);
set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'linewidth',0.25)

box off;
set(gca,'ticklength',1*get(gca,'ticklength'));
legend boxoff;
hfig = gcf;
BoxDim = [7.75, 5.75]; 
BoxPos = [1, 1, BoxDim(1), BoxDim(2)];
haxis = gca;
set(hfig, 'Units', 'centimeters', ...
    'Color', [1,1,1]);
set(haxis, ...
    'Units'              , 'centimeters',...
    'Position'           , BoxPos);
pos = get(hfig, 'Position');
outerpos = get(haxis, 'OuterPosition');
outerpos(3) = 7.75;
outerpos(4) = 5.75;
set(haxis, 'OuterPosition',[0, 0, outerpos(3), outerpos(4)]);
set(hfig, 'Position', [pos(1), pos(2), outerpos(3), outerpos(4)]);
set(hfig, 'PaperPositionMode', 'auto');
legend off;
set(gca,'TickLength',[0.012, 0.01]);


