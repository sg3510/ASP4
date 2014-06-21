close all;
clear all;
clc;

%Program parameters
N = 1000;
numb_r = 100;
M =6;
delta = 3;
u = [0.02 0.05];
ignore = 80;

%Initiliase parameters to generate sinusoid
t = (1:N);
f0 = 0.005;



%Begin loop to to calculate the average predictive
%error and MPSE for each value of Delta
    MPSE_av_ALE = 0;
    MPSE_av_ANC = 0;
    pred_error_ALE = zeros(numb_r, N);
    pred_error_ANC = zeros(numb_r, N);
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
        [w_hist, e, x_est(k,:)] = runLMS_ALE(s, u(1), M, delta);
        temp = length(x) - length(x_est(k,:)); 
        pred_error_ALE(k,:) = ((x(temp+1:end)-x_est(k,:)).^2);
        MPSE_av_ALE = MPSE_av_ALE + sum(pred_error_ALE(k,ignore:end))/length(pred_error_ALE(k,ignore:end))/numb_r;
        
        %v(1:end-2)
        
        [w_hist, x_est(k,:)] = runLMS_ANC(s, n', u(1), M);
        temp = length(x) - length(x_est(k,:));  
        pred_error_ANC(k,:) = ((x(temp+1:end)-x_est(k,:)).^2);
        MPSE_av_ANC = MPSE_av_ANC + sum(pred_error_ANC(k,ignore:end))/length(pred_error_ANC(k,ignore:end))/numb_r;
    end
    
   pred_error_ALE_av = mean(pred_error_ALE);
   pred_error_ANC_av = mean(pred_error_ANC);

    
    %Plot Results
    t1 = sprintf('ANC Pred. Error, MPSE = %.4f', MPSE_av_ANC);
    t2 = sprintf('ALE Pred. Error, MPSE = %.4f', MPSE_av_ALE);
    
    figure(2)
    subplot(1,2,1)
    plot(10*log10(pred_error_ALE_av(ignore:end))), title(t2), xlabel('Time (Sample Number)'), ylabel('Prediction Error (dB)')
    subplot(1,2,2)
    plot(10*log10(pred_error_ANC_av(ignore:end))), title(t1), xlabel('Time (Sample Number)'), ylabel('Prediction Error (dB)')
    
    
