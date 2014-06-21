clear all
close all
clc
sigma = .25
% subplot(1,2,1)
L_a = [1,5,20,50,100,150,250,300,400];
col = ['g  ';'g  ';'g--';'r  ';'b  ';'g--';'g--';'k  ';'g--'];
for j=[2,4,5,8]
    L = L_a(j);
    file = sprintf('part3_2_c_L%d.mat',L);
    load(file)
    e = mean(e_hist.^2);
    hold on
    plot(10*log10(e),col(j));
    mse = mean(e(150:end));
    emse = mse - sigma;
    fprintf('L=%d MSE:%s EMSE:%s\n',L,num2str(mse),num2str(emse))
    % fprintf('L=%d $\\mathbf{w} = (\\$mathcal{N}$(%s, %s) \\$mathcal{N}$(%s, %s))\n',L,num2str(e(end,1)),num2str(w_std(end,1)),num2str(e(end,2)),num2str(w_std(end,2)))
end

file = sprintf('part3_2_c_mu_5.mat');
 load(file)
e = mean(e_hist.^2);
plot(10*log10(e),'m');
legend('RLS L=5','RLS L=50','RLS L=100','RLS L=300','LMS $\mu=0.05$')
mse = mean(e(150:end));
    emse = mse - sigma;
 fprintf('mu=0.05 MSE:%s EMSE:%s\n',num2str(mse),num2str(emse))
% hold off
set(gca,'YGrid', 'on')
% fprintf('\\mu=%s $\\mathbf{w} = (\\$mathcal{N}$(%s, %s) \\$mathcal{N}$(%s, %s))\n',num2str(0.05),num2str(e(end,1)),num2str(w_std(end,1)),num2str(e(end,2)),num2str(w_std(end,2)))
xlabel('N')
ylabel('Error (dB)')
