clear all;
close all;
clc;

% 4.1b)
%Program parameters
N = 1000;
alpha = [1/sqrt(2), sqrt(3)/2, sqrt(85)/10];
gamma = [0, 1/(2*sqrt(3)), 0];
theta = [1/sqrt(2), 1/sqrt(6), sqrt(15)/10];
c = 1;
p = [0, 0.5 + 0.5*1i, 0.7];

%Initialise variables
z = zeros(3,N);

%Generate complex valued white Gaussian noise by:

%i)Generating two independent WG signals
x1 = randn(1,N);
x2 = randn(1,N);

for k = 1:3
    x = alpha(k)*x1;
    y = gamma(k)*x1 + theta(k)*x2;
    z(k,:) = x + 1i*y;
    ti = sprintf('Circularity Plot, alpha = %.3f, gamma = %.3f, theta = %.3f,  p = %.3f, c = %.3f', alpha(k), gamma(k), theta(k), p(k), 1);
    figure(1)
    subplot(1,3,k)
    scatter(real(z(k,:)), imag(z(k,:))), title(ti), ylabel('Imaginary part z'), xlabel('Real part z');
    axis([-2.5 2.5 -2.5 2.5]);
    
end

%%
%4.2c)
%Concactenate signal to form new signal that has non-stationary circularity
%values.
ord = 0;
u = 0.1;
h = [z(1,:), z(2,:), z(3,:)];

[w_hist, e, x_est] = runCLMS_MA(conj(z(1,:)), z(1,:), u, ord);

figure(2)
subplot(1,2,1)
plot(real(w_hist));
subplot(1,2,2)
plot(imag(w_hist));


%%
%4.2d)

ord = 1;
u = 0.0001;
%b = [1 1.5+1i];
b1 = 1.5+1i

f = zeros(1,N);
f(1) = z(1,1);
for j = 2:N
   f(j) = z(1,j) + b1*z(1,j-1); 
end

%f = filter(1,  b, z(1,:));

[w_hist, e, x_est] = runCLMS_MA(f, z(1,:), u, ord);
figure(3)
subplot(1,2,1)
plot(real(w_hist));
subplot(1,2,2)
plot(imag(w_hist));











