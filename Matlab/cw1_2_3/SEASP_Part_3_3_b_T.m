clear all
close all
clc

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')
%Program parameters
N = 1000;
numb_r = 100;
M = [5 10 15 20];
delta = 3;
u = [0.03 0.05];
ignore = 80;

%Initiliase parameters to generate sinusoid
t = (1:N);
f0 = 0.005;


%Initialise variables for the loop that calculates the average predictive
%error and MPSE for each value of Delta
MPSE_av = zeros(1, length(M));
pred_error_av = zeros(length(M), N);
x_est_av= zeros(length(M), N);

%Begin loop to to calculate the average predictive
%error and MPSE for each value of Delta


%%
%Program parameters
N = 1000;
numb_r = 100;
M=1:25;
delta = 5;
thedelt = delta;
u = [0.005 0.05];
ignore = 80;

%Initiliase parameters to generate sinusoid
t = (1:N);
f0 = 0.005;

%Initialise variables for the loop that calculates the average predictive
%error and MPSE for each value of Delta
MPSE_av = zeros(1, length(M));
pred_error_av = zeros(length(M), N);
x_est_av= zeros(length(M), N);

%Begin loop to to calculate the average predictive
%error and MPSE for each value of Delta
for j = 1:length(M)
    %Initialise ensemble
    pred_error = zeros(numb_r, N);
    x_est = zeros(numb_r, N);
    for k =1:numb_r
        %Generate Sinusoid signal
        x = sin(2*pi*f0*t);

        %Generate noise signals
        v = randn(1,N+2);
        n = v(3:end)+0.5*v(1:end-2);

        %Create corrupted signal
        s = x + n;
        
        %For different values of delta carry out ALE noise cancellation
        [w_hist, e, x_est(k,:)] = runLMS_ALE(s, u(1), M(j), delta);
        temp = length(x) - length(x_est(k,:)); 
        pred_error(k,:) = ((x(temp+1:end)-x_est(k,:)).^2);
        MPSE_av(j) = MPSE_av(j) + sum(pred_error(k,ignore:end))/length(pred_error(k,ignore:end))/numb_r;      
    end
    x_est_av(j,:) = mean(x_est);
    pred_error_av(j,:) = mean(pred_error);
    
end


%%
%Program parameters
N = 1000;
numb_r = 100;
M2 =2;
delta = 1:25;
u = [0.02 0.05];
ignore = 80;

%Initiliase parameters to generate sinusoid
t = (1:N);
f0 = 0.005;


%Initialise variables for the loop that calculates the average predictive
%error and MPSE for each value of Delta
MPSE_av2 = zeros(1, length(delta));
pred_error_av = zeros(length(delta), N);
x_est_av2= zeros(length(delta), N);

%Begin loop to to calculate the average predictive
%error and MPSE for each value of Delta
for j = 1:length(delta)
    %Initialise ensemble
    pred_error = zeros(numb_r, N);
    x_est = zeros(numb_r, N);
    for k =1:numb_r
        %Generate Sinusoid signal
        x = sin(2*pi*f0*t);

        %Generate noise signals
        v = randn(1,N+2);
        n = v(3:end)+0.5*v(1:end-2);

        %Create corrupted signal
        s = x + n;
        
        %For different values of delta carry out ALE noise cancellation
        [w_hist, e, x_est(k,:)] = runLMS_ALE(s, u(1), M2, delta(j));
        temp = length(x) - length(x_est(k,:)); 
        pred_error(k,:) = ((x(temp+1:end)-x_est(k,:)).^2);
        MPSE_av2(j) = MPSE_av2(j) + sum(pred_error(k,ignore:end))/length(pred_error(k,ignore:end))/numb_r;      
    end
    %Calculate the average estimated error and predictive error from
    %ensembles
    x_est_av2(j,:) = mean(x_est);
    pred_error_av(j,:) = mean(pred_error);
    
  
end

%%
clc
clear all
close all
load part3_3b_1.mat
%settings
u(1) = 0.01
M2 = 4
thedelt = 3


figure
subplot(1,4,1)
plot(delta, MPSE_av2)
title(sprintf('$\\mu$ = %s, M = %d',num2str(u(1)),M2))
xlabel('$\Delta$')
ylabel('MPSE[$\Delta$]');
set(gca,'YGrid', 'on')
load part3_3b_2.mat
%settings
u(1) = 0.02
M2 = 2
thedelt = 5

subplot(1,4,2)
plot(delta, MPSE_av2)
title(sprintf('$\\mu$ = %s, M = %d',num2str(u(1)),M2))
xlabel('$\Delta$')
% ylabel('MPSE[$\Delta$]');
set(gca,'YGrid', 'on')
load part3_3b_1.mat
%settings
u(1) = 0.01
M2 = 4
thedelt = 3

subplot(1,4,3)
plot(M, MPSE_av)
title(sprintf('$\\mu$ = %s  $\\Delta$ = %d',num2str(u(1)),thedelt))
xlabel('M')
ylabel('MPSE[$M$]');
set(gca,'YGrid', 'on')
load part3_3b_3_mu0005D5.mat
%settings
u(1) = 0.005
M2 = 2
thedelt = 5

subplot(1,4,4)
plot(M, MPSE_av)
title(sprintf('$\\mu$ = %s  $\\Delta$ = %d',num2str(u(1)),thedelt))
xlabel('M')
% ylabel('MPSE[$M$]');
set(gca,'YGrid', 'on')