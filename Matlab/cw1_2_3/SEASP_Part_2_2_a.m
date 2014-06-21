%%
clc;
clear all;
close all;

f0 = 0.2;
N=256;
n = 1:N;

x = randn(1,N);
val = 50;
x = filter(ones(N/val,1)/(N/val),1,x);

% plot([x' y'])
%% Calc and plot xcorr
subplot(1,3,1)
acs_biased = xcorr(x,'biased');
acs_unbiased = xcorr(x,'unbiased');
lag = (1:length(acs_biased)) - length(acs_biased)/2;
a = [acs_unbiased' acs_biased'];
hold on
plot(lag,acs_unbiased)
plot(lag,acs_biased,'--','LineWidth',2,'Color',[0 0.5 0])
hold off
axis tight
xlabel('Lags')
tit = sprintf('ACS for filtered AWGN N=%s',num2str(N));
title(tit)
ylabel('amplitude')
legend('unbiased','biased')
%% calc acs estimates;
subplot(1,3,2)
%rearrange acs
acs_biased = fftshift(acs_biased);
acs_biased = acs_biased(end:-1:1);
acs_unbiased = fftshift(acs_unbiased);
acs_unbiased = acs_unbiased(end:-1:1);
%calc the PSDs
psd_biased = real(fft(acs_biased));
psd_biased = fftshift(psd_biased);
psd_unbiased = real(fft(acs_unbiased));
psd_unbiased = fftshift(psd_unbiased);
%plot'em
freq = (1:length(psd_biased))-length(psd_biased)/2;
freq = freq/length(freq);
hold on
plot(freq,psd_biased,'LineWidth',1.5,'Color',[0 0.5 0])
plot(freq,psd_unbiased,'Color',[0.0431 0.5176 0.7804])

hold off
ymin = min(min(psd_unbiased),min(psd_biased));
axis([0 .5 ymin max(psd_biased)])
ylabel('amplitude')
xlabel('Freq (Hz)')
legend('biased','unbiased')
tit = sprintf('PSD for filtered AWGN $\\sigma$ = 1 $\\mu$ = 0');
title(tit)
subplot(1,3,3)
plot(freq,10*log10([psd_unbiased' psd_biased']))
axis([0 .5 -40 10*log10(max(psd_biased))])
ylabel('amplitude(dB)')
xlabel('Freq (Hz)')
legend('unbiased','biased')
title('Log10(PSD)')

%%
clc
for i = 1:length(psd_biased)
    if (abs(psd_biased(i)) >= abs(psd_unbiased(i)))
        disp('___________________')
        disp(abs(psd_biased(i)))
        disp(abs(psd_unbiased(i)))
    end
end

mean(abs(psd_biased)./abs(psd_unbiased))