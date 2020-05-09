%
% This script is used for testing my DPCM implementation 
% and plot the signal with prediction noise
%
clear; clc;
load('source.mat') % x: input signal
%
% First test p = 4
%
p = 4;
N = 3;
for i = 1:N
  dpcm_trans_N{i} = my_dpcm_trans(x, p, i);
  dpcm_rec_N{i} = my_dpcm_rec(dpcm_trans_N{i}.y_quant, p, dpcm_trans_N{i}.a_quant, x(1:p)');
end % for
%
% Plot
%
figure
hold on
plot((1:length(x)),x,'r-')
plot((1:length(x)),dpcm_trans_N{1}.y,'g-')
plot((1:length(x)),dpcm_trans_N{2}.y,'m-')
plot((1:length(x)),dpcm_trans_N{3}.y,'b-')
legend({'$x(n)$','$y(n) - N=1$','$y(n) - N=2$' ,'${y(n) - N=3}$'}, 'Interpreter','latex');
xlabel('Discrete time $(n)$','Interpreter','latex');
ac = gca;
ac.FontSize = 18;
hold off
%
% Second test p = 24
%
clear;
load('source.mat') % x: input signal
p = 24;
N = 3;
for i = 1:N
  dpcm_trans_N{i} = my_dpcm_trans(x, p, i);
  dpcm_rec_N{i} = my_dpcm_rec(dpcm_trans_N{i}.y_quant, p, dpcm_trans_N{i}.a_quant, x(1:p)');
end % for
%
% Plot
%
figure
hold on
plot((1:length(x)),x,'r-')
plot((1:length(x)),dpcm_trans_N{1}.y,'g-')
plot((1:length(x)),dpcm_trans_N{2}.y,'m-')
plot((1:length(x)),dpcm_trans_N{3}.y,'b-')
legend({'$x(n)$','$y(n) - N=1$','$y(n) - N=2$' ,'${y(n) - N=3}$'}, 'Interpreter','latex');
xlabel('Discrete time $(n)$','Interpreter','latex');
ac = gca;
ac.FontSize = 18;
hold off