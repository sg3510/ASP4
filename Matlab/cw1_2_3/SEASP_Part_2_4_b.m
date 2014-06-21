%% Setup 2.4.a
clc;
clear all;
close all;
addpath('Export')
addpath('Export/MLF')

tightness = [.1 .05];
load EEG_Data_Assignment2.mat
set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)

%% Generate all samples
% 
% t = -2:0.001:2;
x= POz;
% % soundsc(x,4000)
% 
N = length(x);
% 

nfft = 1200;
noverlap = round(nfft/1.1);
window = hanning(nfft);
% fs = 1000;
% subplot(2,3,1)
subplot(2,2,1)
spectrogram(x,window,noverlap,nfft,fs,'yaxis');
xlabel('Time(s)')
tit = sprintf('POz: nfft=%d noverlap=%d Hanning window',nfft,noverlap);
title(tit);
axis([1 290 10 30])

subplot(2,2,2)
nfft = 4096;
noverlap = round(nfft/1.25);
window = hanning(nfft);
spectrogram(x,window,noverlap,nfft,fs,'yaxis');
xlabel('Time(s)')
tit = sprintf('POz: nfft=%d noverlap=%d Hanning window',nfft,noverlap);
title(tit);
axis([1 290 10 30])

x= Cz;
nfft = 2*8192;
noverlap = 2048;
subplot(2,2,3)
spectrogram(x,window,noverlap,nfft,fs,'yaxis');
xlabel('Time(s)')
tit = sprintf('Cz: nfft=%d noverlap=%d Hanning window',nfft,noverlap);
title(tit);
axis([1 290 10 30])

subplot(2,2,4)
nfft = 4096;
noverlap = round(nfft/1.25);
window = hanning(nfft);
spectrogram(x,window,noverlap,nfft,fs,'yaxis');
xlabel('Time(s)')
tit = sprintf('Cz: nfft=%d noverlap=%d Hanning window',nfft,noverlap);
title(tit);
axis([1 290 10 30])