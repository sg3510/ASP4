function [w_hist, e, x_est, u] = runLMS_MA_GASS(d, x, ord, gass, p, alpha)
%Adaptive LMS where the learning rate is a function of time. Extra argument
%indicates which of the GASS algorithms to deploy:
%1 - Benveniste
%2 - Ang & Farhang
%3 - Matthews & Mie
N = length(x);
u = zeros(N, 1);
phi = zeros(ord+1,N);
x_est = zeros(N, 1);
w_hist = zeros(N, ord+1);
e = zeros(N,1);
x_prev = zeros(ord+1, N);
x = x(:)';
x = x';
d = d(:)';
d = d';
  

% This is a block filtering process so must wait for the first order number of  inputs to
% become available before providing an output
if gass ~= 1 || gass ~=2 || gass ~=3
    for k=ord+1:N-1    
        % Load next block of data to be multiplied by the coefficients
        x_prev(:,k) = x(k:-1:k-ord);
        %Calculate estimate
        x_est(k)= w_hist(k,:)*x_prev(:,k);
        % calculate the error
        e(k) = d(k) - x_est(k);
        %Update coefficient accordingly
         w_hist(k+1,:) =  w_hist(k,:) + u(k)*e(k)*x_prev(:,k)';
        %Benveniste
        if gass == 1
            phi(:,k) = (eye(ord+1) - u(k-1)*((x_prev(:,k-1))*(x_prev(:,k-1)')))*phi(:,k-1) + e(k-1)*x_prev(:,k-1);
            disp(phi(:,k));
            disp(eye(ord+1));
            disp(u(k-1));
            disp(x_prev(:,k-1))
            disp(x_prev(:,k-1)')
            disp((x_prev(:,k-1))*(x_prev(:,k-1)'));
            disp(e(k-1))
            clc
        %Ang & Farhang
        elseif gass == 2
            phi(:,k) = alpha*phi(:,k-1) + e(k-1)*x_prev(:,k-1);
        %3 - Matthews & Mie
        else
            phi(:,k) = e(k-1)*x_prev(:,k-1);   
        end
        u(k+1) = u(k) + p*e(k)*(x_prev(:,k)')*phi(:,k);
        
    end
else
    disp('Gass algorithm requested not recognized');            
end



