function [w_history,e] = lms_full_1(d, x, learning_rate, order)
%Perform least mean square estimator

% initialise the weights vector
w=zeros(order,1);
% Initialise the output vector
y=zeros(length(d)-order,1);
% Initialise the vector that will hold the evolution of coefficients with
% time
w_history = zeros(order, length(d)-order);
% Initialise vector that will hold output error

e = zeros(length(d)-1,1);

% This is a block filtering process so must wait for the first order number of inputs to
% become available before providing an output
for k=order:1:length(x)

% Load a block of data to be multiplied by the coefficients

x_k = x(k:-1:k-order+1);

y= w'*x_k;

% calculate the error in the output to see how the weights need to be
% adjusted
e(k-order+1)=d(k-order+1)-y;


w_history(:,k-order+1) = w;

% update the coefficient estimate by the relevant amount

w=w+learning_rate*(e(k-order+1))*((x_k));
end

end