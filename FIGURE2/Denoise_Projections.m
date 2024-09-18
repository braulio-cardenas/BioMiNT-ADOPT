function [projections,original_projections] = Denoise_Projections(file,path,N,fs)

volume = double(tiffreadVolume([path,file],'PixelRegion',{[1 Inf],[1 Inf],[1,N]})); %rows, columns, slices

[nx,ny, ~] = size(volume);
reshapedData = reshape(volume, [], size(volume, 3));

cutoff_freq = 5; % Cutoff frequency in Hz
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
original_projections = volume;
end
