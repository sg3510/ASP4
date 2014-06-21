clear all;
clc;
N = 2000;
% f = len * frequency / (2*pi); %5
f=3;
frequency = f*2*pi/(N);

%%


%square wave:
data = zeros(N,1);
data(N/4:(3*N/4)) = 1;
data = data';
data = sin((1:N)*frequency);
% data = padarray(data',len,'post')';
% len = 2*len;

% 
% data = zeros(len,1);
% data = awgn(data,-10);
data = data - mean(data);
figure(4)
plot(data)
%%
a = figure(3);
clf(a);
% data = data - mean(data);
hold on
acs = xcov(data,'unbiased');
stem(acs)
hold off
psd_v = zeros(N,1);
for omega = 0:(N-1)
    psd_v1(omega+1) = abs(cust_psd(data, 2*pi*omega/N));
    psd_v2(omega+1) = abs(cust_psd2(data, 2*pi*omega/N));
end

x = (0:(N-1))*(2*pi);

psd_v1 = abs(fft(acs,N));

max(psd_v1)/max(psd_v2)
% plot([abs(psd_v1)'  abs(psd_v2)'])
figure(1)
stem(fftshift(abs(psd_v1)))
figure(2)
stem(fftshift(abs(psd_v2)))