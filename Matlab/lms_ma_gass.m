function [w_e, e, x_e, mu] = lms_ma_gass(d, x, type, M,p,alph)
x = x(:);
d = d(:);
N = length(x);
x_e = zeros(N, 1);
w_e = zeros(N, M);
e = zeros(N,1);
mu = zeros(N,1);
phi = zeros(N, M);
for i=M+1:N
    x_c = x(i:-1:i-M+1);
    x_prev = x(i-1:-1:i-M);
    x_e(i)= w_e(i,:)*x_c;
    e(i) = d(i) - x_e(i);
    w_e(i+1,:) =  w_e(i,:) + mu(i)*e(i)*x_c';
    if type ==1
        phi(i,:) = (eye(M) - mu(i-1)*(x_prev*x_prev'))*phi(i-1,:)'+e(i-1)*x_prev;
    elseif type == 2
        phi(i,:) = alph*phi(i-1,:)+e(i-1)*x_prev'; 
    elseif type == 3
        phi(i,:) = e(i-1)*x_prev'; 
    end
    mu(i+1) = mu(i) + p*e(i)*x_c'*phi(i,:)';
end