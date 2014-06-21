clear all
close all
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
e = zeros(1,N);
w_e = zeros(N,2);
g = zeros(N,2);
P = zeros(2,2,N);
lambda = 1;
trials = 2000;
w_hist = zeros(N,2,trials);
e_hist = zeros(trials,N);

%% SWRLS
w = sqrt(sigma)*randn(1,N+discard);
x = filter(1,a,w)';
x = x(discard+1:end);
