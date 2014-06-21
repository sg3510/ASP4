function out = r(k,M)
if abs(k) <= (M-1)
    out = (M-abs(k))/M;
else
    out = 0;
end