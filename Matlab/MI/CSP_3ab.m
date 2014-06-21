close all;
clear all;
clc;

N = 1200;
a1 = zeros(1,N);
a1(1:399) = 1.2728;
a1(800:N) = 1.2728;
a2 = -0.81;
noise_var = 0.25;
ord =2;
lambda = 0.9;
u = 0.1;
win_len = 20;
init =1;
t = 1:N-1;

%Define noise
n = sqrt(noise_var)*randn(1,N+2);

%Generate Signal
x = zeros(1,N+2);
x(1) = n(1);
x(2) = a1(2)*x(1) + n(2);

for j = 3:N
    x(j) = a1(j)*x(j-1) + a2*x(j-2) + n(j); 
end

%Remove first two samples of x which are required in the startup
x = x(3:N+2);

%%
%3a)
%Program Parameters
%Calculate coefficients of process using aryule
a=aryule(x,2);
%Calculate frequncy response
[h,w] = freqz(1,a, 2048);
%Plot Frequency Response
figure(1)
plot(w,20*log10(abs(h)),'b','linewidth',2);
xlabel('Normalized Angular Frequency (radians)'); ylabel('dB/');
title('Estimated Power Spectral Density of AR(2), N = 2048');

%Plot Spectrogram
figure(2)
spectrogram(x, hann(100), 50, 512,1,'yaxis');

%%
%3b)
    
    x = x';
    P = zeros(ord, ord, N);
    e = zeros(1,N);
    g = zeros(N,ord);
    w_hist = zeros(N,ord);
    x_est = zeros(1,N);
    
    %Initialise RLS variables up to the order index, need this as minimum
    %before can start computing estimates
    for j=1:ord
    P(:,:,j) = eye(ord);
    e(j) = x(j);
    end
   
    %Estimate coefficient values at each time instant
    for j = ord+1:N-1
        x_prev = x(j-1:-1:j-ord);
        x_est(j)= w_hist(j,:)*x_prev;  
        e(j) = x(j) -  x_est(j);
        g(j,:) = (P(:,:,j-1)*x_prev)./(lambda + x_prev'*P(:,:,j-1)*x_prev);
        P(:,:,j) = (lambda^(-1))*(P(:,:,j-1) - g(j,:)'*x_prev'*P(:,:,j-1));
        w_hist(j+1,:) = w_hist(j,:) + g(j,:)*e(j);
        [h,w] = freqz(1, [1; w_hist(j+1,1); w_hist(j+1,2)], 512);
        H(:,j) = abs(h).^2;
    end
    
   medianH = 30*median(median(H(:,j)));
   H(H>medianH) = medianH;%Remove outliers in matrix
   
   %Plot time frequency diagram 
   %plot3(w,t,H);
   figure(3)
   surf(t,w, H,'EdgeColor','none');
   view(2);
   axis([1 1199 0 3.14]);
   xlabel('Time (Samples)'); ylabel('Normalized angular frequency (rads)'); title('Time-Frequency Spectrum derived from coefficients estimated by RLS');
   
  
   
   
    





