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


% % ----------------Find  the best parameter mu------------------
% mu = [0.2,0.1,0.05,0.04,0.02,0.01,0.008,0.006,0.004,0.002,0.001,0.0005,0.0001];
% SNR = [];
% all_MSE = [];
% for i=1:length(mu)
%     [error, noise, w]=LMS(x', re', mu(i), order);
%     error = error';
%     y=error;
%     signalPower = sum(abs(d).^2)/length(d);
%     noisePower = sum(abs(d-y).^2)/length(d);
%     SNR(i)=10*log10(signalPower/noisePower);
%     all_MSE(i)=mean((d-y).^2);
% end
% hold on
% grid on
% ax = gca;
% yyaxis left
% plot(fliplr(mu),fliplr(SNR),'.-','MarkerSize',15);
% ax.XAxis.Scale = 'log';
% ylabel('SNR(dB)');
% xlabel('mu','FontSize',13);
% yyaxis right
% plot(fliplr(mu),fliplr(all_MSE),'.-','MarkerSize',15);
% ylabel('MSE');
% ax.XAxis.Exponent = 2;
% legend('SNR','MSE');
% 
% hold off
% 
% % ------------------------------------------------------------------



% Run the above code to find the best step size. The best step size is set 
% to 0.04
mu = 0.04;

% filtering with LMS algorithm
[error, noise, w]=LMS(x', re', mu, order);

% the filtered signal is the error
y = error';

% compute ISNR and MSE
improved_SNR = 10*log10(sum(abs(x-d).^2)/sum(abs(d-y).^2));
MSE = mse(d, y);

% plot ECG signals 
plotSignal(x,y,d);

% plot the psd graphs of ECG signals 
figure(4)
periodogram(d,[],length(d),500);
title("PSD of clean ECG signal");
figure(5)
periodogram(x,[],length(x),500);
title("PSD of noisy ECG signal");
figure(6)
periodogram(y,[],length(y),500);
title("PSD of filtered ECG signal");

% plot spectrogram of ECG signals
figure(7)
spectrogram(d,128,120,length(d),500,'yaxis');
title("Spectrogram of clean ECG signal");
figure(8)
spectrogram(x,128,120,length(x),500,'yaxis');
title("Spectrogram of noisy ECG signal");
figure(9)
spectrogram(y,128,120,length(y),500,'yaxis');
title("Spectrogram of filtered ECG signal");
