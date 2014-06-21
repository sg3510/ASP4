clc;
clear all;
close all
addpath('Export')


set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)



N = 512;
rho = .9;

x1 = randn(1,N);
x2 = randn(1,N);

y = rho*x1 + sqrt(1-rho^2)*x2;

Cxy = mscohere(x1,y);

plot(Cxy);

freq =(1:(N/4+1));
freq = freq/length(freq);
for i=1:6
    rho = (i-1)/5
    subplot(1,6,i)
    y = rho*x1 + sqrt(1-rho^2)*x2;
    Cxy = mscohere(x1,y);
    a = mean(Cxy)*ones(1,length(Cxy));
    hold on
    plot(freq,Cxy);
    if i ~= 6
    plot(freq,a','r--','LineWidth',3);
    end
    hold off
    axis([0 1 0 1])
    if i ==6
        axis([0 1 0 1.1])
    end
    tit = sprintf('$\\rho$ = %s', num2str(rho))
    title(tit)
    xlabel('Freq')
    if i==1
        ylabel('$C_{xy}(f)$')
    end
end
