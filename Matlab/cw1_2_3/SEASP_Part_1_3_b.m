clc;
clear all;
close all

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')

N = 256;
%% Part2
n = 1:N;
a1 = 1;
a2 = 1;
f = 0.2;


alpha = .7;

for alpha = 0.5:.1:1.0
    N=256;
x = a1*sin(f*2*pi*n) + a2*sin((f+alpha/N)*2*pi*n);% + randn(1,N);
x = x.*hamming(256)';
subplot(1,6,round(alpha*10)-4);
% figure(2)
% plot(x)
figure(1)
x = [x zeros(1,256*3)];
N = 512*2;
acs = xcov(x);%.*hamming(N*2-1)';
% plot(acs)
% w=bartlett(2*N-1)';
% acs = acs.*w;

acs = fftshift(acs);
acs = acs(end:-1:1);
acs_fft = fft(acs);
psd = fftshift(real(acs_fft))/(N);
freq = 1:(2*N-1);
freq = freq - N;
freq = freq/(2*N);
% psd = periodogram(x);
% figure(round(alpha*10)-4);
% subplot(2,6,round(alpha*10)-4);
plot(freq(1.3*N:(1.5*N)),psd(1.3*N:(1.5*N)))
axis tight
xlabel('Freq(Hz)')
if alpha==0.5
ylabel('Mag')
end
tit = sprintf('$\\alpha$:%.1f',alpha);
title(tit,'Interpreter','LaTex')

end