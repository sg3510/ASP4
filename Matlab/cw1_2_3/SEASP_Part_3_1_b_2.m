clear all
close all
clc

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')

discard = 500;

N = 500;
sigma = .25;
a1 = 0.1;
a2 = 0.8;
a = [1 -a1 -a2];
mu = 0.05;

trials = 100;
error = zeros(trials,N);
w_history = zeros(2,N);
%% LMS Filter
for k = 1:trials
    %setup
    w = sqrt(sigma)*randn(1,N+discard);
    x = filter(1,a,w)';
    x = x(discard+1:end);
    w_e = zeros(length(x),2);
    %init error vector
    e = zeros(1,N);
    e(1) = x(1);
    
    for i=3:length(x)
        e(i) = x(i) - w_e(i,:)*[x(i-1) x(i-2)]';
        w_e(i+1,:) = w_e(i,:)' + mu*[x(i-1) x(i-2)]' * e(i);
    end    
    error(k,:) = e;
end
hold on
plot(10*log10(mean(error.^2)))
tit = sprintf('Error of AR(2) process with N=%d $\\sigma$ = %s $a_1=%s$ $a_2=%s$',N,num2str(sigma),num2str(a1),num2str(a2));
title(tit)
%% redo
mu = 0.01;
for k = 1:trials
    %setup
    w = sqrt(sigma)*randn(1,N+discard);
    x = filter(1,a,w)';
    x = x(discard+1:end);
    w_e = zeros(length(x),2);
    %init error vector
    e = zeros(1,N);
    e(1) = x(1);
    
    for i=3:length(x)
        e(i) = x(i) - w_e(i,:)*[x(i-1) x(i-2)]';
        w_e(i+1,:) = w_e(i,:)' + mu*[x(i-1) x(i-2)]' * e(i);
    end    
    error(k,:) = e;
end
plot(10*log10(mean(error.^2)),'r')
hold off
legend('$\mu = 0.05$','$\mu = 0.01$')
h = legend;
set(h, 'interpreter', 'latex')
xlabel('Sample Iteration')
ylabel('Error(dB)')