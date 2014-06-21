clc
clear all
close all

tightness = [.1 .05];

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')

%% Gen all
load('low-wind.mat')
v_low = v_east + 1j*v_north;
load('medium-wind.mat')
v_med = v_east + 1j*v_north;
load('high-wind.mat')
v_hig = v_east + 1j*v_north;

% load('low-wind.mat')
% v_low = v_north + 1j*v_east;
% load('medium-wind.mat')
% v_med = v_north + 1j*v_east;
% load('high-wind.mat')
% v_hig = v_north + 1j*v_east;
N = length(v_low);

mu = .1;
[rho_low, z_h_low] = circ_estimate(v_low, mu);
[rho_med, z_h_med] = circ_estimate(v_med, mu);
[rho_hig, z_h_hig] = circ_estimate(v_hig, mu);
[w_low, ~, ~] = clms(conj(v_low), v_low, 0.01, 2);

%plot all
%%
tightness = [.1 .05];
subplot_tight(3,3,1,tightness)
hold on;
scatter(real(v_low),imag(v_low));
scatter(real(z_h_low),imag(z_h_low),10,'r','+');
hold off
xlabel('$\mathcal{R}e(\mathbf{v})$')
ylabel('$\mathcal{I}m(\mathbf{v})$')
title('Low wind scatter plot')
%%
subplot_tight(3,3,2,tightness)
hold on;
scatter(real(v_med),imag(v_med));
scatter(real(z_h_med),imag(z_h_med),10,'r','+');
hold off
xlabel('$\mathcal{R}e(\mathbf{v})$')
ylabel('$\mathcal{I}m(\mathbf{v})$')
title('Medium wind scatter plot')
subplot_tight(3,3,3,tightness)
hold on;
scatter(real(v_hig),imag(v_hig));
scatter(real(z_h_hig),imag(z_h_hig),10,'r','+');
hold off
xlabel('$\mathcal{R}e(\mathbf{v})$')
ylabel('$\mathcal{I}m(\mathbf{v})$')
legend('Actual value','Estimate')
title('High wind scatter plot')
%real rho
%%
tightness = [.1 .1];
subplot_tight(3,3,4,tightness)
b = std(real(rho_low));
a = mean(real(rho_low))*ones(1,N);
plot(real(rho_low))
hold on
plot(a,'r')
hold off
axis tight
xlabel('n')
title(sprintf('Low wind Mean: %1.3f Std-Dev:%1.3f',a(1),b))
ylabel('$\mathcal{R}e(\rho)$')
%%
subplot_tight(3,3,5,tightness)
b = std(real(rho_med));
a = mean(real(rho_med))*ones(1,N);
plot(real(rho_med))
hold on
plot(a,'r')
hold off
axis tight
xlabel('n')
title(sprintf('Medium wind Mean: %1.3f Std-Dev:%1.3f',a(1),b))
% ylabel('$\mathcal{R}e(\rho)$')
ylabel('')
subplot_tight(3,3,6,tightness)
b = std(real(rho_hig));
a = mean(real(rho_hig))*ones(1,N);
plot(real(rho_hig))
hold on
plot(a,'r')
hold off
axis tight
xlabel('n')
title(sprintf('High wind Mean: %1.3f Std-Dev:%1.3f',a(1),b))
legend('Re(\rho)','Mean')
% title('H estimate of $\rho$')
% ylabel('$\mathcal{R}e(\rho)$')
ylabel('')
%imag rho
%%
subplot_tight(3,3,7,tightness)
b = std(imag(rho_low));
a = mean(imag(rho_low))*ones(1,N);
plot(imag(rho_low))
hold on
plot(a,'r')
hold off
axis tight
xlabel('n')
title(sprintf('Low wind Mean: %1.3f Std-Dev:%1.3f',a(1),b))
% title('Low wind estimate of $\rho$')
ylabel('$\mathcal{I}m(\rho)$')
% ylabel('')
%%

subplot_tight(3,3,8,tightness)
b = std(imag(rho_med));
a = mean(imag(rho_med))*ones(1,N);
plot(imag(rho_med))
hold on
plot(a,'r')
hold off
axis tight
xlabel('n')
title(sprintf('Medium wind Mean: %1.3f Std-Dev:%1.3f',a(1),b))
% title(' estimate of $\rho$')
% ylabel('$\mathcal{I}m(\rho)$')
ylabel('')

subplot_tight(3,3,9,tightness)
b = std(imag(rho_hig));
a = mean(imag(rho_hig))*ones(1,N);
plot(imag(rho_hig))
hold on
plot(a,'r')
hold off
axis tight
xlabel('n')
title(sprintf('High wind Mean: %1.3f Std-Dev:%1.3f',a(1),b))
legend('Im(\rho)','Mean')
% title('High wind estimate of $\rho$')
% ylabel('$\mathcal{I}m(\rho)$')
ylabel('')