%% Complex Signals 2.2d
clc;
clear all;
close all;
addpath('Export')


tightness = [.1 .05];

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)

%% Complex Signals

N = 32;
P = 32*10;
f0 = 0.3;
f1 = 0.32;
n = 0:(N-1);
x = exp(1j*2*pi*f0*n) + exp(1j*2*pi*f1*n) + 0.2/(sqrt(2))*(randn(1,N)+1j*randn(1,N));
x = [x zeros(1,P)];
psd = fft_psd(x);
freq = -0.5:1/(length(psd)-1):0.5;

[X,R] = corrmtx(x,14,'mod');
[S,F] = pmusic(R,2,[],1,'corr');
figure(1)
subplot_tight(1,2,1,tightness)
hold on
plot(F,10*log10(S/(N*2)),'g')
plot(freq,10*log10(psd))
set(gca,'xlim',[0 0.5]);
hold off
set(gca,'xtick',0:.05:.5)
set(gca,'XGrid', 'on')
set(gca,'YGrid', 'on')
ylabel('$P(\omega)$  (dB)')
xlabel('Freq')
title(sprintf('$P(\\omega)$ estimate $f_0 = %s$ $f_1 = %s$ \\& N=%d',num2str(f0),num2str(f1),N))
legend('MUSIC estimate','Periodogram')

subplot_tight(1,2,2,tightness)
hold on
plot(F,S,'g')
plot(freq,psd)
set(gca,'xlim',[0 0.5]);
hold off
set(gca,'xtick',0:.05:.5)
set(gca,'XGrid', 'on')
set(gca,'YGrid', 'on')
ylabel('$P(\omega)$  (dB)')
xlabel('Freq')