clear;
clc;
close all;

rng("default");

N =800;
nx = 204;
ny = 204;

umPerPixel = 0.079; %um/px

tic();
volume = tiffreadVolume('Fig4.tif');
volume = double(volume(:,:,1:N));

volume_original = volume;

M = normrnd(1,0.2, size(volume));
volume = volume.*M;


SNRbefore = zeros(1,N);
SNRafter = zeros(1,N);
SNRafter_original = zeros(1,N);


reshapedData = reshape(double(volume), [], size(volume, 3));
reshapedData_original = reshape(double(volume_original), [], size(volume_original, 3));


fs = 150; %frames/s, fps

cutoff_freq = 5; %N/frameRate; % Cutoff frequency in Hz
sampling_freq = fs; % Sampling frequency in Hz
filter_order =3; % Filter order


% Design the Butterworth lowpass filter
[b, a] = butter(filter_order, cutoff_freq/(sampling_freq/2), 'low');

filteredData = zeros(nx*ny,N);
filteredData_original = zeros(nx*ny,N);


parfor k = 1:nx*ny
    filteredData(k,:) = filtfilt(b, a, reshapedData(k,:));
    filteredData_original(k,:) = filtfilt(b, a, reshapedData_original(k,:));
end

filteredVolume = reshape(filteredData, size(volume));
filteredVolume_original = reshape(filteredData_original, size(volume_original));

projections = filteredVolume;


parfor i = 1:N

    currentFrame_original = volume_original(:,:,i);
    SNRoriginal(i) = mean(currentFrame_original(:))/std(currentFrame_original(:));

    currentFrame_noisy = volume(:,:,i);
    SNRbefore(i) = mean(currentFrame_noisy(:))/std(currentFrame_noisy(:));

    currentFrame_clean = projections(:,:,i);
    SNRafter(i) = mean(currentFrame_clean(:))/std(currentFrame_clean(:));

    currentFrame_filteredOriginal = filteredVolume_original(:,:,i);
    SNRafter_original(i) = mean(currentFrame_filteredOriginal(:))/std(currentFrame_filteredOriginal(:));
end

SNRoriginal_mean = mean(SNRoriginal);
SNRafter_original_mean = mean(SNRafter_original);

SNRbefore_mean = mean(SNRbefore);
SNRafter_mean = mean(SNRafter);


SNRafter_mean/SNRbefore_mean;

load('cmap.mat');
newCmap = interp1(linspace(0, 1, 64), glow, linspace(0, 1, 256));


frameSelect = 365;

L = round(nx/4);
xCrop = 61;
yCrop = 57;
cmax = max(volume_original(:));

figMatrix = [volume_original(:,:,frameSelect), filteredVolume_original(:,:,frameSelect); volume(:,:,frameSelect), projections(:,:,frameSelect)];
figure, imagesc(figMatrix), axis equal; colormap(newCmap); hold on;
clim([0,  cmax]);
set(gca, 'visible','off');

h1 = rectangle;
h1.LineWidth = 0.5;
h1.EdgeColor = [1 1 1];
h1.Position = [xCrop ,yCrop ,L ,L];


h2 = rectangle;
h2.LineWidth = 0.5;
h2.EdgeColor = [1 1 1];
h2.Position = [xCrop+nx ,yCrop ,L ,L];

h3 = rectangle;
h3.LineWidth = 0.5;
h3.EdgeColor = [1 1 1];
h3.Position = [xCrop ,yCrop+ny ,L ,L];


h4 = rectangle;
h4.LineWidth = 0.5;
h4.EdgeColor = [1 1 1];
h4.Position = [xCrop+nx ,yCrop+ny ,L ,L];


MatrixVolume = figMatrix;
toTiff = uint8(mat2gray(MatrixVolume, [0, cmax])*(2^8-1));
rgbImage = ind2rgb(toTiff, newCmap);
set(gca, 'visible','off');
axis tight;
axis off;
exportgraphics(gca,'Fig4A-D.tif','resolution', 1200)

xpoints = [17, 34];%line profile coordinates
ypoints = [31, 18];%line profile coordinates


dpoints = sqrt(diff(xpoints).^2 + diff(ypoints).^2);


crop1 = volume_original(xCrop:xCrop+L,yCrop:yCrop+L,frameSelect);

figure, imagesc(crop1); axis equal; colormap(newCmap); hold on;
clim([0,  cmax]);
axis off;
set(gca, 'visible','off');
axis tight;
line1 = plot(xpoints, ypoints, 'LineWidth',3, 'color', 'k', 'LineStyle','--');

exportgraphics(gca,'Fig4A_inset.tif','resolution', 1200);

c_crop1 = improfile(crop1, xpoints, ypoints);
dvector = umPerPixel*linspace(0,dpoints, numel(c_crop1));


crop2 = filteredVolume_original(xCrop:xCrop+L,yCrop:yCrop+L,frameSelect);
figure, imagesc(crop2); axis equal; colormap(newCmap); hold on;
clim([0,  cmax]);
axis off;
set(gca, 'visible','off');
line2 = plot(xpoints, ypoints, 'LineWidth',3, 'color', 'k', 'LineStyle','--');
axis tight;
exportgraphics(gca,'Fig4B_inset.tif','resolution', 1200)

c_crop2 = improfile(crop2, xpoints, ypoints);

xvec = linspace(0, dvector(end), 128);

crop3 = volume(xCrop:xCrop+L,yCrop:yCrop+L,frameSelect);
figure, imagesc(crop3); axis equal; colormap(newCmap); hold on;
line3 = plot(xpoints, ypoints, 'LineWidth',3, 'color', 'k', 'LineStyle','--');
clim([0,  cmax]);
axis off;
set(gca, 'visible','off');
axis tight;
exportgraphics(gca,'Fig4C_inset.tif','resolution', 1200)

c_crop3 = improfile(crop3, xpoints, ypoints);

crop4 = projections(xCrop:xCrop+L,yCrop:yCrop+L,frameSelect);
figure, imagesc(crop4); axis equal; colormap(newCmap); hold on;
line4 = plot(xpoints, ypoints, 'LineWidth',3, 'color', 'k', 'LineStyle','--');
clim([0,  cmax]);
axis off;
set(gca, 'visible','off');
axis tight;
exportgraphics(gca,'Fig4D_inset.tif','resolution', 1200)
c_crop4 = improfile(crop4, xpoints, ypoints);