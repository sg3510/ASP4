clc;
clear all;

M = 10;
L = 256;
x= zeros(L,1);
for i=1:(M+2)
%     disp(-M+i-1)
    x(i) = r(-M+i-1,M);
end
for i=(M+3):(2*M)
%     disp(i-M-1)
    x(i) = r(i-M-1,M);
end
xf = cust_fft(x);
xf = fftshift(xf);
sum(real(xf)-abs(xf));
disp('______________________')
M2 = 128;
L = 256;
x2= zeros(L,1);
for i=1:(M2+2)
%     disp(-M2+i-1)
    x2(i) = r(-M2+i-1,M2);
end
for i=(M2+3):(2*M2)
%     disp(i-M2-1)
    x2(i) = r(i-M2-1,M2);
end
xf2 = fft(x2);
xf2 = fftshift(xf2);
sum(real(xf2)-abs(xf2));

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
