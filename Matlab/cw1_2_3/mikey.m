close all;
clear all;
clc;

%Program parameters
N = 1000;
trials = 100;
M =2;
delta = 1;
mu = 0.05;

%Initiliase parameters to generate sinusoid
t = (1:N);
f0 = 0.005;


%Initialise variables for the loop that calculates the average predictive
%error and MPSE for each value of Delta
MPSE_av = zeros(length(delta));
pred_error_av = zeros(length(delta), N);
x_est_av= zeros(length(delta), N);

%Begin loop to to calculate the average predictive
%error and MPSE for each value of Delta
%Initialise ensemble
pred_error = zeros(trials, N);
x_est = zeros(trials, N);
for k =1:trials
    %Generate Sinusoid signal
    x = sin(2*pi*f0*t);

    %Generate noise signals
    v = randn(1,N+2);
    n = v(3:end)+0.5*v(1:end-2);
    w_hist = zeros(M,N);
    e = zeros(trials,N);
    %Create corrupted signal
    s = x + n;

    %For different values of delta carry out ALE noise cancellation
    for n = delta+M:N
        u = s(n-delta:-1:n-delta-M+1)';
        x_est(k,n) = w_hist(:,n)'*u;
        e(k,n) = s(n) - x_est(k,n);
        w_hist(:,n+1) = w_hist(:,n) + mu*e(k,n)*u;
    end
    pred_error(k,:) = ((x-x_est(k,:)).^2);
%     MPSE_av(j) = MPSE_av(j) + sum(pred_error(k,ignore:end))/length(pred_error(k,ignore:end))/trials;      
end
%Calculate the average estimated error and predictive error from
%ensembles
x_est_av = mean(x_est);
pred_error_av = mean(pred_error);

plot(pred_error_av)