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
a2 = -0.81;
a = [1 -a1 -a2];
e = zeros(1,N);
w_e = zeros(N,2);
w_e_s = zeros(N,2);
g = zeros(N,2);
g_s = zeros(N,2);
P = zeros(2,2,N);
P_s = zeros(2,2,N);
lambda = 1;
trials = 100;
w_hist = zeros(N,2,trials);
e_hist = zeros(trials,N);
% w_e(:,1) = 0.1;
% w_e(:,2) = 0.8;
%% SWRLS
L = 25;
% L_a = [1,5,20,50,100,150,250,300,400];
% for j=9
%     L = L_a(j);
for k = 1:trials
w = sqrt(sigma)*randn(1,N);
x(1) = w(1);
x(2) = a1*x(1)+w(2);
for i=3:(N)
    if i <= 200
        a1 = 1.2728;
    end
    if i <= 100
        a1 = 0;
    end
    if i <= 50
        a1 = 1.2728;
    end
    x(i) = a1*x(i-1)+a2*x(i-2)+w(i);
end
P_init = 0.25;
P(1,1,:) = P_init;
P(2,2,:) = P_init;
P_s(1,1,:) = P_init;
P_s(2,2,:) = P_init;
e(1) = x(1);
e(2) = x(2);

for i = 3:L+3
    x_c = [x(i-1) x(i-2)]';
    e(i) = x(i) - w_e(i,:)*x_c;
    g(i,:) = P(:,:,i-1)*x_c* (lambda + x_c'*P(:,:,i-1)*x_c)^(-1);
    P(:,:,i) = lambda^(-1)*(P(:,:,i-1) - g(i,:)'*x_c'*P(:,:,i-1));
    w_e(i+1,:) = w_e(i,:) + g(i,:)*e(i);
end
for i = L+4:N
    x_c_s = [x(i-L-2) x(i-L-3)]';
    d = x(i-L-1);
    x_c = [x(i-1) x(i-2)]';
    %calc g
    g(i+1,:) = P(:,:,i-1)*x_c* (lambda + x_c'*P(:,:,i-1)*x_c)^(-1);
    %calc squiggle w
    w_e_s(i,:) = w_e(i-1,:) + g(i,:)*(x(i)-w_e(i-1,:)*x_c);
    %squiggle P
    P_s(:,:,i) = P(:,:,i-1) - g(i,:)'*x_c'*P(:,:,i-1);
    %calc squiggle g
    g_s(i+1,:) = P_s(:,:,i)*x_c_s*(1+x_c_s'*P_s(:,:,i)*x_c_s)^(-1); 
    %calc w_e
    w_e(i,:) = w_e_s(i,:) - g_s(i,:)*(d - w_e_s(i,:)*x_c_s);
    %calc normal p
    P(:,:,i) = P_s(:,:,i)/lambda + g_s(i,:)'*x_c_s'*P_s(:,:,i);
    e(i) = x(i) - w_e(i,:)*x_c;
end
    if (abs(mean(w_e(:,1))) <= 2 && abs(mean(w_e(:,2)) <= 2))
        w_hist(:,:,k) = w_e;
        e_hist(k,:) = e;
    else
        fprintf('Overflow at k=%d for L=%d\n',k,L)
        w_hist(:,:,k) = w_hist(:,:,k-1);
        e_hist(k,:) = e_hist(k-1,:);
    end
end
w_e = mean(w_hist,3);
file = sprintf('part3_2_e_L%d_l%s.mat',L,num2str(lambda))
save(file,'w_hist','e_hist')

hold on
plot(w_e,'r')


%% RLS
lambda = 1;
for k = 1:trials
w = sqrt(sigma)*randn(1,N);
x(1) = w(1);
x(2) = a1*x(1)+w(2);
for i=3:(N)
    if i <= 200
        a1 = 1.2728;
    end
    if i <= 100
        a1 = 0;
    end
    if i <= 50
        a1 = 1.2728;
    end
    x(i) = a1*x(i-1)+a2*x(i-2)+w(i);
end
P(:,:,1) = eye(2);
P(:,:,2) = eye(2);
P(:,:,3) = eye(2);
e(1) = x(1);
e(2) = x(2);
for i = 3:N-1
    x_c = [x(i-1) x(i-2)]';
    e(i) = x(i) - w_e(i,:)*x_c;
    g(i,:) = P(:,:,i-1)*x_c* (lambda + x_c'*P(:,:,i-1)*x_c)^(-1);
    P(:,:,i) = lambda^(-1)*(P(:,:,i-1) - g(i,:)'*x_c'*P(:,:,i-1));
    w_e(i+1,:) = w_e(i,:) + g(i,:)*e(i);
%     x_c = [x(i) x(i-1)]';
%     e(i) = x(i) - w_e(i,:)*x_c;\
end
w_hist(:,:,k) = w_e;
e_hist(k,:) = e;
end
file = sprintf('part3_2_e_gw_rls.mat')
save(file,'w_hist','e_hist')
w_e = mean(w_hist,3);
plot(w_e,'g')
%% RLS
lambda = .99;
for k = 1:trials
w = sqrt(sigma)*randn(1,N);
x(1) = w(1);
x(2) = a1*x(1)+w(2);
for i=3:(N)
    if i <= 200
        a1 = 1.2728;
    end
    if i <= 100
        a1 = 0;
    end
    if i <= 50
        a1 = 1.2728;
    end
    x(i) = a1*x(i-1)+a2*x(i-2)+w(i);
end
P(:,:,1) = eye(2);
P(:,:,2) = eye(2);
P(:,:,3) = eye(2);
e(1) = x(1);
e(2) = x(2);
for i = 3:N-1
    x_c = [x(i-1) x(i-2)]';
    e(i) = x(i) - w_e(i,:)*x_c;
    g(i,:) = P(:,:,i-1)*x_c* (lambda + x_c'*P(:,:,i-1)*x_c)^(-1);
    P(:,:,i) = lambda^(-1)*(P(:,:,i-1) - g(i,:)'*x_c'*P(:,:,i-1));
    w_e(i+1,:) = w_e(i,:) + g(i,:)*e(i);
%     x_c = [x(i) x(i-1)]';
%     e(i) = x(i) - w_e(i,:)*x_c;\
end
w_hist(:,:,k) = w_e;
e_hist(k,:) = e;
end
file = sprintf('part3_2_e_rls_l%s.mat',num2str(lambda*100))
save(file,'w_hist','e_hist')
w_e = mean(w_hist,3);
plot(w_e,'b')
%% LMS Filter
mu = 0.1;
for k = 1:trials
    x = zeros(1,N);
w_e = 0.01*zeros(length(x),2);
w = sqrt(sigma)*randn(1,N);
x(1) = w(1);
x(2) = a1*x(1)+w(2);
for i=3:(N)
    if i <= 200
        a1 = 1.2728;
    end
    if i <= 100
        a1 = 0;
    end
    if i <= 50
        a1 = 1.2728;
    end
    x(i) = a1*x(i-1)+a2*x(i-2)+w(i);
end
for i=4:length(x)
    [w_e(i+1,:),x_e(i),e(i)] = lms_t1(x(i),w_e(i,:),[x(i-1) x(i-2)],mu);
end
w_hist(:,:,k) = w_e(1:N,:);
e_hist(k,:) = e(1:N);
end
file = sprintf('part3_2_e_lms_mu%s.mat',num2str(mu*100))
save(file,'w_hist','e_hist')
w_e = mean(w_hist,3);
plot(w_e,'k')
hold off
