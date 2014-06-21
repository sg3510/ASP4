function psd_v = cust_psd2(data, omega)

len2 = length(data);

%make it zero mean


exponential = 0:(len2-1);

exponential = exp(-1i*omega*exponential);

psd_v = (1/len2)*sum(exponential.*data)^2;

% psd_v = sum(exponential.*data);