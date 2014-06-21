function psd_out = full_psd(x)
x = x(:);
len = length(x);
psd_out = zeros(len,1);
for omega = 0:(len-1)
    psd_out(omega+1) = cust_psd(x, 2*pi*omega/len);
end