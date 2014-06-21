close all;
clear all;
clc;

%Program parameters
N = 500;
w0 = 0.9*ones(N,1);
p2 = 1;
p1 = 0.008;
alpha =0.5;
ord = 1;
step1 = 0.01;
step2 = 0.1;


%Define and generate MA(1) process
b = [1 0.9];
a = 1;
n = randn(1,N);
x = filter(b, a, n);

%Analyse with adaptive LMS
[w_hist1, e1, x_est1, u1] = runLMS_MA_GASS(x, n, ord, 1, p1, alpha);

%Analyse with GNGD
[w_hist2, e2, x_est2, u2, eps] = runNLMS_GNGD_MA(x, n, 1, ord, p2);

%Calculate error for coefficient = 0.9
w1 = (w0 - w_hist1(:,2)).^2;
w2 = (w0 - w_hist2(:,2)).^2;

%Calculate steady state error
w1_ss = mean(w1(end-100:end));
w2_ss = mean(w2(end-100:end));

figure(1)
subplot(1,3,1)
hold on;
plot(w_hist1(:,1), 'b'),title('Coefficient 1 Convergence'), xlabel('Time (Samples)'), ylabel('Coefficient Value');
plot(w_hist2(:,1), 'r');
axis([0 50 0 1.2]);
legend('LMS Benveniste','LMS GNGD');
hold off;

subplot(1,3,2)
hold on;
plot(w_hist1(:,2), 'b'),title('Coefficient 2 Convergence'), xlabel('Time (Samples)'), ylabel('Coefficient Value');
plot(w_hist2(:,2), 'r');
axis([0 50 0 1.2]);
legend('LMS Benveniste','LMS GNGD');
hold off;

subplot(1,3,3)
hold on;
plot(10*log10(w1), 'b'),title('Squared Error of Coefficient = 0.9'), xlabel('Time (Samples)'), ylabel('Squared Coefficient Error (dB)');
plot(10*log10(w2), 'r');
legend('LMS Benveniste','LMS GNGD');
axis([0 80 -35 0.5]);
hold off;
