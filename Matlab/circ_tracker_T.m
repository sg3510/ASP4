function [rho, e, h_est] = circ_tracker_T(h, u)
%Circularity coefficient tracking function that tracks the circularity
%coefficient of a complex signal using CLMS algorithm. The conjugate of the
%input signal h is the desired signal, h is the input signal, and rho is
%the circularity coefficient which is also the weight of the filter. 

%Initialisations
L = length(h);
h_est_conj = zeros(1, L);
rho = zeros(1, L);
e = zeros(1, L);

%LMS loop, circularity coefficient is the coefficient we are trying to
%optimize.
for n=1:L
   h_est_conj(n) = conj(rho(n))*h(n);
   e(n) = conj(h(n)) - h_est_conj(n);
   rho(n+1) = rho(n) + u*conj(e(n))*h(n);
end

h_est = conj(h_est_conj);

end