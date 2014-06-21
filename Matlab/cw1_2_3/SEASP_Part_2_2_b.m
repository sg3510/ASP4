%%
clc;
clear all;
close all;
addpath('Export')


tightness = [.15 .05 .1 .05];

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
%%
clf(figure(1))
f0 = 0.2;
f1 = 0.25;
N=256;
I = 100;
n = 1:N;

n = ones(I,1)*n;

x = randn(I,N) + .5*sin(f0*2*pi*n) + .5*sin(f1*2*pi*n);

acs = zeros(I,N*2-1);
psd = zeros(I,N*2-1);
for i=1:I
    acs(i,:) = fftshift(xcorr(x(i,:),'biased'));
    acs(i,:) = acs(i,end:-1:1);
    psd(i,:) = real(fftshift(fft(acs(i,:)')));
end
psd = psd';

figure(1)

freq = (1:(2*N-1)) - N;
freq = freq/length(freq);



subplot_tight(1,3,1,tightness)


hold on
plot(freq,10*log10(psd),'Color',[ 0.0431    0.5176    0.7804])
plot(freq,10*log10(mean(psd,2)),'LineWidth',1.75)
axis([0 0.5 -15 20])
tit = sprintf('PSD estimates for sin signal $f_0$ = %s $f_1$ = %s N=%d',num2str(f0),num2str(f1),N);
title(tit)
ylabel('Amplitude(dB)')
xlabel('Freq(normalised)')
hold off



subplot_tight(1,3,2,tightness)


hold on
plot(freq,(psd),'Color',[ 0.0431    0.5176    0.7804])
plot(freq,(mean(psd,2)),'LineWidth',1.75)
hold off
ylabel('Amplitude')
xlabel('Freq(normalised)')
axis([0 0.5 0 65])



subplot_tight(1,3,3,tightness)


plot(freq,(std(psd')))
max(std(psd'))
axis([0 0.5 0 10])
title(sprintf('Standard Deviation estimate for %d realisations',I))
ylabel('std($P(\omega)$)')
xlabel('Freq(normalised)')
