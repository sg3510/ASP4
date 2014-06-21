clear all
close all
clc

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')
%% Start

%Params
N = 1000;
trials = 100;
M =2;
delta = 5;
mu = 0.05;
f0 = 5;


d = [1,2,3,5,20];
for j = 1:5
    delta = d(j)
pred_er = zeros(trials, N);
x_est = zeros(trials, N);
MSPE = zeros(trials, 1);
for k =1:trials
    %Sine
    x = sin(2*pi*f0*(1:N)/N);
    
    %noise
    v = randn(1,N+2);
    n = v(3:end)+0.5*v(1:end-2);
    w_hist = zeros(M,N);
    e = zeros(trials,N);
    s = x + n;
    for n = delta+M:N
        u = s(n-delta:-1:n-delta-M+1)';
        x_est(k,n) = w_hist(:,n)'*u;
        e(k,n) = s(n) - x_est(k,n);
        w_hist(:,n+1) = w_hist(:,n) + mu*e(k,n)*u;
    end
    pred_er(k,:) = ((x-x_est(k,:)).^2); 
    MSPE(k) = sum((x(100:end)-x_est(k,100:end)).^2)/N;
end

x_e_av = mean(x_est);
pred_er_av = mean(pred_er);
subplot(2,5,j)
plot(x_e_av)
tit = sprintf('Estimated $\\hat{x}$ $\\Delta=%d$',delta);
title(tit)
if j==1
ylabel('$\hat{x}[n]$')
end
xlabel('n')
subplot(2,5,j+5)
plot(10*log10(pred_er_av))
if j==1
ylabel('$\epsilon[n]$')
end
xlabel('n')
tit = sprintf('Prediction Error MSPE=%s',num2str(mean(MSPE)));
title(tit)
end