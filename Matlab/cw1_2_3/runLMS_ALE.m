function [w_hist, e, x_est] = runLMS_ALE(s, mu, M, delta)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = length(s);
s = s(:)';
s = s';

x_est = zeros(1,N);
w_hist = zeros(M,N);
e = zeros(1,N);

for n = delta+M:N
    u = s(n-delta:-1:n-delta-M+1);
    x_est(n) = w_hist(:,n)'*u;
    e(n) = s(n) - x_est(n);
    w_hist(:,n+1) = w_hist(:,n) + mu*e(n)*u;
end

%w_hist = w_hist(:,((delta+M):end-1));
%x_est = x_est((delta+M):end);
%e = e(delta+M:end);



