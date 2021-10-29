function plotSignal(noisy_signal, filtered_signal, clean_signal)

%This function is to plot the noisy ECG signal, filtered ECG signal
%and clean ECG signal 
%-------------------------------------------------------------------
%Inputs:
%       noisy_signal  :  noisy ECG signal vector
%       filtered_signal  : filtered ECG signal vector
%       clean_signal : clean ECG signal vector
% Outputs:
%       plots of ECG signals
%---------------------------------------------------------------

% Noisy ECG signal
figure(1)
plot(noisy_signal,'LineWidth',1);
set(gca,'FontWeight','bold','FontSize',10);
title("Noisy ECG signal");
xlabel('Samples(n)','FontSize',13);
ylabel('Amplitude(mV)','FontSize',13) ;

% Filtered ECG signal
figure(2)
plot(filtered_signal,'LineWidth',1);
set(gca,'FontWeight','bold','FontSize',10);
title("Filtered ECG signal");
xlabel('Samples(n)','FontSize',13);
ylabel('Amplitude(mV)','FontSize',13) ;

% Clean ECG signal
figure(3)
plot(clean_signal,'LineWidth',1);
set(gca,'FontWeight','bold','FontSize',10);
title("Clean ECG signal");
xlabel('Samples(n)','FontSize',13);
ylabel('Amplitude(mV)','FontSize',13) ;

end
