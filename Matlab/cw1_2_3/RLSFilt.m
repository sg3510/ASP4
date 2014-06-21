% ------------------------------------------------------------------------­
% 2.161 Classroom Example - RLSFilt - Demonstration Recursive Least-Squares FIR filter 
% demonstration 
% Usage : 1) Initialization: 
% y = RLSFilt(’initial’, lambda, M, delta) 
% where Lambda is the convergence rate parameter. 
% lambda is the "fprgetting" exponential weight factor 
% M is the filter length 
% delta are the initial diagonal R^{-1}(n) matrix elements. 
% Example: 
% [y, e] = adaptfir(’initial’, .95, 51, 0.01);
% Note: RLSFilt returnsy=0for initialization
% 2) Filtering: 
% [y, b] = RLSFilt(f, d}; 
% where f is a single input value, 
% d is the desired value, and 
% y is the computed output value, 
% b is the coefficient vector. 
% 
% Version: 1.0 
% Author: D. Rowell 12/9/07 
% ------------------------------------------------------------------------­
% 
function [y, Bout] = RLSFilt(f, d, FIR_M, delta_n ) 
% persistent F B lambda delta M Rinv 
% The following is initialization, and is executed once 
if (ischar(f) && strcmp(f,'initial')) 
lambda = d;

M = FIR_M;

delta = delta_n;

F = zeros(M,1);

Rinv = delta*eye(M);

B = zeros(M,1);

y=0; 

else 
% Filtering: 
for J = M:-1:2 
F(J) = F(J-1); 
end; 
F(1) = f; 
% Perform the convolution 
y= F'*B; 
error=d-y; 
% Kalman gains 
K = Rinv*F/(lambda + F’*Rinv*F); 
% Update Rinv 
Rinvn = (Rinv - K*F’*Rinv)/lambda; 
% Update the filter coefficients 
B = B + K*error; 
Bout=B; 
Rinv = Rinvn; 
end 
