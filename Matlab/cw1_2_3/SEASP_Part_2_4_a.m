%% Setup 2.4.a
clc;
close all;
addpath('Export')

clearvars -except fs POz Cz

if exist('Cz','var') == 0
load EEG_Data_Assignment2.mat
disp('loaded')
end

tightness = [.1 .05];

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)

%% Generate all samples

t = -2:0.001:2;
x= POz;
soundsc(x,4000)

N = length(t);

noverlap = 120;
nfft = 128;
window = hanning(nfft);
fs = 1000;
subplot(2,3,1)
spectrogram(x,window,noverlap,nfft,fs,'yaxis');
tit = sprintf('nfft=%d noverlap=%d Hanning window',nfft,noverlap);
title(tit);
subplot(2,3,2)
window = hamming(nfft);
spectrogram(x,window,noverlap,nfft,fs,'yaxis');
tit = sprintf('nfft=%d noverlap=%d Hanmming window',nfft,noverlap);
title(tit);
subplot(2,3,3)
window = ones(1,nfft);
spectrogram(x,window,noverlap,nfft,fs,'yaxis');
tit = sprintf('nfft=%d noverlap=%d Rect window',nfft,noverlap);
title(tit);
subplot(2,3,4)
nfft = 256;
noverlap = 100;
window = hanning(nfft);
spectrogram(x,window,noverlap,nfft,fs,'yaxis');
tit = sprintf('nfft=%d noverlap=%d Hanning window',nfft,noverlap);
title(tit);
subplot(2,3,5)
nfft = 512;
noverlap = 510;
window = hanning(nfft);
spectrogram(x,window,noverlap,nfft,fs,'yaxis');
tit = sprintf('nfft=%d noverlap=%d Hanning window',nfft,noverlap);
title(tit);
subplot(2,3,6)
nfft = 64;
noverlap=60;
window = hanning(nfft);
spectrogram(x,window,noverlap,nfft,fs,'yaxis');
tit = sprintf('nfft=%d noverlap=%d Hanning window',nfft,noverlap);
title(tit);
% % now compute the power spectral density, which we want to display
% mypsd = 10*log10(myspec .* conj(myspec));
% % mypsd = 500*mypsd/max(mypsd);
% % display as image
% colormap(jet)
% imagesc(mypsd), axis xy