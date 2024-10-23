clear;
clc;
close all;

%% Set Cut-off frequency to desired value (in Hz)

cutoff_freq = 10;

%%

varN = [0, 0.001, 0.01, 0.1, 0.2, 0.5, 1, 2];

SNR_input = zeros(1,numel(varN));
SNR_output = zeros(1,numel(varN));


for var_kk = 1:numel(varN)

N =800;
nx = 204;
ny = 204;

frameRate = 150;

volume = tiffreadVolume('Fig4.tif');
volume = double(volume(:,:,1:N));

M = normrnd(1,varN(var_kk), size(volume));
volume = volume.*M; 

SNRbefore = zeros(1,N);
SNRafter = zeros(1,N);

reshapedData = reshape(double(volume), [], size(volume, 3));

fs = 150; %frames/s, fps

sampling_freq = fs; % Sampling frequency in Hz
filter_order =3; % Filter order


% Design the Butterworth lowpass filter
[b, a] = butter(filter_order, cutoff_freq/(sampling_freq/2), 'low');

filteredData = zeros(nx*ny,N);

parfor k = 1:nx*ny
    filteredData(k,:) = filtfilt(b, a, reshapedData(k,:));
end

filteredVolume = reshape(filteredData, size(volume));

projections = filteredVolume;


parfor i = 1:N
    currentFrame_noisy = volume(:,:,i);
    SNRbefore(i) = mean(currentFrame_noisy(:))/std(currentFrame_noisy(:));

    currentFrame_clean = projections(:,:,i);
    SNRafter(i) = mean(currentFrame_clean(:))/std(currentFrame_clean(:));
end

SNRbefore_mean = mean(SNRbefore);
SNRafter_mean = mean(SNRafter);


SNR_input(var_kk) = SNRbefore_mean;
SNR_output(var_kk) = SNRafter_mean;


end

SNR_var = linspace(0.5,1.5,128);


figure,
plot(SNR_input, SNR_output, '-o'); hold on;
xlabel('SNR input projection');
ylabel('SNR output projection')
