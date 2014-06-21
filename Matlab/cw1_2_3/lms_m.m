function [w_history,e]= lms_m(d, mu, order)
% Least Mean Squares
% Call:
% [e,wn]= lms(mu, M, d)
%
% Input arguments:
% d = Teaching signal
% mu = learning rate
% order = Order of the adaptive filter
%
% Output arguments:
% e = Estimation error
% wn = Evolution of filter coefficients
%
% Initalisations

w = zeros(1,order);
N = length(d);
w_history = zeros(N,order);
e = zeros(N,1);
x = zeros(order,1);
d=d(:);
% tic % This is to test the effect of implementing the sign sign and signed regressor algorithms. 
e(1) = d(1) - w * x;

for n=order:N
    e(n) = d(n) - w * x;
    w = w + mu * x' * e(n);
    w_history(n,:)= w;
    x = [d(n) ; x(1)];
end

