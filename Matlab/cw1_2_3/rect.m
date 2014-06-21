function [ x ] = rect(a,b,L)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
for i = 1:L
x(i) = round(heaviside(i-a) - heaviside(i-b));
end

end

