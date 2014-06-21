%Use like this
%[w_e(i+1,:),x_e(i),e(i)] = lms_t1(x(i),w_e(i,:),[x(i-1) x(i-2)],mu);

function [wp1,x_e,e] = lms_t1(x_c,w,x,mu)
    w = w(:)';
    x = x(:)';
    x_e = w*x';
    e = x_c - x_e';
    wp1 = w + mu*e*x;
end

