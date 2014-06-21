clc;
clear all;

x = 1:4;
M = length(x);
k=2;
T1 = [zeros(k,M-k) zeros(k);eye(M-k) zeros(k,M-k)'];
% T2 = [zeros(M,k) [eye(M-k);zeros(k,M-k)]];
T2 = [zeros(M,k) [zeros(k,M-k) ; eye(M-k)]];
x*T2*T1*x'
%%
k = 0;
T1 = zeros(M);
T2 = zeros(M);
T = zeros(M,M,M);
% T2 = [zeros(M,k) [zeros(k,M-k) ; eye(M-k)]];
for k=0:3
T1 = T1 + [zeros(k,M-k) zeros(k);eye(M-k) zeros(k,M-k)'];
T2 = T2 +[zeros(M,k) [zeros(k,M-k) ; eye(M-k)]];
[zeros(M,k) [zeros(k,M-k) ; eye(M-k)]]*[zeros(k,M-k) zeros(k);eye(M-k) zeros(k,M-k)']
end
%%
clc
clear all
M = 5
P = ones(M) + eye(M);
[a,b] = eig(P);
a
b