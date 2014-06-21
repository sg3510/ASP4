clear all
close all
clc

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')

discard = 2000;

N = 500;
sigma = .25;
a1 = 0.1;
a2 = 0.8;
a = [1 -a1 -a2];
e = zeros(1,N);
w_e = zeros(N,2);
g = zeros(N,2);
P = zeros(2,2,N);
lambda = .99;
trials = 2000;
w_hist = zeros(N,2,trials);
e_hist = zeros(trials,N);
 %% RLS
for k = 1:trials
w = sqrt(sigma)*randn(1,N+discard);
x = filter(1,a,w)';
x = x(discard+1:end);
P(:,:,1) = eye(2);
P(:,:,2) = eye(2);
P(:,:,3) = eye(2);
e(1) = x(1);
e(2) = x(2);
for i = 3:N-1
    x_c = [x(i-1) x(i-2)]';
    e(i) = x(i) - w_e(i,:)*x_c;
    g(i,:) = P(:,:,i-1)*x_c* (lambda + x_c'*P(:,:,i-1)*x_c)^(-1);
    P(:,:,i) = lambda^(-1)*(P(:,:,i-1) - g(i,:)'*x_c'*P(:,:,i-1));
    w_e(i+1,:) = w_e(i,:) + g(i,:)*e(i);
%     x_c = [x(i) x(i-1)]';
%     e(i) = x(i) - w_e(i,:)*x_c;\
    
end
w_hist(:,:,k) = w_e;
e_hist(k,:) = e;
end
w_es1 = w_e;
w_e1 = mean(w_hist,3);
w_e1_std = std(w_hist,[],3);
e1 = mean(abs(e_hist).^2);
% plot(w_e,'LineWidth',1.5)
% plot(10*log10(e1))
%% RLS2
lambda = .95;
for k = 1:trials
w = sqrt(sigma)*randn(1,N+discard);
x = filter(1,a,w)';
x = x(discard+1:end);
P(:,:,1) = eye(2);
P(:,:,2) = eye(2);
P(:,:,3) = eye(2);
e(1) = x(1);
e(2) = x(2);
for i = 3:N-1
    x_c = [x(i-1) x(i-2)]';
    e(i) = x(i) - w_e(i,:)*x_c;
    g(i,:) = P(:,:,i-1)*x_c* (lambda + x_c'*P(:,:,i-1)*x_c)^(-1);
    P(:,:,i) = lambda^(-1)*(P(:,:,i-1) - g(i,:)'*x_c'*P(:,:,i-1));
    w_e(i+1,:) = w_e(i,:) + g(i,:)*e(i);
%     x_c = [x(i) x(i-1)]';
%     e(i) = x(i) - w_e(i,:)*x_c;\
    
end
w_hist(:,:,k) = w_e;
e_hist(k,:) = e;
end
w_es2 = w_e;
w_e2 = mean(w_hist,3);
w_e2_std = std(w_hist,[],3);
e2 = mean(abs(e_hist).^2);
% plot(w_e,'LineWidth',1.5)
% plot(10*log10(e1))
%% RLS3
lambda = .92;
for k = 1:trials
w = sqrt(sigma)*randn(1,N+discard);
x = filter(1,a,w)';
x = x(discard+1:end);
P(:,:,1) = eye(2);
P(:,:,2) = eye(2);
P(:,:,3) = eye(2);
e(1) = x(1);
e(2) = x(2);
for i = 3:N-1
    x_c = [x(i-1) x(i-2)]';
    e(i) = x(i) - w_e(i,:)*x_c;
    g(i,:) = P(:,:,i-1)*x_c* (lambda + x_c'*P(:,:,i-1)*x_c)^(-1);
    P(:,:,i) = lambda^(-1)*(P(:,:,i-1) - g(i,:)'*x_c'*P(:,:,i-1));
    w_e(i+1,:) = w_e(i,:) + g(i,:)*e(i);
%     x_c = [x(i) x(i-1)]';
%     e(i) = x(i) - w_e(i,:)*x_c;\
    
end
w_hist(:,:,k) = w_e;
e_hist(k,:) = e;
end
w_es3 = w_e;
w_e3 = mean(w_hist,3);
w_e3_std = std(w_hist,[],3);
e3 = mean(abs(e_hist).^2);
% plot(w_e,'LineWidth',1.5)
% plot(10*log10(e1))
%% RLS4
lambda = .90;
for k = 1:trials
w = sqrt(sigma)*randn(1,N+discard);
x = filter(1,a,w)';
x = x(discard+1:end);
P(:,:,1) = eye(2);
P(:,:,2) = eye(2);
P(:,:,3) = eye(2);
e(1) = x(1);
e(2) = x(2);
for i = 3:N-1
    x_c = [x(i-1) x(i-2)]';
    e(i) = x(i) - w_e(i,:)*x_c;
    g(i,:) = P(:,:,i-1)*x_c* (lambda + x_c'*P(:,:,i-1)*x_c)^(-1);
    P(:,:,i) = lambda^(-1)*(P(:,:,i-1) - g(i,:)'*x_c'*P(:,:,i-1));
    w_e(i+1,:) = w_e(i,:) + g(i,:)*e(i);
%     x_c = [x(i) x(i-1)]';
%     e(i) = x(i) - w_e(i,:)*x_c;\
    
end
w_hist(:,:,k) = w_e;
e_hist(k,:) = e;
end
w_es4 = w_e;
w_e4 = mean(w_hist,3);
w_e4_std = std(w_hist,[],3);
e4 = mean(abs(e_hist).^2);
% plot(w_e,'LineWidth',1.5)
% plot(10*log10(e1))
% %% 
% subplot(1,2,1)
% plot([e1; e2; e3]')
% legend('MSE RLS','MSE LMS $\mu=0.01$','MSE LMS $\mu=0.05$')
% ylabel('Mean-Square Error')
% xlabel('N')
% mse =  mean(e1(200:end));
% emse =  mean(e1(200:end))-0.25
% tit = sprintf('MSE=%s EMSE:%s $\\mathcal{M}$ = %s',num2str(mse),num2str(emse),num2str(emse/.25));
% title(tit);
% subplot(1,2,2)
% plot(10*log10([e1; e2; e3]'))
% legend('MSE RLS','MSE LMS $\mu=0.01$','MSE LMS $\mu=0.05$')
% ylabel('MSE (dB)')
% xlabel('N')
% mse =  mean(e3(250:end));
% emse = mse - .25;
% mse1 =  mean(e2(450:end));
% emse1 = mse1 - .25;
% tit = sprintf('LMS for $\\mu = 0.05$ MSE=%1.2f EMSE=%1.4f $\\mathcal{M}$=%1.4f \n LMS for $\\mu = 0.05$ MSE=%1.2f EMSE=%1.4f $\\mathcal{M}$=%1.4f',(mse),(emse),(emse/.25),(mse1),(emse1),(emse1/.25));
% title(tit);
% % set(gca,'ytick',0:.1:.9)
% % set(gca,'YGrid', 'on')
% % xlabel('N')
% % ylabel('$\mathbf{w}$')
% % legend('$\mathbf{w}[1]$ RLS','$\mathbf{w}[2]$ RLS','$\mathbf{w}$ LMS $\mu=0.01$','$\mathbf{w}$ LMS $\mu=0.05$-del','$\mathbf{w}$ LMS $\mu=0.01$-del','$\mathbf{w}$ LMS $\mu=0.05$')
% % title('500 Trials');
%% Plot all
% SEASP_Part_3_2_c_lot