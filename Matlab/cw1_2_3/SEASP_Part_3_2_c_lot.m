close all
clc
clear all
load part3_2_c.mat

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')
%
n = 1:500;

n = downsample(n,5);
w_e1 = downsample(w_e1,5);
w_e2 = downsample(w_e2,5);
w_e3 = downsample(w_e3,5);
w_e4 = downsample(w_e4,5);
e1 = downsample(e1,5);
e2 = downsample(e2,5);
e3 = downsample(e3,5);
e4 = downsample(e4,5);
w_e1_std = downsample(w_e1_std,5);
w_e2_std = downsample(w_e2_std,5);
w_e3_std = downsample(w_e3_std,5);
w_e4_std = downsample(w_e4_std,5);
w_es1 = downsample(w_es1,5);
w_es2 = downsample(w_es2,5);
w_es3 = downsample(w_es3,5);
w_es4 = downsample(w_es4,5);
subplot(1,3,1)
plot(n,10*log10(([e1;e2;e3;e4]')))
set(gca,'YGrid', 'on')
xlabel('N')
ylabel('MSE (dB)')
title('MSE averaged for 2000 trials')
legend('$\lambda$ = 0.99','$\lambda$ = 0.95','$\lambda$ = 0.92','$\lambda$ = 0.90')


subplot(1,3,2)
hold on
plot(n,w_e1,'g')
plot(n,w_e2,'r')
plot(n,w_e3,'b')
plot(n,w_e4,'k')
hold off
set(gca,'ytick',0:.1:.9)
set(gca,'YGrid', 'on')
xlabel('N')
ylabel('Coefficients')
title('Averaged $\mathbf{w}$ for 2000 trials')
% legend('$\lambda$ = 0.99','$\lambda$ = 0.99-del','$\lambda$ = 0.95','$\lambda$ = 0.95-del','$\lambda$ = 0.92','$\lambda$ = 0.92-del','$\lambda$ = 0.90','$\lambda$ = 0.90-del')
legend('$\lambda$ = 0.99','$\lambda$ = 0.99','$\lambda$ = 0.95','$\lambda$ = 0.95','$\lambda$ = 0.92','$\lambda$ = 0.92','$\lambda$ = 0.90','$\lambda$ = 0.90')
sprintf('$\\mathbf{w}_{\\lambda = 0.99}$ = ($\\mathcal{N}$(%1.3f %1.3f), $\\mathcal{N}$(%1.3f %1.3f))',w_e1(end,1),w_e1_std(end,1),w_e1(end,2),w_e1_std(end,2))
sprintf('$\\mathbf{w}_{\\lambda = 0.95}$ = ($\\mathcal{N}$(%1.3f %1.3f), $\\mathcal{N}$(%1.3f %1.3f))',w_e2(end,1),w_e2_std(end,1),w_e2(end,2),w_e2_std(end,2))
sprintf('$\\mathbf{w}_{\\lambda = 0.92}$ = ($\\mathcal{N}$(%1.3f %1.3f), $\\mathcal{N}$(%1.3f %1.3f))',w_e3(end,1),w_e3_std(end,1),w_e3(end,2),w_e3_std(end,2))
sprintf('$\\mathbf{w}_{\\lambda = 0.90}$ = ($\\mathcal{N}$(%1.3f %1.3f), $\\mathcal{N}$(%1.3f %1.3f))',w_e4(end,1),w_e4_std(end,1),w_e4(end,2),w_e4_std(end,2))
subplot(1,3,3)
hold on
plot(n,w_es1,'g','LineWidth',2)
plot(n,w_es2,'r')
plot(n,w_es3,'b:')
plot(n,w_es4,'k')
hold off
% set(gca,'ytick',-0.3:.1:1.2)
set(gca,'YGrid', 'on')
xlabel('N')
ylabel('Coefficients')
title('$\mathbf{w}$ for single trial')
% legend('$\lambda$ = 0.99','$\lambda$ = 0.99-del','$\lambda$ = 0.95','$\lambda$ = 0.95-del','$\lambda$ = 0.92','$\lambda$ = 0.92-del','$\lambda$ = 0.90','$\lambda$ = 0.90-del')
legend('$\lambda$ = 0.99','$\lambda$ = 0.99','$\lambda$ = 0.95','$\lambda$ = 0.95','$\lambda$ = 0.92','$\lambda$ = 0.92','$\lambda$ = 0.90','$\lambda$ = 0.90')