%%
clc;
% clear all;
close all
% clear all
clearvars -except fs POz Cz

if exist('Cz','var') == 0
load EEG_Data_Assignment2.mat
disp('loaded')
end

N = length(Cz);
Cz_bak = Cz;
POz_bak = POz;

%% Normal calc
Cxy = mscohere(Cz,POz);

freq = 0:(length(Cxy)-1);
freq = .5*fs*(freq/length(freq));
i1 = max(find(freq <= 10));
i2 = max(find(freq <= 20));
plot(freq(i1:i2),Cxy(i1:i2))
axis([10 20 0 1])
line([13 13],[0 1],'Color','r')
text(13.5,.8,'13Hz')
title('Untouched Coherence Spectrum Estimates')
ylabel('$C_{xy}(\omega)$')
xlabel('Freq (Hz)')
%% Lets reduce variance
clc
Slice = 100;
s = 5;
% cxy_av = zeros(N/(fs*s),);
% for i=1:(N/(fs*s))
%     data_1 = POz((i-1)*s*fs + 1:(i*s*fs));
%     data_2 = Cz((i-1)*s*fs + 1:(i*s*fs));
% %     nextpow2(s)
% %     length(mscohere(data_1,data_2))
% %     cxy_av(i,:) = mscohere(data_1,data_2);
% end
% Cxy = mean(cxy_av);
figure(1)
subplot(1,2,1);
Cxy = mscohere(POz,Cz,hamming(N/Slice));
freq = 0:(length(Cxy)-1);
freq = .5*fs*(freq/length(freq));
index = find(freq == 200);
plot(freq(1:index),Cxy(1:index))

axis([0 200 0 1])
title('100 Averaged Coherence Spectrum Estimates')
ylabel('$C_{xy}(\omega)$')
xlabel('Freq (Hz)')
line([13 13],[0 1],'Color','g')
text(13.5,.8,'13Hz')
line([52 52],[0 1],'Color','r')


subplot(1,2,2);
s = 4;
Wo = 50/(fs/2); BW = Wo/5;
[b,a] = iirnotch(Wo,BW);
Cz_filt = filter(b,a,Cz);
POz_filt = filter(b,a,POz);

c = @colors;

Cxy = mscohere(POz_filt,Cz_filt,N/Slice);
freq = 0:(length(Cxy)-1);
freq = .5*fs*(freq/length(freq));
index = find(freq == 200);
plot(freq(1:index),Cxy(1:index))
axis tight
title('100 Averaged $C_{xy}(\omega)$ with 50Hz removed')
xlabel('Freq (Hz)')
line([13 13],[0 1],'Color','g')
text(13.5,.8,'13Hz')
line([26 26],[0 1],'Color',c('apple green'))
text(27.5,.8,'26Hz')
line([52 52],[0 1],'Color','r')
axis([0 200 0 1])


%% PSD
s=20;
overlap = 4;
st = 1;
en = 1;
x_end = 120;
Cz = Cz_bak(st*1:en*end);
POz = POz_bak(st*1:en*end);
figure(2)
subplot(1,2,1);
psd_dat = pwelch(POz,s*fs,s*fs/overlap);
freq = 0:(length(psd_dat)-1);
freq = .5*fs*freq/(length(freq)-1);
i1 = max(find(freq <= 10));
i2 = max(find(freq <= x_end));
plot(freq(i1:i2),10*log10(psd_dat(i1:i2)));
axis([10 x_end  -110 -85])
title('POz data')
xlabel('Freq (Hz)')
ylabel('Amplitude (dB)')
set(gca,'xtick',10:5:x_end)
set(gca,'ytick',-110:5:-85)
set(gca,'XGrid', 'on')
set(gca,'YGrid', 'on')
subplot(1,2,2);
psd_dat = pwelch(Cz,s*fs,s*fs/overlap);
freq = 0:(length(psd_dat)-1);
freq = .5*fs*freq/(length(freq)-1);
plot(freq(i1:i2),10*log10(psd_dat(i1:i2)));
axis([10 x_end  -110 -85])
title('Cz data')
xlabel('Freq (Hz)')
set(gca,'xtick',10:5:x_end)
set(gca,'ytick',-110:5:-85)
set(gca,'XGrid', 'on')
set(gca,'YGrid', 'on')
grid on