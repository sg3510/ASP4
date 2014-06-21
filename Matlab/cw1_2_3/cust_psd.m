function psd_v = cust_psd(data, omega)
data = data(:)';
len1 = length(data);

%make acs
acs = xcov(data,'biased');

exponential = ((1:(2*len1-1)) - len1);

exponential = exp(-omega*1i*exponential);

psd_v = sum(exponential.*acs);