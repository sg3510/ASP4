function [w_e, e, x_e] = clms(d, x, mu, M)
x = x(:);
d = d(:);
N    =   length(d);
e    =   zeros(N   ,1);
x_e  =   zeros(N   ,1);
w_e  =   zeros(M ,(N+1));
% size(x)
% % size(zeros(M,1))
shift_x  =   [zeros(M-1,1) ; (x)];

for i = 1:N,
    x_c          =   shift_x(i+(M-1):-1:i);
    x_e(i)     =   (w_e(:,i)')*x_c;
    e(i)       =   d(i)-x_e(i);
    w_e(:,i+1)   =   w_e(:,i) + (mu*conj(e(i))*x_c);
end
w_e = w_e';
w_e = w_e(1:N,:);