function out = fft_psd(data)
% 
data = data(:);
% acs = xcov(data,'biased');
% acs = fftshift(acs);
% acs = acs(end:-1:1);
% acs_fft = fft(acs);
% out = fftshift(real(acs_fft));
out = fftshift(abs(fft(data)).^2./(length(data)));