clc;
clear all;
close all

N = 256;
%%
figure(1)
hold on
for i = 6:10
    subplot(1,5,i-5);
    N=2^i;
n = -(N-1)*pi:pi:(N-1)*pi;
n = n/(8*pi*N);
% Part1
w_b = (1/N)*(sin(n*N/2)./sin(n/2)).^2;
w_b = w_b/max(w_b);
a = find(w_b <= 0.5);
index = find(diff(a) == max(diff(a)));
wid = n(a(index+1))-n(a(index));
% plot(n/(2*pi),w_b)
plot(n/(2*pi),[ones(1,N*2-1)*0.5 ;w_b])
tit = sprintf('N=%d and width=%2.3fHz',N,wid/2);
title(tit)
% plot(n/(2*pi),5*log(w_b))
axis tight

end
hold off
%% Part2
subplot(1,3,1)
N=512;
n = 1:N;
a1 = 2;
a2 = 1;
alpha = 10;
f = 0.2;

x = a1*sin(f*2*pi*n) + a2*sin((f+alpha/N)*2*pi*n);% + randn(1,N);
x = x.*bartlett(N)';
acs = xcov(x);
% w=bartlett(2*N-1)';
% acs = acs.*w;

acs = fftshift(acs);
acs = acs(end:-1:1);
psd = fftshift(real(fft(acs)));
a = psd / max(psd);
a = real(10*log10(a));
freq = 1:(2*N-1);
freq = freq/length(freq);
c = 10*log10(0.5);
plot(freq,[fftshift(a); c*ones(1,2*N-1)])
axis tight
tit = sprintf('N=%d and width=Hz',N);
title(tit)
xlabel('freq(Hz)')
ylabel('dB')
%2
subplot(1,3,2)
N=1024;
n = 1:N;
a1 = 2;
a2 = 1;
alpha = 10;
f = 0.2;

x = a1*sin(f*2*pi*n) + a2*sin((f+alpha/N)*2*pi*n);% + randn(1,N);
x = x.*bartlett(N)';
acs = xcov(x);
% w=bartlett(2*N-1)';
% acs = acs.*w;

acs = fftshift(acs);
acs = acs(end:-1:1);
psd = fftshift(real(fft(acs)));
a = psd / max(psd);
a = real(10*log10(a));
freq = 1:(2*N-1);
freq = freq/length(freq);
c = 10*log10(0.5);
plot(freq,[fftshift(a); c*ones(1,2*N-1)])
axis tight
tit = sprintf('N=%d and width=Hz',N);
title(tit)
xlabel('freq(Hz)')
%3
subplot(1,3,3)
N=2048;
n = 1:N;
a1 = 2;
a2 = 1;
alpha = 10;
f = 0.2;

x = a1*sin(f*2*pi*n) + a2*sin((f+alpha/N)*2*pi*n);% + randn(1,N);
x = x.*bartlett(N)';
acs = xcov(x);
% w=bartlett(2*N-1)';
% acs = acs.*w;

acs = fftshift(acs);
acs = acs(end:-1:1);
psd = fftshift(real(fft(acs)));
a = psd / max(psd);
a = real(10*log10(a));
freq = 1:(2*N-1);
freq = freq/length(freq);
c = 10*log10(0.5);
plot(freq,[fftshift(a); c*ones(1,2*N-1)])
axis tight
tit = sprintf('N=%d and width=Hz',N);
title(tit)
xlabel('freq(Hz)')