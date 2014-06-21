clc;
clear all;
close all
addpath('Export')


set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
load sunspot.dat

x = sunspot(:,1);
data = sunspot(:,2);
% data = [data ;zeros(400,1)];
% x = [x;zeros(400,1)];
data_nt = detrend(data);
data_nm = data-mean(data);
data_nmt = data_nt;
data_nmt = data_nmt - mean(data_nmt);
data_log = log10(data+10);
data_log = data_log - mean(data_log);

psd = fft_psd(data);
psd_nt = fft_psd(data_nt);
psd_nm = fft_psd(data_nm);
psd_nmt = fft_psd(data_nmt);
psd_log = fft_psd(data_log);

figure(1);
N=length(psd);

freq=1:N;
freq = freq - N/2;
freq = freq/N;

subplot(1,4,1)
psd_plot = [psd psd_nm];
plot(freq(N/2:end),10*log10(psd_plot(N/2:end,:)));
axis([0 .5 -10 60])
xlabel('Frequency($year^{-1}$)')
ylabel('Amplitude(dB)')
title('No Mean')

subplot(1,4,2)
psd_plot = [psd psd_nt];
plot(freq(N/2:end),10*log10(psd_plot(N/2:end,:)));
axis([0 .5 -10 60])
title('No Trend')
xlabel('Frequency($year^{-1}$)')

subplot(1,4,3)
psd_plot = [psd psd_nmt];
plot(freq(N/2:end),10*log10(psd_plot(N/2:end,:)));
axis([0 .5 -20 60])
title('No Trend and Mean')
xlabel('Frequency($year^{-1}$)')

subplot(1,4,4)
psd_plot = [psd psd_log];
plot(freq(N/2:end),10*log10(psd_plot(N/2:end,:)));
axis([0 .5 -60 60])
title('Log10 Data Pre-Processing')
xlabel('Frequency($year^{-1}$)')

  
figure(2);
plot(x,data);