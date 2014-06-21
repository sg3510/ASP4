function [w_hist, x_est] = runLMS_ANC(s, eps, mu, M)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = length(s);
s = s(:)';
s = s';

n_est = zeros(1,N);
x_est = zeros(1,N);
w_hist = zeros(M,N);

for n = M:N
    u = eps(n:-1:n-M+1);
    n_est(n) = w_hist(:,n)'*u;
    x_est(n) = s(n) - n_est(n);
    w_hist(:,n+1) = w_hist(:,n) + mu*x_est(n)*u;
end

