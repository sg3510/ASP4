clc
clear all
close all

load EEG_Data_Assignment2.mat
N = length(Cz);
f0 = 50;
n_gen = 3*sin(2*pi*(1:N)*f0/fs)+1.5*randn(1,N);
% n_gen = n_gen/N*1.1;
%check sin wave
% plot(fs*(1:N)/N,abs(fft(n_gen)))

%ANC for POz
mu = 0.01;
M = 10;
n_est = zeros(1,N);
x_e = zeros(1,N);
w_e = zeros(M,N);

for n = M+1:N
    u = n_gen(n-1:-1:n-M)';
    n_est(n) = w_e(:,n)'*u;
    x_e(n) = POz(n) - n_est(n);
    w_e(:,n+1) = w_e(:,n) + mu*x_e(n)*u;
end
% plot(fs*(1:N)/N,abs(fft(x_e)))

%spectogram plot
fft_len = 8192;
win_len = 4096;
win_han = hanning(win_len);
subplot(1,2,1)
spectrogram(x_e, win_han, round(0.25*win_len), fft_len, fs, 'yaxis')
axis([0 N/fs-1 0 100])
title('POz with noise removed')
xlabel('Time(s)')
subplot(1,2,2)
spectrogram(POz, win_han, round(0.25*win_len), fft_len, fs, 'yaxis')
axis([0 N/fs-1 0 100])
title('POz (original)')
xlabel('Time(s)')
%% Coherence Spectrum
%save POz filtered
Poz_filt = x_e;
%gen sine
n_gen = .7*sin(2*pi*(1:N)*f0/fs)+0.5*randn(1,N);
%ANC for Cz
mu = 0.01;
M = 10;
n_est = zeros(1,N);
x_e = zeros(1,N);
w_e = zeros(M,N);

for n = M+1:N
    u = n_gen(n-1:-1:n-M)';
    n_est(n) = w_e(:,n)'*u;
    x_e(n) = Cz(n) - n_est(n);
    w_e(:,n+1) = w_e(:,n) + mu*x_e(n)*u;
end
%
% subplot(1,2,1)
% spectrogram(x_e, win_han, round(0.25*win_len), fft_len, fs, 'yaxis')
% axis([0 N/fs-1 0 200])
% title('POz with noise removed')
% xlabel('Time(s)')
% subplot(1,2,2)
% spectrogram(POz, win_han, round(0.25*win_len), fft_len, fs, 'yaxis')
% axis([0 N/fs-1 0 200])
% title('POz (original)')
% xlabel('Time(s)')
%
Cz_filt = x_e;

win_len = 1024;
[Cxy,F] = mscohere(POz,Cz,win_len,round(0.7*win_len),fft_len,fs);
subplot(1,3,1)
plot(F,Cxy)
title('Normal Coherence')
xlabel('Frequency(Hz)')
ylabel('$C_{xy}$(f)')
    set(gca,'YGrid', 'on')
        set(gca,'XGrid', 'on')

subplot(1,3,2)
[Cxy,F] = mscohere(Poz_filt,Cz_filt,win_len,round(0.7*win_len),fft_len,fs);
plot(F,Cxy)
title('Noise removed  - amplitude ajusted')
set(gca,'XGrid', 'on')
xlabel('Frequency(Hz)')
ylabel('$C_{xy}$(f)')
set(gca,'YGrid', 'on')


subplot(1,3,3)
n_gen = 3*sin(2*pi*(1:N)*f0/fs)+1.5*randn(1,N);
%ANC for Cz
mu = 0.01;
M = 10;
n_est = zeros(1,N);
x_e = zeros(1,N);
w_e = zeros(M,N);

for n = M+1:N
    u = n_gen(n-1:-1:n-M)';
    n_est(n) = w_e(:,n)'*u;
    x_e(n) = Cz(n) - n_est(n);
    w_e(:,n+1) = w_e(:,n) + mu*x_e(n)*u;
end
%
% subplot(1,2,1)
% spectrogram(x_e, win_han, round(0.25*win_len), fft_len, fs, 'yaxis')
% axis([0 N/fs-1 0 200])
% title('POz with noise removed')
% xlabel('Time(s)')
% subplot(1,2,2)
% spectrogram(POz, win_han, round(0.25*win_len), fft_len, fs, 'yaxis')
% axis([0 N/fs-1 0 200])
% title('POz (original)')
% xlabel('Time(s)')
%
Cz_filt = x_e;
[Cxy,F] = mscohere(Poz_filt,Cz,win_len,round(0.7*win_len),fft_len,fs);
plot(F,Cxy)
title('Noise removed coherence')
set(gca,'XGrid', 'on')
xlabel('Frequency(Hz)')
ylabel('$C_{xy}$(f)')
set(gca,'YGrid', 'on')