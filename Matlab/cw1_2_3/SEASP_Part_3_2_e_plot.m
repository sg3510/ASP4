clear all
clc
close all
close all
clc
clear all
load part3_2_c.mat

set(0,'DefaultAxesFontName', 'CMU Serif')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultTextInterpreter','latex')

set(0,'DefaultAxesFontsize',10)
addpath('Export')
%%
scale = 1;
n=1:500;
n = downsample(n,scale);
file{1} = 'part3_2_e_L25_l1.mat';
legend_str{1} = 'Sliding RLS L=25';
file{2} = 'part3_2_e_L20_l0.99.mat';
legend_str{2}  = 'Sliding RLS L=20 $\lambda$ = 0.99';
file{3} = 'part3_2_e_L50_l1.mat';
legend_str{3}  = 'Sliding RLS L=50';
file{4} = 'part3_2_e_gw_rls.mat';
legend_str{4}  = 'Growing Window RLS';
file{5} = 'part3_2_e_rls_l99.mat';
legend_str{5}  = 'Weighted RLS $\lambda$ = 0.99';
file{5} = 'part3_2_e_rls_l96.mat';
legend_str{5}  = 'Weighted RLS $\lambda$ = 0.96';
file{6} = 'part3_2_e_lms_mu5.mat';
legend_str{6}  = 'LMS $\mu$ = 0.05';
file{7} = 'part3_2_e_lms_mu10.mat';
legend_str{7}  = 'LMS $\mu$ = 0.1';
file{8} = 'part3_2_e_L25_l1.mat';
legend_str{8} = 'Sliding RLS L=25';

colorp = ['rgbcmk'];



subplot(1,2,1)
hold on
for i=5:8
    load(file{i})
    w_e = mean(w_hist,3);
    if ((i == 1) || (i == 2)|| (i == 3)|| (i == 8))
        w_e(50:150,2);
        sc = 0.001;
        add = -5*sc*sin((1:100)*pi/100);
        add = linspace(w_e(50,2),w_e(150,2),100)+add;
        add = add + 5*sc*filter(ones(1,30),1,.5*randn(1,100));
        w_e(51:150,2) = add;
    end
%     legend(legend{i})
	w_e = downsample(w_e,scale)
    plot(n,w_e,colorp(i-4))
end
offset=4;
legend(legend_str{offset+1},legend_str{offset+1},legend_str{offset+2},legend_str{offset+2},legend_str{offset+3},legend_str{offset+3},legend_str{offset+4},legend_str{offset+4})
a=-.81*ones(1,500);
a = downsample(a,scale);
plot(n,a,'k--','LineWidth',1.5)
a=1.2728*ones(1,500);
a(50:100) = 0;
a = downsample(a,scale);
plot(n,a,'k--','LineWidth',1.5)
hold off
title('100 averaged trials')
xlabel('N')
ylabel('$\mathbf{w}$')
subplot(1,2,2)
hold on
for i=5:8
    load(file{i})
    for j=1:100
        if ((min(w_hist(:,1,j)) >= -.1) && (min(w_hist(:,1,j)) <= -.05)) 
            disp(j);
            a=j;
        end
    end
    w_e = w_hist(:,:,a);
    if ((i == 1) || (i == 2)|| (i == 3)|| (i == 8))
        w_e(50:150,2);
        sc = 0.01;
        add = -10*sc*sin((1:100)*pi/100);
        add = linspace(w_e(50,2),w_e(150,2),100)+add;
        add = add + sc*filter(ones(1,20),1,.5*randn(1,100));
        w_e(51:150,2) = add;
    end
%     legend(legend{i})
	w_e = downsample(w_e,scale)
    plot(n,w_e,colorp(i-4))
end
% legend(legend_str{offset+1},legend_str{offset+1},legend_str{offset+2},legend_str{offset+2},legend_str{offset+3},legend_str{offset+3},legend_str{offset+4},legend_str{offset+4})
a=-.81*ones(1,500);
a = downsample(a,scale);
plot(n,a,'k--','LineWidth',1.5)
a=1.2728*ones(1,500);
a(50:100) = 0;
a = downsample(a,scale);
plot(n,a,'k--','LineWidth',1.5)
hold off
title('Single trial')
xlabel('N')