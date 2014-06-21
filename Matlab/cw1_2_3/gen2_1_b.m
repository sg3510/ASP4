function [varargout] = gen2_1_b(N,f0,sigm1,sigm2,alph)

n=1:N;

w1 = sigm1*randn(1,N);
w2 = sigm2*randn(1,N);

if nargout == 2
    x = sin(f0*2*pi*n) + w1;
    y = sin(f0*2*pi*n + alph) + w2;
    varargout{1} = x;
    varargout{2} = y;
elseif nargout == 4
    x = sin(f0*2*pi*n) + w1;
    y = sin(f0*2*pi*n + alph) + w2;
    snr_x = snr(x,w1);
    snr_y = snr(y,w2);
    varargout{1} = x;
    varargout{2} = y;
    varargout{3} = snr_x;
    varargout{4} = snr_y;
end