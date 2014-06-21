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
mu = 0.01;
trials = 100;
error = zeros(trials,N);
w_history = zeros(2,N);
%% LMS Filter
fprintf('mu=%1.2f\n',mu)
for k = 1:trials
    %setup
    w = sqrt(sigma)*randn(1,N+discard);
    x = filter(1,a,w)';
    x = x(discard+1:end);
    w_e = zeros(length(x),2);
    %init error vector
    e = zeros(1,N);
    e(1) = x(1);
    e(2) = x(2);
    for i=3:length(x)
        e(i) = x(i) - w_e(i,:)*[x(i-1) x(i-2)]';
        w_e(i+1,:) = w_e(i,:)' + mu*[x(i-1) x(i-2)]' * e(i);
    end    
    error(k,:) = e;
end
format short
e = mean((error.^2));
% plot(10*log10(e))
fprintf('MSE=%1.4f\n',mean(e(end-100:end)))
fprintf('EMSE=%1.4f\n',mean(e(end-100:end)) - sigma)
fprintf('Misad=%1.4f\n',(mean(e(end-100:end)) - sigma)/sigma)
% plot(mean(error.^2))
% plot(w_e)
% (mu/2)*
% [mmse,emse] = msepred(ha,x,d)
%% redo
mu = 0.05;
fprintf('mu=%1.2f\n',mu)
for k = 1:trials
    %setup
    w = sqrt(sigma)*randn(1,N+discard);
    x = filter(1,a,w)';
    x = x(discard+1:end);
    w_e = zeros(length(x),2);
    %init error vector
    e = zeros(1,N);
    e(1) = x(1);
    e(2) = x(2);
    for i=3:length(x)
        e(i) = x(i) - w_e(i,:)*[x(i-1) x(i-2)]';
        w_e(i+1,:) = w_e(i,:)' + mu*[x(i-1) x(i-2)]' * e(i);
    end    
    error(k,:) = e;
end
e = mean((error.^2));
% plot(10*log10(e))
fprintf('MSE=%1.4f\n',mean(e(end-100:end)))
fprintf('EMSE=%1.4f\n',mean(e(end-100:end)) - sigma)
fprintf('Misad=%1.4f\n',(mean(e(end-100:end)) - sigma)/sigma)