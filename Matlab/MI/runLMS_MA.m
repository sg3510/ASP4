function [w_hist, e, x_est] = runLMS_MA(d, x, mu, ord)
%LMS for MA processs
N = length(x);
x_est = zeros(N, 1);
w_hist = zeros(N, ord+1);
e = zeros(N,1);
x = x(:)';
x = x';
d = d(:)';
d = d';

% This is a block filtering process so must wait for the first order number of  inputs to
% become available before providing an output
for k=ord+1:N-1    
    % Load next block of data to be multiplied by the coefficients
    x_prev = x(k:-1:k-ord);
    %Calculate estimate
    x_est(k)= w_hist(k,:)*x_prev;
    % calculate the error
    e(k) = d(k) - x_est(k);
    %Update coefficient accordingly
    w_hist(k+1,:) =  w_hist(k,:) + mu*e(k)*x_prev';
end



