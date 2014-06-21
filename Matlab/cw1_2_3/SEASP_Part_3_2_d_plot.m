clear all
close all
clc

subplot(1,2,1)
L_a = [1,5,20,50,100,150,250,300,400];
col = ['g  ';'g  ';'g--';'r  ';'b  ';'g--';'g--';'k  ';'g--'];
for j=[2,4,5,8]
    L = L_a(j);
    file = sprintf('part3_2_c_L%d.mat',L);
    load(file)
    w_e = mean(w_hist,3);
    w_std = std(w_hist,[],3);
    hold on
    plot(w_e(1:200,:),col(j));
    fprintf('L=%d $\\mathbf{w} = (\\$mathcal{N}$(%s, %s) \\$mathcal{N}$(%s, %s))\n',L,num2str(w_e(end,1)),num2str(w_std(end,1)),num2str(w_e(end,2)),num2str(w_std(end,2)))
end

file = sprintf('part3_2_c_mu_5.mat');
 load(file)
w_e = mean(w_hist,3);
w_std = std(w_hist,[],3);
plot(w_e(1:200,:),'m');
% legend('RLS L=5','RLS L=50','RLS L=100','RLS L=300','LMS $\mu=0.05$')
% hold off
set(gca,'YGrid', 'on')
fprintf('\\mu=%s $\\mathbf{w} = (\\$mathcal{N}$(%s, %s) \\$mathcal{N}$(%s, %s))\n',num2str(0.05),num2str(w_e(end,1)),num2str(w_std(end,1)),num2str(w_e(end,2)),num2str(w_std(end,2)))
title('200 trials')

subplot(1,2,2)

for j=[2,4,5,8]
    L = L_a(j);
    file = sprintf('part3_2_c_L%d.mat',L);
    load(file)
    w_e = w_hist(:,:,5);
    w_std = std(w_hist,[],3);
    col(j,:)
    hold on
    plot(w_e(1:200,:),col(j));
    
end

file = sprintf('part3_2_c_mu_5.mat');
 load(file)
w_e = w_hist(:,:,5);
plot(w_e(1:200,:),'m');
legend('RLS L=5','RLS L=5','RLS L=50','RLS L=50','RLS L=100','RLS L=100','RLS L=300','RLS L=300','LMS $\mu=0.05$','LMS $\mu=0.05$')
set(gca,'YGrid', 'on') 	
title('single trial')