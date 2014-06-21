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
P = 128*8;
f0 = 0.3;
f1 = 0.32;

% Part 1
subplot_tight(1,4,1,tightness)
n = 0:(N-1);
x = exp(1j*2*pi*f0*n) + exp(1j*2*pi*f1*n) + 0.2/(sqrt(2))*(randn(1,N)+1j*randn(1,N));
x = [x zeros(1,P)];
psd = fft_psd(x);
freq = -0.5:1/(length(psd)-1):0.5;
plot(freq,10*log10(psd))
axis ([0 0.5 -40 5])
set(gca,'xtick',0:.05:.5)
set(gca,'ytick',-40:5:5)
set(gca,'XGrid', 'on')
set(gca,'YGrid', 'on')
ylabel('$P(\omega)$  (dB)')
xlabel('Freq')
title(sprintf('$P(\\omega)$ estimate $f_0 = %s$ $f_1 = %s$ \\& N=%d',num2str(f0),num2str(f1),N))

%Part 2
subplot_tight(1,4,2,tightness)
N = 64;
P = 128*8;
f0 = 0.24;
f1 = 0.255;

n = 0:(N-1);
x = exp(1j*2*pi*f0*n) + exp(1j*2*pi*f1*n) + 0.2/(sqrt(2))*(randn(1,N)+1j*randn(1,N));
x = [x zeros(1,P)];
psd = fft_psd(x);
freq = -0.5:1/(length(psd)-1):0.5;
plot(freq,10*log10(psd))
axis ([0 0.5 -40 10])
set(gca,'xtick',0:.05:.5)
set(gca,'ytick',-40:5:10)
set(gca,'XGrid', 'on')
set(gca,'YGrid', 'on')
ylabel('$P(\omega)$  (dB)')
xlabel('Freq')
title(sprintf('$P(\\omega)$ estimate $f_0 = %s$ $f_1 = %s$ \\& N=%d',num2str(f0),num2str(f1),N))


%Part 3
subplot_tight(1,4,3,tightness)
N = 128;
P = 128*8;
f0 = 0.3;
f1 = 0.305;

n = 0:(N-1);
x = exp(1j*2*pi*f0*n) + exp(1j*2*pi*f1*n) + 0.2/(sqrt(2))*(randn(1,N)+1j*randn(1,N));
x = [x zeros(1,P)];
psd = fft_psd(x);
freq = -0.5:1/(length(psd)-1):0.5;
plot(freq,10*log10(psd))
axis ([0 0.5 -40 20])
set(gca,'xtick',0:.05:.5)
set(gca,'ytick',-40:5:20)
set(gca,'XGrid', 'on')
set(gca,'YGrid', 'on')
ylabel('$P(\omega)$  (dB)')
xlabel('Freq')
title(sprintf('$P(\\omega)$ estimate $f_0 = %s$ $f_1 = %s$ \\& N=%d',num2str(f0),num2str(f1),N))

%Part 3
subplot_tight(1,4,4,tightness)
N = 1024;
P = 512*8;
f0 = 0.3;
f1 = 0.305;

n = 0:(N-1);
x = exp(1j*2*pi*f0*n) + exp(1j*2*pi*f1*n) + 0.2/(sqrt(2))*(randn(1,N)+1j*randn(1,N));
x = [x zeros(1,P)];
psd = fft_psd(x);
freq = -0.5:1/(length(psd)-1):0.5;
plot(freq,10*log10(psd))
axis ([0 0.5 -30 25])
set(gca,'xtick',0:.05:.5)
set(gca,'ytick',-30:5:25)
set(gca,'XGrid', 'on')
set(gca,'YGrid', 'on')
ylabel('$P(\omega)$  (dB)')
xlabel('Freq')
title(sprintf('$P(\\omega)$ estimate $f_0 = %s$ $f_1 = %s$ \\& N=%d',num2str(f0),num2str(f1),N))
