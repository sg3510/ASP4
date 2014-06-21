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
error = zeros(100,N);
w_history = zeros(N,2,100);
%% LMS Filter
for k = 1:100
    %setup
    w = sqrt(sigma)*randn(1,N+discard);
    x = filter(1,a,w)';
    x = x(discard+1:end);
    w_e = zeros(length(x),2);
    %init error vector
    e = zeros(1,N);
    e(1) = x(1);
    [w_e(2+1,:),x_e,e(2)] = lms_t1(x(2),w_e(2,:),[x(2-1) 0],mu);
    for i=3:length(x)-1
        [w_e(i+1,:),x_e,e(i)] = lms_t1(x(i),w_e(i,:),[x(i-1) x(i-2)],mu);
    end    
    
    error(k,:) = e;
    w_history(:,:,k) = w_e;
end
subplot(1,2,1)
% w_e = mean(w_history,3);
w_e_std = std(w_history,[],3);
 plot(w_e)
tit = sprintf('$\\mu$ = %s $\\mathbf{w}[end]$=[%s %s]',num2str(mu),num2str(w_e(end,1)),num2str(w_e(end,2)));
title(tit)
xlabel('N')
ylabel('$\mathbf{w}$ values')
set(gca,'ytick',0:.1:.8)
set(gca,'YGrid', 'on')
% plot(10*log10(mean(error.^2)))
% plot(w_e)
% (mu/2)*
% [mmse,emse] = msepred(ha,x,d)
legend('w[1]','w[2]')
%% redo
mu = 0.01;
for k = 1:100
    %setup
    w = sqrt(sigma)*randn(1,N+discard);
    x = filter(1,a,w)';
    x = x(discard+1:end);
    w_e = zeros(length(x),2);
    %init error vector
    e = zeros(1,N);
    e(1) = x(1);
    [w_e(2+1,:),x_e,e(2)] = lms_t1(x(2),w_e(2,:),[x(2-1) 0],mu);
    for i=3:length(x)-1
        [w_e(i+1,:),x_e,e(i)] = lms_t1(x(i),w_e(i,:),[x(i-1) x(i-2)],mu);
    end  
    error(k,:) = e;
    w_history(:,:,k) = w_e;
end
subplot(1,2,2)
% w_e = mean(w_history,3);
w_e_std = std(w_history,[],3);
 plot(w_e)
tit = sprintf('$\\mu$ = %s $\\mathbf{w}[end]$=[%s %s]',num2str(mu),num2str(w_e(end,1)),num2str(w_e(end,2)));
title(tit)
 legend('w[1]','w[2]')
xlabel('N')
set(gca,'ytick',0:.1:.8)
set(gca,'YGrid', 'on')
%  plot(10*log10(mean(error.^2)))
% abs(mean(mean(error(.8*end:end,:).^2))/.25-1)