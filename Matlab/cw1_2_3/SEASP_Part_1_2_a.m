clc;
clear all;

L = 128;
M = 50;
% x= zeros(L,1);
x = sin(2*pi*((1:L))/16);% + sin(2*pi*((1:L))/24);
rectangle = rect(L-M,L+M,L*2-1);
% x(L+1:2*L) = x(L:-1:1);
% x = [0 x];
% x = fftshift(x);
% x = rect(0,10,L);
% x = padarray(x',3*L);
% x = x.*rect(800,950,L);
acs = xcov(x,'unbiased');
acs2 = xcov(x,'unbiased');
acs = acs.*rectangle;
% Pxx = abs(fft(x,nfft)).^2/length(x);
acs = [0 acs];
acs = fftshift(acs);
xf = fft(acs);
xf = fftshift(xf);


acs2 = fftshift(acs2);
xf2 = fft(acs2);
xf2 = fftshift(xf2);
% M = 64;
% L = 256;
% x= zeros(L,1);
% for i=1:(M)
%     x(i) = r(i-1,M);
% end
% for i=(L-M+2):L
%     x(i) = r(i-L-1,M);
% end
% xf = fft(x);
% xf = fftshift(xf);




min(real(xf))

% figure(1)
% plot(Pxx)
% figure(2)
% plot(x)

h1 = figure(1);
clf(h1);
subplot(1,3,1)
plot(x);
axis([0 L -1.1 1.1])
title('Plot of x')

subplot(1,3,2);

hold on
plot(fftshift(acs2))
plot(rectangle,'r','LineWidth',4)
hold off
legend('ACS','Rect')
axis([0 2*L-1 -.5 1.1])
tit = sprintf('Plot of the ACS of x(sin function)');
title(tit)

subplot(1,3,3);
hold on
plot(real(xf))
plot(real(xf2))
axis tight
hold off
tit = sprintf('Plot of PSD(x) (fft(acs))');
title(tit)