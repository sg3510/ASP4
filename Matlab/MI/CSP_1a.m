close all;
clear all;
clc;

%Program parameters
N = 500;
w0 = 0.9*ones(N,1);
%p = 0.0000005;
p = 0.005;
alpha =0.5;
ord = 1;
step1 = 0.01;
step2 = 0.1;

%Define and generate MA(1) process
b = [1 0.9];
a = 1;
n = randn(1,N);
x = filter(b, a, n);
%%
%Analyse with adaptive LMS
[w_hist1, e1, x_est1, u1] = runLMS_MA_GASS(x, n, ord, 1, p, alpha);
[w_hist2, e2, x_est2, u2] = runLMS_MA_GASS(x, n, ord, 2, p, alpha);
[w_hist3, e3, x_est3, u3] = runLMS_MA_GASS(x, n, ord, 3, p, alpha);
%%
%Analyse with standard LMS
[w_hist4, e4, x_est4] = runLMS_MA(x, n, step1, ord);
[w_hist5, e5, x_est5] = runLMS_MA(x, n, step2, ord);
%%


%Calculate 2nd coefficient error
w1 = (w0 - w_hist1(:,2)).^2;
w2 = (w0 - w_hist2(:,2)).^2;
w3 = (w0 - w_hist3(:,2)).^2;
w4 = (w0 - w_hist4(:,2)).^2;
w5 = (w0 - w_hist5(:,2)).^2;

%Calculate steady state error
w1_ss = mean(w1(end-100:end));
w2_ss = mean(w2(end-100:end));
w3_ss = mean(w3(end-100:end));
w4_ss = mean(w4(end-100:end));
w5_ss = mean(w5(end-100:end));

error_ss = [w1_ss, w2_ss, w3_ss, w4_ss, w5_ss]; 


figure(1)
subplot(1,3,1)
hold on;
plot(w_hist1(:,1), 'b'),title('Coefficient 1 Convergence'), xlabel('Time (Samples)'), ylabel('Coefficient Value');
plot(w_hist2(:,1), 'r');
plot(w_hist3(:,1), 'g');
plot(w_hist4(:,1), 'k');
plot(w_hist5(:,1), 'm');
axis([0 50 0 1.2]);
legend('LMS Benveniste','LMS Ang & Farhang','LMS Matthews & Xie','LMS \mu = 0.01','LMS \mu = 0.1');
hold off;

subplot(1,3,2)
hold on;
plot(w_hist1(:,2), 'b'),title('Coefficient 2 Convergence'), xlabel('Time (Samples)'), ylabel('Coefficient Value');
plot(w_hist2(:,2), 'r');
plot(w_hist3(:,2), 'g');
plot(w_hist4(:,2), 'k');
plot(w_hist5(:,2), 'm');
axis([0 50 0 1.2]);
legend('LMS Benveniste','LMS Ang & Farhang','LMS Matthews & Xie','LMS \mu = 0.01','LMS \mu = 0.1');
hold off;

subplot(1,3,3)
hold on;
plot(10*log10(w1), 'b'),title('Squared Error of Coefficient = 0.9'), xlabel('Time (Samples)'), ylabel('Squared Coefficient Error (dB)');
plot(10*log10(w2), 'r');
plot(10*log10(w3), 'g');
plot(10*log10(w4), 'k');
plot(10*log10(w5), 'm');
legend('LMS Benveniste','LMS Ang & Farhang','LMS Matthews & Xie','LMS \mu = 0.01','LMS \mu = 0.1');
axis([0 80 -35 0.5]);
hold off;





