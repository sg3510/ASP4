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
subplot(2,4,1)
x = randn(1,N);
y = randn(1,N);
z = x.*exp(1i*y);
z = downsample(z,2);
scatter(real(z), imag(z),10)
title('S.P. uncorr x $\sim$ $\mathcal{N}$ y $\sim$ $\mathcal{N}$')
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')
%------
subplot(2,4,2)
x = p1*randn(1,N);
y = p2*randn(1,N);
z = x.*exp(1i*y);
z = downsample(z,2);
scatter(real(z), imag(z),10)
title('D.P. uncorr x $\sim$ $\mathcal{N}$ y $\sim$ $\mathcal{N}$')
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')
%------
subplot(2,4,3)
x = randn(1,N);
y = rand(1,N);
z = x.*exp(1i*y);
z = downsample(z,2);
scatter(real(z), imag(z),10)
title('D.P. uncorr x $\sim$ $\mathcal{N}$ y $\sim$ $\mathcal{U}$')
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')
%------
subplot(2,4,6)
x = randn(1,N);
y = p2*x;
z = x.*exp(1i*y);
z = downsample(z,2);
scatter(real(z), imag(z),10)
title('D.P. corr x $\sim$ $\mathcal{N}$ y $\sim$ $\mathcal{N}$')
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')
%------
subplot(2,4,5)
x = rand(1,N);
y = 5*x;
z = x.*exp(1i*y);
z = downsample(z,2);
scatter(real(z), imag(z),10)
title('D.P. corr x $\sim$ $\mathcal{U}$ y $\sim$ $\mathcal{U}$')
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')

%------
subplot(2,4,4)
x = rand(1,N);
y = rand(1,N);
z = x.*exp(1i*y);
z = downsample(z,2);
scatter(real(z), imag(z),10)
title('S.P. uncorr x $\sim$ $\mathcal{U}$ y $\sim$ $\mathcal{U}$')
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')
%------
subplot(2,4,7)
x = randn(1,N);
y = 5*x;
z = x.*exp(1i*y);
z = downsample(z,2);
scatter(real(z), imag(z),10)
title('D.P. corr x $\sim$ $\mathcal{N}$ y $\sim$ $\mathcal{N}$')
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')
%------
subplot(2,4,8)
x = randn(1,N);
y = x;
z = x.*exp(1i*y);
z = downsample(z,2);
scatter(real(z), imag(z),10)
title('S.P. corr x $\sim$ $\mathcal{N}$ y $\sim$ $\mathcal{N}$')
set(gca,'XGrid','on','YGrid','on');
xlabel('$\mathcal{R}$')
ylabel('$\mathcal{I}$')