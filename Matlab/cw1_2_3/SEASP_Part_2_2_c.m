%%
clc;
clear all;
close all;
load 2_2b_std.mat
tightness = [.15 .05 .1 .05];
figure(1)
%%
subplot_tight(1,3,1,tightness)
f0 = 0.2;
f1 = 0.25;
N=256;
I = 100;
n = 1:N;
freq = (1:(2*N-1)) - N;
freq = freq/length(freq);
plot(freq,10*log10(psd_v1))
axis([0 0.5 -1 10])
ylabel('std($P(\omega)$)  (dB)')
xlabel('Freq(normalised)')
title(sprintf('STD estimate $f_0 = %s$ $f_1 = %s$ \\& N=%d',num2str(f0),num2str(f1),N))
%%
subplot_tight(1,3,2,tightness)
f0 = 0.2;
f1 = 0.205;
N=128;
I = 100;
n = 1:N;
freq = (1:(2*N-1)) - N;
freq = freq/length(freq);
plot(freq,10*log10(psd_v2))
axis([0 0.5 -1 10])
ylabel('std($P(\omega)$)  (dB)')
xlabel('Freq(normalised)')
title(sprintf('STD estimate $f_0 = %s$ $f_1 = %s$ \\& N=%d',num2str(f0),num2str(f1),N))

%%
subplot_tight(1,3,3,tightness)
f0 = 0.2;
f1 = 0.205;
N=512;
I = 100;
n = 1:N;

freq = (1:(2*N-1)) - N;
freq = freq/length(freq);
plot(freq,10*log10(psd_v3))
axis([0 0.5 -1 10])
ylabel('std($P(\omega)$)  (dB)')
xlabel('Freq(normalised)')
title(sprintf('STD estimate $f_0 = %s$ $f_1 = %s$ \\& N=%d',num2str(f0),num2str(f1),N))
