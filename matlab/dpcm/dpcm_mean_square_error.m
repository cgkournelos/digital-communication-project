%
% This script is used for testing my DPCM implementation 
% and plot the mean square error of  prediction
%
clear; clc;
load('source.mat') % x: input signal
N = 3;
a_factors_p = zeros(8,5);
a_quant_p = zeros(8,5);
for p =  4:8
  for i = 1:N
    dpcm_trans_N{i} = my_dpcm_trans(x, p, i);
    dpcm_rec_N{i} = my_dpcm_rec(dpcm_trans_N{i}.y_quant, p, dpcm_trans_N{i}.a_quant, x(1:p)');
    mean_sq_error(i,p-3) = immse(x',dpcm_trans_N{i}.y_pred);
  end % for
  a_factors_p(1:p,p-3) = dpcm_trans_N{1}.a_factors;
  a_quant_p(1:p,p-3) = dpcm_trans_N{1}.a_quant;
end %for p
%
% Plot
%
figure
hold on
plot(mean_sq_error(:,1),'b-s')
plot(mean_sq_error(:,2),'r-+')
plot(mean_sq_error(:,3),'g-x')
plot(mean_sq_error(:,4),'m-d')
plot(mean_sq_error(:,5),'c-*')
legend({'$p=4$','$p=5$','$p=6$' ,'$p=7$','$p=8$'}, 'Interpreter','latex');
xlabel('$N$ bits','Interpreter','latex');
ylabel('Mean square error','Interpreter','latex');
% title('$MSE = E(y^2(n)) =  E((x(n)-y'(n))^2)$','Interpreter','latex')
ac = gca;
ac.FontSize = 18;
hold off