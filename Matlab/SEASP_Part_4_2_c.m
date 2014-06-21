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
x1 = randn(1,N);
x2 = randn(1,N);
x = alph*x1;
y = gamma*x1+theta*x2;
z1 = x+1i*y;
%z2
alph = sqrt(3)/2;
gamma = 1/(2*sqrt(3));
theta = 1/(sqrt(6));
p=alph^2-theta^2-gamma^2+1i*2*gamma*alph
x1 = randn(1,N);
x2 = randn(1,N);
x = alph*x1;
y = gamma*x1+theta*x2;
z2 = x+1i*y;
%z3
alph = sqrt(17)/(2*sqrt(5));
gamma = 0;
theta = sqrt(3)/(2*sqrt(5));
p=alph^2-theta^2-gamma^2+1i*2*gamma*alph
x1 = randn(1,N);
x2 = randn(1,N);
x = alph*x1;
y = gamma*x1+theta*x2;
z3 = x+1i*y;
%z
z = [z1 z2 z3];

[w_e, e, x_e] = clms(conj(z), z, 0.01, 2);
[rho, z_h] = circ_estimate(z, 0.01);
subplot(1,2,1)
a = zeros(1,3*N);
a(1000:2000) = 0.5;
a(2000:3000) = 0.7;
hold on
plot(real(rho))
plot(a,'k--','LineWidth',1.5)
hold off
axis tight
set(gca,'XGrid','on','YGrid','on');
ylabel('$\mathcal{R}e(\rho)$')
xlabel('N')
subplot(1,2,2)
a = zeros(1,3*N);
a(1000:2000) = 0.5;
hold on
plot(imag(rho))
plot(a,'k--','LineWidth',1.5)
hold off
axis tight
legend('Estimate','True value')
set(gca,'XGrid','on','YGrid','on');
ylabel('$\mathcal{I}m(\rho)$')
xlabel('N')