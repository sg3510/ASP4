function [g,h,y_h,e] = ACLMS(y,d, mu, M)

N = length(y);
y_h = zeros(1,N);
e = zeros(1,N);
e(1) = d(1);
e(2) = d(2); 
h = zeros(M,N);
g = zeros(M,N);
for i = M+1:N-1      
    y_h(i) = ctranspose((h(:,i)))*flipud(y(i-M:i-1)')+ctranspose((g(:,i)))*conj(flipud(y(i-M:i-1)'));
%     y_h(i) = ctranspose((h(:,i)))*flipud(y(i-M+1:i)')+ctranspose((g(:,i)))*conj(flipud(y(i-M+1:i)'));
    e(i) = (d(i)) - y_h(i);
    h(:,i+1) = h(:,i)+ mu*conj(e(i))*(flipud(y(i-M:i-1)'));
    g(:,i+1) = g(:,i)+ mu*conj(e(i))*conj(flipud(y(i-M:i-1)'));
end
end