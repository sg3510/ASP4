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
mu1 = 0.01;
mu2 = 0.1;
M=2;
sigma = 0.5;
p=0.005;
p2 = 0.04;
alpha = .8;

%Generate signal
n = sqrt(sigma)*randn(1,N);
x = filter([1 0.9], 1, n);
%LMS 1
[w_e1, e, x_e] = lms_ma(x, n, mu1, M);
[w_e2, e, x_e] = lms_ma(x, n, mu2, M);
% plot(w_e)

%GASS
[w_e3, e, x_e, ~] = lms_ma_gass(x, n, 1, M,p);
[w_e4, e, x_e, ~] = lms_ma_gass(x, n, 2, M,p,alpha);
[w_e5, e, x_e, ~] = lms_ma_gass(x, n, 3, M,p2);
figure(1)
subplot(1,2,1)
hold on
%rgbkm
plot(w_e1(:,2)-.9,'r')
plot(w_e2(:,2)-.9,'g')
plot(w_e3(:,2)-.9,'b')
plot(w_e4(:,2)-.9,'k')
plot(w_e5(:,2)-.9,'m')
hold off
lms1_str = sprintf('LMS \\mu =%s',num2str(mu1));
lms2_str = sprintf('LMS \\mu =%s',num2str(mu2));
gass1_str = sprintf('LMS GASS \\rho =%s',num2str(p));
gass2_str = sprintf('LMS GASS \\rho =%s \\alpha = %1.1f',num2str(p),alpha);
gass3_str = sprintf('LMS GASS \\rho =%s',num2str(p2));
legend(lms1_str,lms2_str,gass1_str,gass2_str,gass3_str)
xlabel('N')
ylabel('$\tilde{\mathbf{w}}(n) = w_0-w(n)$')
subplot(1,2,2)
hold on
%rgbkm
plot(w_e1(:,2)-.9,'r')
plot(w_e2(:,2)-.9,'g')
plot(w_e3(:,2)-.9,'b')
plot(w_e4(:,2)-.9,'k')
plot(w_e5(:,2)-.9,'m')
hold off
lms1_str = sprintf('LMS \\mu =%s',num2str(mu1));
lms2_str = sprintf('LMS \\mu =%s',num2str(mu2));
gass1_str = sprintf('LMS GASS \\rho =%s',num2str(p));
gass2_str = sprintf('LMS GASS \\rho =%s \\alpha = %1.1f',num2str(p),alpha);
gass3_str = sprintf('LMS GASS \\rho =%s',num2str(p2));
% legend(lms1_str,lms2_str,gass1_str,gass2_str,gass3_str)
xlabel('N')
axis([0 50 -1 .2])
%% 