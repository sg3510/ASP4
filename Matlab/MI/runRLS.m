function [w_hist, e, x_est] = runRLS(x, lambda, ord)
%Performs Growing window RLS on input vector x, lambda is the forgetting
%factor while ord is the assumed model order. Returns a history of the
%coefficient convergence in w_hist, the error at each sample, and 
    %Get the length of the input signal
    N = length(x);
    
    %Initialise RLS variables
    P = zeros(ord, ord, N);
    e = zeros(1,N);
    g = zeros(N,ord);
    w_hist = zeros(N,ord);
    x_est = zeros(1,N);
    
    %Initialise RLS variables up to the order index, need this as minimum
    %before can start computing estimates
    for j=1:ord
    P(:,:,j) = eye(ord);
    e(j) = x(j);
    end
    
    %Begin loop working through each element of input vector
    for j = ord+1:N-1
        x_prev = x(j-1:-1:j-ord);
        x_est(j)= w_hist(j,:)*x_prev;  
        e(j) = x(j) -  x_est(j);
        g(j,:) = (P(:,:,j-1)*x_prev)./(lambda + x_prev'*P(:,:,j-1)*x_prev);
        P(:,:,j) = (lambda^(-1))*(P(:,:,j-1) - g(j,:)'*x_prev'*P(:,:,j-1));
        w_hist(j+1,:) = w_hist(j,:) + g(j,:)*e(j);    
    end


end



