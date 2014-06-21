clc
clear all
close all

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')
%Params
N=1200;
sigma = 0.25;
n = sqrt(sigma)*randn(1,N);
a2 = -0.81;
x=zeros(1,N);
%Filter
x(1) = n(1);
x(2) = 1.2728*x(1)+n(2);
for i=3:N
    if (i>= 400)&&(i<800)
        a1 = 0;
    else
        a1 = 1.2728;
    end
    x(i) = a1*x(i-1)+a2*x(i-2)+n(i);
end
%% Plot
subplot(1,2,1)
[ar_c,~,~] = aryule(x,2)
[h,w] = freqz(1,ar_c,N);
plot(w/pi,10*log10(abs(h)),'k')
set(gca,'YGrid','on');
set(gca,'XGrid','on');
%Periodogram
% hold on
% periodogram(x)
axis tight
% legend('Coefficient Estimate','Periodogram')
title('Frequency Response for AR(2) estimate')
ylabel('Amplitude')
xlabel('Normalised Frequency($\times \pi$rad/sample)')
subplot(1,2,2)
[ar_c,~,~] = aryule(x,4)
[h,w] = freqz(1,ar_c,N);
plot(w/(pi),10*log10(abs(h)),'k','LineWidth',1.5)
%Periodogram
hold on
periodogram(x)
axis tight
legend('AR Yule Estimate','Periodogram')
title('Frequency Response for AR(4) estimate')
ylabel('Amplitude')
xlabel('Normalised Frequency($\times \pi$rad/sample)')
%% Spectro
figure(2)
spectrogram(x,hann(100),50,512,1,'yaxis')
xlabel('Sample N')