clc
clear all
close all

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')
%Params
N=1200;
sigma = 0.25;
n = sqrt(sigma)*randn(1,N);
a2 = -0.81;
x=zeros(1,N);
%Filter
x(1) = n(1);
x(2) = 1.2728*x(1)+n(2);
for i=3:N
    if (i>= 400)&&(i<800)
        a1 = 0;
    else
        a1 = 1.2728;
    end
    x(i) = a1*x(i-1)+a2*x(i-2)+n(i);
end

[w_e,e] = full_rls(x,.9,.5,8);
% plot(w_e)
%%
for i=3:N
    a = [1 -w_e(i,:)];
    [h,w] = freqz(1,a,N) ;
    H(:,i) = abs(h).^2;
end
% plot(h)
%%
medianH = 30*median(median(H(:,i)));
H(H>medianH) = medianH;
H = H./N;
% H = resizem(H,[250 600]);
% H = downsample(H',5);
h = surf(H);
set(h,'LineStyle','none')
view(2)
title('AR(2) PSD estimate over time from RLS $\lambda=0.9$')
xlabel('Time Sample N')
ylabel('Frequency (unormalised)')
% set(gca,'YTickLabel',{'0';'0.15';'0.3';'0.5';'0.7';'0.8';'1'})
figure(2)
imagesc(1:1200,(1200:-1:1)/1200,H)