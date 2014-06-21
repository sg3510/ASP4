%% Setup 2.3.b
clc;
clear all;
close all;
addpath('Export')

tightness = [.1 .05];

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)

%% Generate all samples

N = 10000;

%to then discard first 100
N = N + 500;

x = zeros(1,N);
w = randn(1,N);

x(1) = w(1);
x(2) = 2.76*x(1) + w(2);
x(3) = 2.76*x(2) - 3.81*x(1) + w(3);
x(4) = 2.76*x(3) - 3.81*x(2) + 2.65*x(3) + w(4);

for i = 5:N
    x(i) = 2.76*x(i-1) - 3.81*x(i-2) + 2.65*x(i-3) - 0.92*x(i-4) + w(i);
end

figure(1)
x  = x(501:end);
freq = 0:(length(x)/2);
freq = freq./length(x);
order = [4,5,7,9];
order = 2:12;
for i = 1:length(order);
subplot_tight(4,3,i,tightness);
pxx = pyulear(x,order(i),2^(nextpow2(length(x))));
P = fft_psd(x);
P = P(end/2:end);
if i==4
hold on 
plot(freq,P,'g');
end
freq_pxx = 1:length(pxx);
freq_pxx = .5*freq_pxx./length(pxx);
plot(freq_pxx,pxx);
axis tight
tit = sprintf('AR Spectrum estimate order %d',order(i));
title(tit);
if i == 1
ylabel('Amplitude')
end
maxval = max(pxx);
if i==4
hold off
maxval = max(P);
end
xlabel('Freq (Normalised)')
set(gca,'xtick',0:.05:.5)
set(gca,'ytick',0:roundn(maxval/10,2):maxval)
set(gca,'XGrid', 'on')
set(gca,'YGrid', 'on')
end