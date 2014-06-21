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

N1 = 1000;
N2 = 10000;
%to then discard first 100
N1 = N1 + 500;
N2 = N2 + 500;

x1 = zeros(1,N1);
x2 = zeros(1,N2);
w = randn(1,max(N1,N2));

x1(1) = w(1);
x1(2) = 2.76*x1(1) + w(2);
x1(3) = 2.76*x1(2) - 3.81*x1(1) + w(3);
x1(4) = 2.76*x1(3) - 3.81*x1(2) + 2.65*x1(3) + w(4);

x2(1) = w(1);
x2(2) = 2.76*x2(1) + w(2);
x2(3) = 2.76*x2(2) - 3.81*x2(1) + w(3);
x2(4) = 2.76*x2(3) - 3.81*x2(2) + 2.65*x2(3) + w(4);

for i = 5:N1
    x1(i) = 2.76*x1(i-1) - 3.81*x1(i-2) + 2.65*x1(i-3) - 0.92*x1(i-4) + w(i);
end

for i = 5:N2
    x2(i) = 2.76*x2(i-1) - 3.81*x2(i-2) + 2.65*x2(i-3) - 0.92*x2(i-4) + w(i);
end

figure(1)
x1  = x1(501:end);
x2  = x2(501:end);
freq1 = 0:(length(x1)/2);
freq1 = freq1./length(x1);

freq2 = 0:(length(x2)/2);
freq2 = freq2./length(x2);

order = [3,4,5,8];
% order = 2:12;
for i = 1:length(order);
	subplot_tight(1,4,i,tightness);
	pxx1 = pyulear(x1,order(i),2^(nextpow2(length(x1))));
	pxx2 = pyulear(x2,order(i),2^(nextpow2(length(x2))));
	P1 = fft_psd(x1);
	P1 = P1(end/2:end);
	P2 = fft_psd(x2);
	P2 = P2(end/2:end);
	if i==0
		hold on 
		plot(freq1,P1,'g');
	end
	freq_pxx1 = 1:length(pxx1);
	freq_pxx1 = .5*freq_pxx1./length(pxx1);

	freq_pxx2 = 1:length(pxx2);
	freq_pxx2 = .5*freq_pxx2./length(pxx2);
	hold on
    freq_pxx1 = downsample(freq_pxx1,4);
    pxx1 = downsample(pxx1,4);
    freq_pxx2 = downsample(freq_pxx2,25);
    pxx2 = downsample(pxx2,25);
	plot(freq_pxx1,pxx1,'r');
	plot(freq_pxx2,pxx2,'LineWidth',1.5);
	hold off
	axis tight
	tit = sprintf('AR Spectrum estimate order %d',order(i));
	title(tit);
	if i == 1
		ylabel('Amplitude')
	end
	maxval = max(max(pxx1),max(pxx2));
	if i==0
		hold off
		maxval = max(P1);
	end
	xlabel('Freq (Normalised)')
	set(gca,'xtick',0:.05:.5)
	set(gca,'ytick',0:roundn(maxval/10,2):maxval)
	set(gca,'XGrid', 'on')
	set(gca,'YGrid', 'on')
end
legend('1000 samples','10000 samples')