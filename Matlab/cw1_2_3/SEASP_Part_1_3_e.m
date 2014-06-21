clc;
clear all;
close all
addpath('Export')


set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')
N = 256;
b1 = 4/N;
b2 = 12/N;
%%
figure(1)
% hold on
% for i = 6:10
%     subplot(1,5,i-5);
n = 0:1:(2*N-1);
n = n/(2*pi*N);
% Part1
w_b = (sin(n*N/2)./sin(n/2)).^2*(1/N^2);
% length(w_b)
% w_b = conv(w_b,w_b);
% w_b = w_b((2*N):end);
w_b = w_b/max(w_b);
% w_b = w_b/max(w_b);
% plot(n/(2*pi),w_b)
% w_b = 20*log10(w_b);
% subplot(1,2,1)
plot(n/(2*pi),w_b)
line('XData',[b1 b1],'YData',[0 1],'Color','r','LineWidth',2,'LineStyle','--')
line('XData',[b2 b2],'YData',[0 1],'Color','g','LineWidth',2,'LineStyle','--')
tit = sprintf('N=%d',N);
title(tit)
xlabel('Freq(Hz)')
ylabel('Amplitude (normalised)')
axis tight
%%
% subplot(1,2,2)
plot(n/(2*pi),20*log10(w_b))


line('XData',[b1 b1],'YData',[0 -145],'Color','r','LineWidth',2,'LineStyle','--')
text(b1+0.001,-70,'4/N')
line('XData',[b2 b2],'YData',[0 -145],'Color','g','LineWidth',2,'LineStyle','--')
text(b2+0.00051,-70,'12/N')
xlabel('Freq(Hz)')
ylabel('Amplitude (dB)')
tit = sprintf('N=%d',N);
title(tit)
% plot(n/(2*pi),5*log(w_b))
axis tight

% end
% hold off