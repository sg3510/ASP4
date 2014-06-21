clear all
close all
clc

N = 50;
sigma = .25;
w = sigma*randn(1,N);

a1 = 0.1;
a2 = 0.8;

x = zeros(1,N);
x(1) = w(1);
x(2) = a1*x(1) + w(2);
for i = 3:N
    x(i) = a1*x(i-1) + a2*x(i-2) + w(i);
end


%% Stats stuff
for i=5:length(x)
c(i,1) = x(i)^2;
c(i,2) = x(i)*x(i-1);
c(i,3) = x(i)*x(i-2);
c(i,4) = x(i)*x(i-3);
c(i,4) = x(i)*x(i-4);
cor_m(i,:,:) = [x(i-1) x(i-2)]'*[x(i-1) x(i-2)];
end

c_m = mean(c);

c_m(2)/c_m(1)


%corr mat
d = mean(cor_m);
d = [d(:,:,1) ;d(:,:,2)]
format rat
r0 = (a2-1)*sigma/(a1^2*a2-a2^3+a1^2+a2^2+a2-1);

r1 = -a1*sigma/(a1^2*a2-a2^3+a1^2+a2^2+a2-1);

-(a1^2-a2^2+a2)*sigma/(a1^2*a2-a2^3+a1^2+a2^2+a2-1);

([[[1,-a1,-a2];[-a1,1-a2,0];[-a2,-a1,1]]]^-1)*([sigma,0,0]')
R = [[r0 r1];[r1 r0]];
format short
i=45;
for i=4:1:length(x)
w_opt(i,:) = R^-1 * (x(i)*[x(i-1) x(i-2)])';
end


%% LMS Filter
mu = 0.05;
w_e = 0.01*zeros(length(x)+1,2);
for i=4:length(x)
    [w_e(i+1,:),x_e(i),e(i)] = lms_t1(x(i),w_e(i,:),[x(i-1) x(i-2)],mu);
end