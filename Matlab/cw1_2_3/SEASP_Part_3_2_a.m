clear all
close all
clc

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')

discard = 500;

N = 500;
sigma = .25;
a1 = 0.1;
a2 = 0.8;
a = [1 -a1 -a2];
e = zeros(1,N);
w_e = zeros(N,2);
g = zeros(N,2);
P = zeros(2,2,N);

lambda = 1;
 %% RLS
 
w = sigma*randn(1,N+discard);
x = filter(1,a,w)';
x = x(discard+1:end);
P(:,:,1) = eye(2);
P(:,:,2) = eye(2);
P(:,:,3) = eye(2);
for i = 3:N-1
    x_c = [x(i-1) x(i-2)]';
    e(i) = x(i) - w_e(i,:)*x_c;
    g(i,:) = P(:,:,i-1)*x_c* (lambda + x_c'*P(:,:,i-1)*x_c)^(-1);
    P(:,:,i) = lambda^(-1)*(P(:,:,i-1) - g(i,:)'*x_c'*P(:,:,i-1));
    w_e(i+1,:) = w_e(i,:) + g(i,:)*e(i);
end
hold on
plot(w_e,'LineWidth',1.5)

%% LMS #alloveragain

mu = 0.01;
%setup
w = sigma*randn(1,N+discard);
x = filter(1,a,w)';
x = x(discard+1:end);
w_e = zeros(length(x),2);
%init error vector
e = zeros(1,N);
e(1) = x(1);
[w_e(2+1,:),x_e,e(2)] = lms_t1(x(2),w_e(2,:),[x(2-1) 0],mu);
for i=3:length(x)-1
    [w_e(i+1,:),x_e,e(i)] = lms_t1(x(i),w_e(i,:),[x(i-1) x(i-2)],mu);
end  
plot(w_e,'r:')

mu = 0.05;
%setup
w = sigma*randn(1,N+discard);
x = filter(1,a,w)';
x = x(discard+1:end);
w_e = zeros(length(x),2);
%init error vector
e = zeros(1,N);
e(1) = x(1);
[w_e(2+1,:),x_e,e(2)] = lms_t1(x(2),w_e(2,:),[x(2-1) 0],mu);
for i=3:length(x)-1
    [w_e(i+1,:),x_e,e(i)] = lms_t1(x(i),w_e(i,:),[x(i-1) x(i-2)],mu);
end  
plot(w_e,'k--')


hold off

set(gca,'ytick',0:.1:.9)
set(gca,'YGrid', 'on')
xlabel('N')
ylabel('$\mathbf{w}$')
legend('$\mathbf{w}[1]$ RLS','$\mathbf{w}[2]$ RLS','$\mathbf{w}$ LMS $\mu=0.01$','$\mathbf{w}$ LMS $\mu=0.05$-del','$\mathbf{w}$ LMS $\mu=0.01$-del','$\mathbf{w}$ LMS $\mu=0.05$')