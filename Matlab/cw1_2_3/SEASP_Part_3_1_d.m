clear all
% close all
clc

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')

discard = 500;

N = 500;
sigma = .25;
a1 = 0.1;
a2 = 0.8;
a = [1 -a1 -a2];
mu = 0.01;
error = zeros(100,N);
w_history = zeros(N,2,100);
str = 'Sign Sign';
%% LMS Filter

for k = 1:100
    %setup
    w = sqrt(sigma)*randn(1,N+discard);
    x = filter(1,a,w)';
    x = x(discard+1:end);
    w_e = zeros(length(x),2);
    %init error vector
    e = zeros(1,N);
    e(1) = x(1);
    [w_e(2+1,:),x_e,e(2)] = lms_t2(x(2),w_e(2,:),[x(2-1) 0],mu);
    for i=3:length(x)-1
        [w_e(i+1,:),x_e,e(i)] = lms_t2(x(i),w_e(i,:),[x(i-1) x(i-2)],mu);
    end    
    
    error(k,:) = e;
    w_history(:,:,k) = w_e;
end

w_e_std = std(w_history,[],3);
subplot(1,4,1)
w_e = mean(w_history,3);
plot(w_e)

tit = sprintf('$\\mu$ = %s',num2str(mu));
title(tit)
xlabel('N')
ylabel('$\mathbf{w}$ values')
set(gca,'ytick',0:.1:.8)
set(gca,'YGrid', 'on')
legend('w[1]','w[2]')
subplot(1,4,2)
plot(10*log10(mean(error.^2)))
tit = sprintf('$\\mathbf{w}[end]=[\\mathcal{N}(%1.3f , %1.3f)$ $\\mathcal{N}(%1.3f , %1.3f)]$',w_e(end,1),w_e_std(end,1),w_e(end,2),w_e_std(end,2));
title(tit)
xlabel('N')
ylabel('Error (dB)')
e = mean((error.^2));
% plot(10*log10(e))
% sprintf('MSE=%1.4f\n',mean(e(end-100:end)))
% sprintf('EMSE=%1.4f\n',mean(e(end-100:end)) - sigma)
% str = sprintf('MSE=%1.5f\nEMSE=%1.5f\n$\\mathcal{M}$=%1.5f',mean(e(end-100:end)),mean(e(end-100:end)) - sigma,(mean(e(end-100:end)) - sigma)/sigma)
% annotation('textbox',[.35 .75 .1 .1],'String', str);
fprintf('%1.5f & %1.5f & %1.5f\n',mean(e(end-100:end)),mean(e(end-100:end)) - sigma,(mean(e(end-100:end)) - sigma)/sigma)

%% redo
mu = 0.05;
for k = 1:100
    %setup
    w = sqrt(sigma)*randn(1,N+discard);
    x = filter(1,a,w)';
    x = x(discard+1:end);
    w_e = zeros(length(x),2);
    %init error vector
    e = zeros(1,N);
    e(1) = x(1);
    [w_e(2+1,:),x_e,e(2)] = lms_t2(x(2),w_e(2,:),[x(2-1) 0],mu);
    for i=3:length(x)-1
        [w_e(i+1,:),x_e,e(i)] = lms_t2(x(i),w_e(i,:),[x(i-1) x(i-2)],mu);
    end  
    error(k,:) = e;
    w_history(:,:,k) = w_e;
end
subplot(1,4,3)
w_e = mean(w_history,3);
w_e_std = std(w_history,[],3);
plot(w_e)
w_e = mean(w_history,3);
tit = sprintf('$\\mu$ = %s',num2str(mu));
title(tit)
legend('w[1]','w[2]')
xlabel('N')
ylabel('$\mathbf{w}$ values')
% set(gca,'ytick',0:.1:.8)
set(gca,'YGrid', 'on')
subplot(1,4,4)
plot(10*log10(mean(error.^2)))
tit = sprintf('$\\mathbf{w}[end]=[\\mathcal{N}(%1.3f , %1.3f)$ $\\mathcal{N}(%1.3f , %1.3f)]$',w_e(end,1),w_e_std(end,1),w_e(end,2),w_e_std(end,2));
title(tit)
xlabel('N')
ylabel('Error (dB)')
e = mean((error.^2));
% str = sprintf('MSE=%1.5f\nEMSE=%1.5f\n$\\mathcal{M}$=%1.5f',mean(e(end-100:end)),mean(e(end-100:end)) - sigma,(mean(e(end-100:end)) - sigma)/sigma)
% annotation('textbox',[.80 .75 .1 .1],'String', str);
% suptitle(str);
fprintf('%1.5f & %1.5f & %1.5f',mean(e(end-100:end)),mean(e(end-100:end)) - sigma,(mean(e(end-100:end)) - sigma)/sigma)

