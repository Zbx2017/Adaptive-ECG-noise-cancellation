addpath(genpath('..\Functions'));
% load the dataset
data = load('..\ECG_database.mat');


% clean ECG data
d = data.Data1;

% white noise
v = data.bwn;

% corrupted ECG signal
x =data.BWN_data;

% normalize the signal by dividing the gain factor 200
gain = 200;
x = x/gain;
d = d/gain;
v = v/gain;

% white noise as the reference signal 
re=v;

% filter order
order = 4;

% filtering with RLS algorithm
[w,error,noise] = RLS(re',x',order);

% the filtered signal is the error
y = error';

% compute ISNR and MSE
improved_SNR = 10*log10(sum(abs(x-d).^2)/sum(abs(d-y).^2));
MSE = mse(d, y);

% plot ECG signals 
plotSignal(x,y,d);


% plot the psd graph of filtered ECG signal
figure(4)
periodogram(y,[],length(y),500);
title("PSD of filtered ECG signal");

% plot spectrogram of filtered ECG signal
figure(5)
spectrogram(y,128,120,length(y),500,'yaxis');
title("Spectrogram of filtered ECG signal");
