clc;
clear all;

M = 10;
L = 255;
x= zeros(L,1);
for i=1:(M)
    x(i) = r(i-1,M);
end
for i=(L-M+2):L
    x(i) = r(i-L-1,M);
end
xf = fft(x);
xf = fftshift(xf);

x = sin(2*pi*((1:L)-1)/32);

M2 = 128;
x2= zeros(L,1);
for i=1:(M2)
    x2(i) = r(i-1,M2);
end
for i=(L-M2+2):L
    x2(i) = r(i-L-1,M2);
end
xf2 = fft(x2);
xf2 = fftshift(xf2);


figure(1)
subplot(2,2,1);
plot(x)
axis tight
tit = sprintf('Plot of the ACS x with M=%d and of length %d',M,L);
title(tit)

subplot(2,2,3);
plot(real(xf))
axis tight
tit = sprintf('Plot of fft(x) with M=%d and of length %d',M,L);
title(tit)

subplot(2,2,2)
plot(x2)
axis tight
tit = sprintf('Plot of the ACS x with M=%d and of length %d',M2,L);
title(tit)

subplot(2,2,4) 
plot(real(xf2))
axis tight
tit = sprintf('Plot of fft(x) with M=%d and of length %d',M2,L);
title(tit)

figure(2)
%w even
length(fft(x))
w = 2*pi*(-((L-1)/2):((L-1)/2))/L;


plot(w,fftshift(abs(fft(x)))) 
axis tight
