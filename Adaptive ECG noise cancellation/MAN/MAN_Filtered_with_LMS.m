addpath(genpath('..\Functions'));
% load the dataset
data = load('..\ECG_database.mat');


% clean ECG data
d = data.Data1;

% white noise
v = data.man;

% corrupted ECG signal
x =data.MAN_data;

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
% mu = [0.9,0.7,0.5,0.2,0.1,0.06,0.04,0.025,0.01,0.005,0.0025,0.001,0.0005,0.0001];
% SNR = [];
% all_MSE = [];
% for i=1:length(mu)
%     [error, noise, w]=LMS(x', re', mu(i), order);
%     y=error';
%     signalPower = sum(abs(d).^2)/length(d);
%     noisePower = sum(abs(d-y).^2)/length(y);
%     SNR(i)=10*log10(signalPower/noisePower);
%     all_MSE(i)=mse(d,y);
% end
% hold on
% grid on
% ax = gca;
% yyaxis left
% plot(fliplr(mu),fliplr(SNR),'.-','MarkerSize',15);
% ax.XAxis.Scale = 'log';
% ylabel('SNR(dB)');
% ylim([-10,8]);
% xlabel('mu','FontSize',13);
% yyaxis right
% plot(fliplr(mu),fliplr(all_MSE),'.-','MarkerSize',15);
% ylabel('MSE');
% ax.XAxis.Scale = 'log';
% ax.XAxis.Exponent = 2;
% legend('SNR','MSE')
% hold off
% %-------------------------------------------------------------------

% Run the above code to find the best step size. The best step size is set 
% to 0.5
mu = 0.5;

% filtering with LMS algorithm
[error, noise, w]=LMS(x', re', mu, order);

% the filtered signal is the error
y = error';

% compute ISNR and MSE
improved_SNR = 10*log10(sum(abs(x-d).^2)/sum(abs(d-y).^2));
MSE = mse(d, y);

% plot ECG signals 
plotSignal(x,y,d);