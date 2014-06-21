function [w_e,e] = full_rls(x,lambda,alpha,M)
N = length(x);
e = zeros(1,N);
w_e = zeros(N,M);
g = zeros(N,M);
P = zeros(M,M,N);
 %% RLS
x = x(:)';
for i=1:M
P(i,i,:) = alpha;
end
for i = M+1:N
    x_c =x((i-1):-1:(i-M))';
    e(i) = x(i) - w_e(i,:)*x_c;
    g(i,:) = P(:,:,i-1)*x_c* (lambda + x_c'*P(:,:,i-1)*x_c)^(-1);
    P(:,:,i) = lambda^(-1)*(P(:,:,i-1) - g(i,:)'*x_c'*P(:,:,i-1));
    w_e(i+1,:) = w_e(i,:) + g(i,:)*e(i);
end