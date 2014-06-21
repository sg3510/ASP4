clear all
close all
clc

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')

%% Params
N = 500;
mu1 = 1;
mu2 = 0.1;
M=2;
sigma = 0.5;
p=0.005;
p2 = 1;
alpha = .8;

%Generate signal
n = sqrt(sigma)*randn(1,N);
x = filter([1 0.9], 1, n);
%LMS 1
[w_e1, x_e, e1, coef, epsi] = nlms_gngd(x, n, mu1, M, p2);
% plot(w_e1)
%GASS
[w_e2, e2, x_e, ~] = lms_ma_gass(x, n, 1, M,p);
figure(1)
subplot(1,2,1)
hold on
%rgbkm
plot(w_e1,'r')
plot(w_e2,'b')
hold off
lms1_str = sprintf('NLMS-GNGD \\mu =%s \\rho=%s',num2str(mu1),num2str(p2));
lms2_str = sprintf('GASS Benveniste \\mu =%s \\rho=%s',num2str(mu2),num2str(p2));
legend(lms1_str,lms1_str,lms2_str)
xlabel('N')
ylabel('$\tilde{\mathbf{w}}(n) = w_0-w(n)$')
title(sprintf('Coefficient Estimates for M=%d',M))
set(gca,'YGrid','on');
axis([0 100 0 1.1])
subplot(1,2,2)
hold on
%rgbkm
plot(10*log10(e1.^2),'r')
plot(10*log10(e2.^2),'b')
hold off
lms1_str = sprintf('LMS \\mu =%s',num2str(mu1));
lms2_str = sprintf('LMS \\mu =%s',num2str(mu2));
% legend(lms1_str,lms2_str,gass1_str,gass2_str,gass3_str)
xlabel('N')
axis([0 200 -300 10])
set(gca,'YGrid','on');
ylabel('Error (dB)')
%% 