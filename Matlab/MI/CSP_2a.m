clear all;
close all;
clc; 

%Program parameters
N = 1000;
z = zeros(4, N);
r = zeros(4,N);
x = zeros(4,N);
%Imaginary and real parts of x with:

%Uncorrelated equal power
z(1,:) = randn(1,N);
r(1,:) = randn(1,N);
%Uncorrelated but different power
z(2,:) = 0.0001*randn(1,N);
r(2,:) = 10000*randn(1,N);
%Correlated same power
z(3,:) = randn(1,N);
r(3,:) = z(3,:);
%Correlated with different power
z(4,:) = randn(1,N);
r(4,:) = 100*z(4,:);
%Generate complex signal and plot complex signal

for k = 1:4
    x(k,:) = r(k,:).*exp(1i*z(k,:));
end    
    figure(1)
    subplot(2,2,1)
    scatter(real(x(1,:)), imag(x(1,:))), title('Uncorrelated with equal power'), ylabel('Imaginary part x'), xlabel('Real part x');
    axis tight;
    subplot(2,2,2)
    scatter(real(x(2,:)), imag(x(2,:))), title('Uncorrelated with different power'), ylabel('Imaginary part x'), xlabel('Real part x');
    axis tight;
    subplot(2,2,3)
    scatter(real(x(3,:)), imag(x(3,:))), title('Correlated with equal power'), ylabel('Imaginary part x'), xlabel('Real part x');
    axis tight;
    subplot(2,2,4)
    scatter(real(x(4,:)), imag(x(4,:))), title('Correlated with different power'), ylabel('Imaginary part x'), xlabel('Real part x');
    axis tight;
    






