clc
clear all
close all
for k=1:50
x  = .25*randn(1,500);     % Input to the filter
a1 = 0.1;
a2 = 0.8;
b = [1 -a1 -a2];
n  = 0.25*randn(1,500); % Observation noise signal
d  = filter(1,b,x);  % Desired signal
P0 = 1*eye(2); % Initial sqrt correlation matrix inverse
lam = 1;            % RLS forgetting factor
ha = adaptfilt.rls(2,lam,P0);
[y,e] = filter(ha,x,d);
error(k,:) = e.^2;
end
e = mean(error);
plot(10*log10(e))
% subplot(2,1,1); plot(1:500,[d;y;e]);
% title('System Identification of an FIR Filter');
% legend('Desired','Output','Error');
% xlabel('Time Index'); ylabel('Signal Value');
% subplot(2,1,2); stem([b.',ha.Coefficients.']);
% legend('Actual','Estimated');
% xlabel('Coefficient #'); ylabel('Coefficient valUe');  grid on;

%%

clc
clear all
close all
x = zeros(500,100); d = x;     % Initialize variables
a1 = 0.1;
a2 = 0.8;
ha = [1 -a1 -a2];           % FIR system to be identified
x = filter(1,1,(randn(size(x))));
n = 0.25*randn(size(x));        % observation noise signal
d = filter(1,ha,0.25*randn(size(x)));          % desired signal
l = 3;                        % Filter length
mu = 0.05;                    % LMS step size.
m  = 5;                        % Decimation factor for analysis
                               % and simulation results
ha = adaptfilt.lms(l,mu);
[mmse,emse,meanW,mse,traceK] = msepred(ha,x,d,m);
[simmse,meanWsim,Wsim,traceKsim] = msesim(ha,x,d,m);
nn = m:m:size(x,1);
figure(1)
plot(nn,10*log10(simmse),[0 size(x,1)],10*log10([(emse+mmse) (emse+mmse)]),nn,10*log10(mse),[0 size(x,1)],10*log10([mmse mmse]));
tit = sprintf('Mean-Square Error MSE:%s EMSE:%s',num2str(mmse),num2str(emse))
title(tit);
axis tight
legend('MSE (Ideal)','Final MSE','MSE','Min. MSE');
xlabel('Time Index'); ylabel('Squared Error Value');
