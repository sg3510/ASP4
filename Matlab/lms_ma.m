function [w_e, e, x_e] = lms_ma(d, x, mu, M)
x = x(:);
d = d(:);
N = length(x);
x_e = zeros(N, 1);
w_e = zeros(N, M);
e = zeros(N,1);
for i=M+1:N
    x_prev = x(i:-1:i-M+1);
    x_e(i)= w_e(i,:)*x_prev;
    e(i) = d(i) - x_e(i);
    w_e(i+1,:) =  w_e(i,:) + mu*e(i)*x_prev';
end