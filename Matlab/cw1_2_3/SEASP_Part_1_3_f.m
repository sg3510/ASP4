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


alpha = 4;
i=1;
sidelobe = 60;
for a2 = [1,.1,.01,.001]
    N=256;
x = a1*sin(f*2*pi*n) + a2*sin((f+alpha/N)*2*pi*n);% + randn(1,N);
% x = x.*chebwin(length(x),sidelobe)';
% x = x.*hamming(256)';
subplot(1,4,i);
i = i + 1;
% figure(2)
% plot(x)
figure(1)
x = [x zeros(1,256*6) x(end:-1:1)];
N = 512*2;
% N = 128;
acs = xcov(x);%.*hamming(N*2-1)';
acs = acs.*chebwin(length(acs),sidelobe)';
% plot(acs)
% w=bartlett(2*N-1)';
% acs = acs.*w;

acs = fftshift(acs);
acs = acs(end:-1:1);
acs_fft = fft(acs);
psd = fft_psd(x);
% psd = abs(fft(x)).^2./(length(x));
% psd = fftshift(psd);
freq = 1:(2*N-1);
freq = freq - N;
freq = freq/(2*N);
% psd = periodogram(x);
% figure(round(alpha*10)-4);
% subplot(2,6,round(alpha*10)-4);
psd = psd/max(psd);
psd = 10*log10(psd);
plot(freq(1.3*N:(1.55*N)),psd(1.3*N:(1.55*N)))
axis tight
xlabel('Freq(Hz)')
if a2==1
ylabel('Mag (dB)')
end
tit = sprintf('$\\alpha$=%s $a_1$=%s $a_2$=%s Sidelobe = %sdB',num2str(alpha),num2str(a1),num2str(a2),num2str(sidelobe));
title(tit,'Interpreter','LaTex')

end