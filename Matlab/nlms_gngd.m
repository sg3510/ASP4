function [w_e, x_e, e, coef, epsi] = nlms_gngd(d, x, mu, M, p)
%init all params
N = length(x);
w_e = zeros(N, M);
coef = zeros(N, 1);
x_prev = zeros(M, N);
epsi = ones(N, 1);
x_e = zeros(N, 1);
e = zeros(N,1);
x = x(:);
d = d(:);
for i=M:N-1
    x_prev(:,i) = x(i:-1:i-M+1); %past vals
    x_e(i)= w_e(i,:)*x_prev(:,i); %estimate
    coef(i) = mu/(epsi(i) + (x_prev(:,i)'*x_prev(:,i))); %reupdate leading coef
    e(i) = d(i) - x_e(i); %error with d signal
    w_e(i+1,:) =  w_e(i,:) + coef(i)*e(i)*x_prev(:,i)'; %coefs update
    epsi(i+1) = epsi(i) - p*mu*((e(i)*e(i-1)*(x_prev(:,i)')*x_prev(:,i-1))/(epsi(i-1) + (x_prev(:,i-1)')*x_prev(:,i-1))^2); %cmain update
end