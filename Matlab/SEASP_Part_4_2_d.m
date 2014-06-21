clc
clear all
close all

%% Gen all
N=1000;
%z1
alph = 1/sqrt(2);
gamma = 0;
theta = 1/sqrt(2);
p=alph^2-theta^2-gamma^2+1i*2*gamma*alph
c=alph^2+theta^2+gamma^2
x1 = randn(1,N);
x2 = randn(1,N);
x = alph*x1;
y = gamma*x1+theta*x2;
z = x+1i*y;
b = 1.5+1i;
d = zeros(1,N);
d(1) = z(1);
d(2:end) = b*z(1:end-1) + z(2:end);

[w_e, e, x_e] = clms(d, z, 0.01, 2);

[rho, z_h] = circ_estimate(z, 0.01);
subplot(1,2,1)
plot(real(w_e))
set(gca,'XGrid','on','YGrid','on');
axis tight
ylabel('$\mathcal{R}e(\mathbf{w})$')
xlabel('n')
subplot(1,2,2)
plot(imag(w_e))
set(gca,'XGrid','on','YGrid','on');
axis tight
ylabel('$\mathcal{I}m(\mathbf{w})$')
xlabel('n')

legend('$\mathbf{w}[0]$','$\mathbf{w}[1]$')