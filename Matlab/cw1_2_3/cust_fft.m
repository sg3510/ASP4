function fft_out = cust_fft(x)
% clc
% clear all
% x = sin(2*pi*((1:64)-1)/32);
% plot(x)
x = x(:)';
N = length(x);
expo = 1/N;

part1 = 1:(N);
part1 = part1 - 1;
part2 = 1:N;
part2 = part2 - 1;
expo = 2*pi*1i*expo.*(part1'*part2);
expo = exp(-expo);
x = x'*ones(1,N);

fft_out = sum(expo.*x);