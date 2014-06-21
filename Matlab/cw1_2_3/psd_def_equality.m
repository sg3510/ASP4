%% PSD_Def
clc
clear all
close all
set(0,'DefaultTextInterpreter','latex')
%define vars
N=512;
f0 = 0.25;
f1 = 0.001;

%% make sin wave
n=1:N;
x = sin(f0*2*pi*n);
y = sin(f0*2*pi*n) + sin(f1*2*pi*n);

%% definition 1
acs = xcov(y,'biased');
acs = fftshift(acs);
acs = acs(end:-1:1);
psd_def1 = real(fft(acs));
fprintf('The following data is real, imag:%s\n',num2str(sum(imag(fft(acs)))))
psd_def1 = fftshift(psd_def1);
figure(1);
subplot(1,2,1);
freq = (1:N*2-1) - N;
freq = freq/(2*N);
plot(freq,psd_def1)
axis tight
title('Definition 1 of PSD')
ylabel('Magnitude')
xlabel('Freq ($\pi$ normalised)')
%% definition 2
%(1/N) * abs( sum_(0)^(N-1){x(n)e*(-jnw)} )^2

expn = (0:(N-1))'*ones(1,N);

omega = 2*pi*(0:(N-1))/N;
omega = omega' * ones(1,N);

expn = omega'.*expn;
expn = exp(-1i*expn);

x_t = y'*ones(1,N);
expn = x_t .* expn;

expn = sum(expn);

psd_def2 = (1/N)*abs(expn).^2;
psd_def2 = fftshift(psd_def2);
psd_def2 = (1/N)*abs(fft(y));
subplot(1,2,2);
freq = (1:N) - N/2;
freq = freq / N;
plot(freq,psd_def2)
axis tight
title('Definition 1 of PSD')

xlabel('Freq ($\pi$ normalised)')