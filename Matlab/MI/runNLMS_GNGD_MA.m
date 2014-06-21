function [w_hist, e, x_est, u2, eps] = runNLMS_GNGD_MA(d, x, mu, ord, p)
%Is the same function as other runLMS just with more convenient input
%arguments for a certain question
N = length(x);
x_est = zeros(N, 1);
w_hist = zeros(N, ord+1);
u2 = zeros(N, 1);
x_prev = zeros(ord+1, N);
eps = ones(N, 1);
e = zeros(N,1);
x = x(:)';
x = x';
d = d(:)';
d = d';

% This is a block filtering process so must wait for the first order number of  inputs to
% become available before providing an output
for k=ord+1:N-1    
    % Load next block of data to be multiplied by the coefficients
    x_prev(:,k) = x(k:-1:k-ord);
    %Calculate estimate
    x_est(k)= w_hist(k,:)*x_prev(:,k);
    % calculate the error
    e(k) = d(k) - x_est(k);
    
    %Adaptive step size step
    u2(k) = mu/(eps(k) + (x_prev(:,k)'*x_prev(:,k)));
    %Update coefficients accordingly
    w_hist(k+1,:) =  w_hist(k,:) + u2(k)*e(k)*x_prev(:,k)';
    
    %Adaptive regularisation term
    eps(k+1) = eps(k) - p*mu*((e(k)*e(k-1)*(x_prev(:,k)')*x_prev(:,k-1))/(eps(k-1) + (x_prev(:,k-1)')*x_prev(:,k-1))^2);
end