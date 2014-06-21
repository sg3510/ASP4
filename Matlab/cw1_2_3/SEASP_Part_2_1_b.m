%%
clc;
clear all;
close all
addpath('Export')


set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)



N = 2^10 +1; %larger than 7


f0 = 0.25;
sigm1 = .5;
sigm2 = .1;
alph = pi / 2;

freq =(1:(N));
freq = freq/(2*length(freq));


subplot(1,2,1)
[x,y] = gen2_1_b(N,f0,sigm1,sigm2,alph);
% x = x.*hamming(length(x))';
% y = y.*hamming(length(y))';
Cxy = mscohere(x,y)%,ones(1,N));
freq =(1:(length(Cxy)));
freq = freq/(2*length(freq));
plot(freq,Cxy)
title('$\alpha = \frac{\pi}{2}$')
axis([0 .5 0 1])
ylabel('$C_{xy}(\omega)$')
xlabel('freq')
subplot(1,2,2)
alph = pi/10;
[x,y] = gen2_1_b(N,f0,sigm1,sigm2,alph);
Cxy = mscohere(x,y);%,ones(1,N));
plot(freq,Cxy)
title('$\alpha = \frac{\pi}{10}$')
axis([0 .5 0 1])
xlabel('freq')

%% Part 2 (with noise)

clc;
clear all;
close all

N = 2^10 +1; %larger than 7

n = 1:N;

f0 = 0.25;
sigm1 = .1;
sigm2 = 0.3;
alph = pi / 2;


freq =(1:(N/16));
freq = freq/(2*length(freq));

for i=1:5
    for j=1:5
        sigm1 = (i-1)*10^((i-4));
        sigm2 = (j-1)*10^((j-4));
        [x,y,snr_x,snr_y] = gen2_1_b(N,f0,sigm1,sigm2,alph);
        Cxy = mscohere(x,y);%,ones(1,N));
        freq =(1:(length(Cxy)));
freq = freq/(2*length(freq));
        i*3 + j-3
        subplot(5,5,i*5 + j-5)
        axis([0 .5 0 1])
        plot(freq,Cxy)
        tit = sprintf('$\\sigma_1 =$%s $\\sigma_2 =$%s $SNR_X$ = %s $SNR_Y$ = %s',num2str(sigm1),num2str(sigm2),num2str(snr_x),num2str(snr_y));
        title(tit)
    end
end