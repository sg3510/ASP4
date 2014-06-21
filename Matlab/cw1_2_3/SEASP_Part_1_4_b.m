clc
clearvars -except fs POz
close all

if exist('POz','var') == 0
load EEG_Data_Assignment1.mat
end
N=length(POz);
lim_N = 60;
%% Try 1
psd_dat = fftshift(fft_psd(POz));
freq = 0:(N-1);
freq = fs*freq/(length(freq)-1);
subplot(1,4,1)
plot(freq,10*log10(psd_dat));
axis([0 lim_N  -110 -65])
title('Normal PSD')
xlabel('Freq (Hz)')
ylabel('dB')
%mean + detrend removed
subplot(1,4,2)
data = POz;
data = detrend(data);
data = data - mean(data);
psd_dat = fftshift(fft_psd(data));
plot(freq,10*log10(psd_dat));
axis([0 lim_N  -110 -65])
title('No mean and Trend PSD')
xlabel('Freq (Hz)')
%welch
subplot(1,4,3)
s=10;
psd_dat = pwelch(POz,s*fs,s*fs/4);
freq = 0:(length(psd_dat)-1);
freq = .5*fs*freq/(length(freq)-1);
plot(freq,10*log10(psd_dat));
axis([0 lim_N  -110 -65])
tit = sprintf('Welch Method %ss window, %s\\%% overlap',num2str(s),num2str(100/4));
title(tit)
xlabel('Freq (Hz)')
%welch 2
subplot(1,4,4)
s=1;
psd_dat = pwelch(POz,s*fs,s*fs/4);
freq = 0:(length(psd_dat)-1);
freq = .5*fs*freq/(length(freq)-1);
plot(freq,10*log10(psd_dat));
axis([0 lim_N  -110 -65])
tit = sprintf('Welch Method %ss window, %s\\%% overlap',num2str(s),num2str(100/4));
title(tit)
xlabel('Freq (Hz)')
%% Bartlett Method

d_factor = 2;
%For 1 sec
subplot(1,4,1)
s = 1; %1 second
L = 12000;
freq = 0:(L-1);
freq = fs*freq/(length(freq)-1);

psd_av = zeros(N/(fs*s),L);
for i=1:(N/(fs*s))
    data = POz((i-1)*s*fs + 1:(i*s*fs));
    data = [data' zeros(1,L-s*fs)];
    psd_av(i,:) = fftshift(fft_psd(data));
end
a = mean(psd_av);
a = downsample(a,d_factor);
a = a(1:600);
freq = downsample(freq,d_factor);
freq = freq(1:600);
plot(freq,10*log10(a))
axis([0 lim_N  -115 -85])
xlabel('Freq (Hz)')
ylabel('dB')
tit = sprintf('Bartlett Method %ss window',num2str(s));
title(tit)


%For 2.5 sec
subplot(1,4,2)
s = 2.5; %1 second
psd_av = zeros(N/(fs*s),L);
for i=1:(N/(fs*s))
    data = POz((i-1)*s*fs + 1:(i*s*fs));
    data = [data' zeros(1,L-s*fs)];
    psd_av(i,:) = fftshift(fft_psd(data));
end
a = mean(psd_av);
a = downsample(a,d_factor);
a = a(1:600);
plot(freq,10*log10(a))
axis([0 lim_N  -110 -80])
xlabel('Freq (Hz)')
tit = sprintf('Bartlett Method %ss window',num2str(s));
title(tit)

%For 5 sec
subplot(1,4,3)
s = 5; %1 second
psd_av = zeros(N/(fs*s),L);
for i=1:(N/(fs*s))
    data = POz((i-1)*s*fs + 1:(i*s*fs));
    data = [data' zeros(1,L-s*fs)];
    psd_av(i,:) = fftshift(fft_psd(data));
end
a = mean(psd_av);
a = downsample(a,d_factor);
a = a(1:600);
plot(freq,10*log10(a))
axis([0 lim_N  -110 -75])
xlabel('Freq (Hz)')
tit = sprintf('Bartlett Method %ss window',num2str(s));
title(tit)



%For 5 sec
subplot(1,4,4)
s = 10; %1 second


psd_av = zeros(N/(fs*s),L);
for i=1:(N/(fs*s))
    data = POz((i-1)*s*fs + 1:(i*s*fs));
    data = [data' zeros(1,L-s*fs)];
    psd_av(i,:) = fftshift(fft_psd(data));
end
a = mean(psd_av);
a = downsample(a,d_factor);
a = a(1:600);
plot(freq,10*log10(a))
axis([0 lim_N  -110 -75])


xlabel('Freq (Hz)')
tit = sprintf('Bartlett Method %ss window',num2str(s));
title(tit)

%% windowing

d_factor = 3;
endbit = 4800/d_factor;
L = length(data);
freq = 0:(L-1);
freq = fs*freq/(length(freq)-1);


% Bartlett
subplot(1,3,1)
data = POz.*bartlett(L);
psd_dat = fftshift(fft_psd(data));
psd_dat = downsample(psd_dat,d_factor);
psd_dat = psd_dat(1:endbit);
freq = downsample(freq,d_factor);
freq = freq(1:endbit);
plot(freq,10*log10(psd_dat));
axis([0 lim_N  -120 -65])
xlabel('Freq (Hz)')
ylabel('dB')
title('Bartlett Window')


%Hanning
subplot(1,3,2)
data = POz.*hanning(L);
psd_dat = fftshift(fft_psd(data));
psd_dat = downsample(psd_dat,d_factor);
psd_dat = psd_dat(1:endbit);
plot(freq,10*log10(psd_dat));
axis([0 lim_N  -120 -65])
xlabel('Freq (Hz)')
title('Hanning Window')

% Full Spectrum
d_factor = 10;
endbit = 32000/d_factor;
freq = 0:(L-1);
freq = fs*freq/(length(freq)-1);


subplot(1,3, 3)
psd_dat = fftshift(fft_psd(data));
psd_dat = downsample(psd_dat,d_factor);
psd_dat = psd_dat(1:endbit);
freq = downsample(freq,d_factor);
freq = freq(1:endbit);
plot(freq,10*log10(psd_dat))
axis([0 400  -130 -65])
title('Periodogram over full spectrum')
xlabel('Freq (Hz)')