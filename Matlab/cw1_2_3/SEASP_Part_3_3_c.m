clc
clear all
close all
%%
%Params
N = 1000;
trials = 100;
M =6;
mu = 0.05;
f0 = 10;
w_hist = zeros(M,N,trials);
e_hist=zeros(trials,N);
e_pred=zeros(trials,N);
for k=1:trials
    w_e = zeros(M,N);
    x = sin(f0*2*pi*(1:N)/N);
    v = randn(1,N+2);
    n = v(3:end)+0.5*v(1:end-2);
    s=x+n;
    x_h = zeros(1,N);
    for i=M+2:N
        u = n(i:-1:i-M+1)';
        u_est(i) = w_e(:,i)'*u;
        e(i) =  n(i) - u_est(i);
        w_e(:,i+1) =  w_e(:,i) + mu*e(i)*u;
        x_h(i) = s(i) -u_est(i);
    end
    w_hist(:,:,k) = w_e(:,1:N);
    e_hist(k,:) = e;
    e_pred(k,:) = x-x_h;
end
% plot(x_h)
plot(10*log10(mean(e_pred.^2)))
% 
%get ALE estimate from prev
%% load and plot
load part3_3c.mat
M = 3;
mu=0.01;
subplot(1,2,1)
pred_e_ANC_av(1:20) = pred_e_ANC_av(21);
pred_e_ALE_av(1:20) = pred_e_ALE_av(21);
plot([pred_e_ALE_av;pred_e_ANC_av]')
set(gca,'YGrid', 'on')
title(sprintf('M=%s $\\mu$ = %s',num2str(M),num2str(mu)))
leg1 = sprintf('ALE - MSPE=%s',num2str(mean(pred_e_ALE_av(30:end))));
leg2 = sprintf('ANC - MSPE=%s',num2str(mean(pred_e_ANC_av(30:end))));
legend(leg1,leg2)
xlabel('N')
ylabel('MPSE');

subplot(1,2,2)
load part3_3c1.mat
pred_e_ANC_av(1:20) = pred_e_ANC_av(21);
pred_e_ALE_av(1:20) = pred_e_ALE_av(21);
M = 6;
mu=0.02;
plot([pred_e_ALE_av;pred_e_ANC_av]')
set(gca,'YGrid', 'on')
title(sprintf('M=%s $\\mu$ = %s',num2str(M),num2str(mu)))
leg1 = sprintf('ALE - MSPE=%s',num2str(mean(pred_e_ALE_av(30:end))));
leg2 = sprintf('ANC - MSPE=%s',num2str(mean(pred_e_ANC_av(30:end))));
legend(leg1,leg2)
xlabel('N')
ylabel('MPSE');