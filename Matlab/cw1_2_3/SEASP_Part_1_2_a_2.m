x = [ zeros(1,20) ones(1,20) zeros(1,20) ];



[xAcf,lag] = xcov(x,'biased'); %xcov (removes mean) vs xcorr (does not remove mean)
N=length(xAcf);
n = 0:1:N-1;
f = 0:1:N-1; %f is not normalised yet!
f = f';

orth_basis = exp (-1*1i*2*pi*f*n/N);
xPSD = xAcf*orth_basis;



xf = fftshift(xPSD);
length(xf)
xAxis = -1 :(2*1/length(xf)) :(1 - 2*1/length(xf) ); %normalised to pi
subplot(1,2,1);
plot(xAxis, xf, 'LineWidth', 1);
xlim([min(xAxis) max(xAxis)]);
ylim([min(real(xf)) max(real(xf))]);
title('Spectral of Constant DC input of x = [ zeros(1,20) ones(1,20) zeros(1,20) ]');