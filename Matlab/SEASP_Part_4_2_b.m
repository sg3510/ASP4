clc
clear all
close all

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')
%%
p1 = 100;
p2 = 0.01;
N=1000;
subplot(1,3,1)
alph = 1/sqrt(2);
gamma = 0;
theta = 1/sqrt(2);
p=alph^2-theta^2-gamma^2+1i*2*gamma*alph
x1 = randn(1,N);
x2 = randn(1,N);
x = alph*x1;
y = gamma*x1+theta*x2;
%z = x.*exp(1i*y);
z = x+1i*y;
% z = downsample(z,2);
scatter(real(z), imag(z),5)
title(sprintf('$\\alpha = \\frac{1}{\\sqrt{2}}$ $\\gamma = 0$ $\\theta = \\frac{1}{\\sqrt{2}}$ $p=%s$',num2str(p)))
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')
%------
subplot(1,3,2)
alph = sqrt(3)/2;
gamma = 1/(2*sqrt(3));
theta = 1/(sqrt(6));
p=alph^2-theta^2-gamma^2+1i*2*gamma*alph
x1 = randn(1,N);
x2 = randn(1,N);
x = alph*x1;
y = gamma*x1+theta*x2;
%z = x.*exp(1i*y);
z = x+1i*y;
% z = downsample(z,2);
scatter(real(z), imag(z),5)
title(sprintf('$\\alpha = \\frac{\\sqrt{3}}{2}$ $\\gamma = \\frac{1}{2\\sqrt{3}}$ $\\theta = \\frac{1}{\\sqrt{6}}$ $p=%s$',num2str(p)))
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')
%------
subplot(1,3,3)
alph = sqrt(17)/(2*sqrt(5));
gamma = 0;
theta = sqrt(3)/(2*sqrt(5));
p=alph^2-theta^2-gamma^2+1i*2*gamma*alph
x1 = randn(1,N);
x2 = randn(1,N);
x = alph*x1;
y = gamma*x1+theta*x2;
%z = x.*exp(1i*y);
z = x+1i*y;
% z = downsample(z,2);
scatter(real(z), imag(z),5)
title(sprintf('$\\alpha = \\frac{\\sqrt{17}}{2\\sqrt{5}}$ $\\gamma = 0$ $\\theta = \\frac{\\sqrt{3}}{2\\sqrt{5}}$ $p=%s$',num2str(p)))
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')