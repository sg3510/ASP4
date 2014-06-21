function [rho, z_h] = circ_estimate(z, mu)
z = z(:);
N = length(z);
e = zeros(1,N);
z_h = zeros(1,N);
rho = zeros(1,N);

for i=1:N
    z_h(i) = conj(rho(i))*z(i);
    e(i) = conj(z(i))-z_h(i);
    rho(i+1) = rho(i)+mu*conj(e(i))*z(i);
end
