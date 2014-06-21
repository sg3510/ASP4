clc
clear all
close all

%% Gen all
N=1000;
mu = 0.01;
M=2;
trials = 100;
n=1:5:N;
%vars
w_e = zeros(N,M,trials);
e_c = zeros(N,trials);
x_e = zeros(N,trials);
g = zeros(M,N,trials);
h = zeros(M,N,trials);
e_a = zeros(N,trials);
%Gen noise
alph = 1/sqrt(2);
gamma = 0;
theta = 1/sqrt(2);
p=alph^2-theta^2-gamma^2+1i*2*gamma*alph
c=alph^2+theta^2+gamma^2
p1 = p
c1 = c
%100 trials
for k = 1:trials
    x1 = randn(1,N);
    x2 = randn(1,N);
    x = alph*x1;
    y = gamma*x1+theta*x2;
    x = x+1i*y;
    %WLMA
    b1 = 1.5+1j;
    b2 = 2.5-0.5j;
    y = zeros(1,N);
    y(1) = x(1);
    for i=2:N
        y(i) = x(i)+b1*x(i-1)+b2*conj(x(i-1));
    end
    [w_e(:,:,k), e_c(:,k), x_e(:,k)] = clms(y, x, mu, M);
    [g(:,:,k),h(:,:,k),~,e_a(:,k)] = ACLMS(x,y, mu, M);
end
w_e = mean(w_e,3);
g = mean(g,3)';
h = mean(h,3)';
e_c = mean((e_c.^2),2);
e_a = mean((e_a.^2),2);
%% plot
figure(1)
subplot(1,3,1)
hold on
w_e = downsample(w_e,5);
plot(n,real(w_e),'b')
plot(n,imag(w_e),'g')
xlabel('n')
ylabel('$\mathbf{w}$')
title('CLMS coefficients convegence - Circular')
hold off
subplot(1,3,2)
g = downsample(g,5);
hold on
plot(n,real(g),'b')
plot(n,imag(g),'g')
hold off
xlabel('n')
ylabel('$\mathbf{g}$')
title('ACLMS coefficients convegence')
subplot(1,3,3)
h = downsample(h,5);
hold on
plot(n,real(h),'b')
plot(n,imag(h),'g')
hold off
xlabel('n')
ylabel('$\mathbf{h}$')
title('ACLMS coefficients convegence')
ec_c = e_c;
ea_c = e_a;
%% p=0.5
%vars
w_e = zeros(N,M,trials);
e_c = zeros(N,trials);
x_e = zeros(N,trials);
g = zeros(M,N,trials);
h = zeros(M,N,trials);
e_a = zeros(N,trials);
%Gen noise
alph = sqrt(3)/2;
gamma = 0;
theta = 1/2;
p=alph^2-theta^2-gamma^2+1i*2*gamma*alph
c=alph^2+theta^2+gamma^2

%100 trials
for k = 1:trials
    x1 = randn(1,N);
    x2 = randn(1,N);
    x = alph*x1;
    y = gamma*x1+theta*x2;
    x = x+1i*y;
    %WLMA
    b1 = 1.5+1j;
    b2 = 2.5-0.5j;
    y = zeros(1,N);
    y(1) = x(1);
    for i=2:N
        y(i) = x(i)+b1*x(i-1)+b2*conj(x(i-1));
    end
    [w_e(:,:,k), e_c(:,k), x_e(:,k)] = clms(y, x, mu, M);
    [g(:,:,k),h(:,:,k),~,e_a(:,k)] = ACLMS(x,y, mu, M);
end
w_e = mean(w_e,3);
g = mean(g,3)';
h = mean(h,3)';
e_c = mean((e_c.^2),2);
e_a = mean((e_a.^2),2);
%% plot
figure(2)
subplot(1,3,1)
hold on
w_e = downsample(w_e,5);
plot(n,real(w_e),'b')
plot(n,imag(w_e),'g')
xlabel('n')
ylabel('$\mathbf{w}$')
title('CLMS coefficients convegence - Non-Circular')
hold off
subplot(1,3,2)
g = downsample(g,5);
hold on
plot(n,real(g),'b')
plot(n,imag(g),'g')
hold off
xlabel('n')
ylabel('$\mathbf{g}$')
title('ACLMS coefficients convegence')
subplot(1,3,3)
h = downsample(h,5);
hold on
plot(n,real(h),'b')
plot(n,imag(h),'g')
hold off
xlabel('n')
ylabel('$\mathbf{h}$')
title('ACLMS coefficients convegence')
figure(3)
subplot(1,2,1)
hold on
plot(10*log10(abs(ec_c)),'b')
plot(10*log10(abs(ea_c)),'g')
set(gca,'XGrid','on','YGrid','on');
ylabel('Error(dB)')
xlabel('n')
title(sprintf('Error curve for CLMS vs ACLMS - Circular p=%1.1f c=%1.1f',p1,c1))
hold off 
subplot(1,2,2)
hold on
plot(10*log10(abs(e_c)),'b')
plot(10*log10(abs(e_a)),'g')
set(gca,'XGrid','on','YGrid','on');
ylabel('Error(dB)')
xlabel('n')
title(sprintf('Error curve for CLMS vs ACLMS - Non-Circular p=%1.1f c=%1.1f',p,c))
hold off 