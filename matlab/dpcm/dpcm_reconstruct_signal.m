%
% This script is used for testing my DPCM implementation 
% and plot the reconstructed signal over the initial signal
%
clear; clc;
load('source.mat') % x: input signal
%
% First test p = 4
%
p = 4;
N = 3;
for i = 1:N
  dpcm_trans_N{1,i} = my_dpcm_trans(x, p, i);
  dpcm_rec_N{1,i} = my_dpcm_rec(dpcm_trans_N{1,i}.y_quant, p, dpcm_trans_N{1,i}.a_quant, x(1:p)');
end % for
p = 8;
for i = 1:N
  dpcm_trans_N{2,i} = my_dpcm_trans(x, p, i);
  dpcm_rec_N{2,i} = my_dpcm_rec(dpcm_trans_N{2,i}.y_quant, p, dpcm_trans_N{2,i}.a_quant, x(1:p)');
end % for
%
% Plot N=1
%
figure
hold on
x_ax = 5000:5100;
plot(x_ax,x(5000:5100),'k-o')
plot(x_ax,dpcm_rec_N{1,1}.y_mem(5000:5100),'g-s')
plot(x_ax,dpcm_rec_N{2,1}.y_mem(5000:5100),'r-+')
legend({'$x(n)$','$\hat{y}(n) - p=4$','$\hat{y}(n) - p=8$'}, 'Interpreter','latex');
xlabel('Discrete time $(n)$','Interpreter','latex');
ac = gca;
ac.FontSize = 18;
hold off
%
% Plot N=2
%
figure
hold on
x_ax = 5000:5100;
plot(x_ax,x(5000:5100),'k-o')
plot(x_ax,dpcm_rec_N{1,2}.y_mem(5000:5100),'g-s')
plot(x_ax,dpcm_rec_N{2,2}.y_mem(5000:5100),'r-+')
legend({'$x(n)$','$\hat{y}(n) - p=4$','$\hat{y}(n) - p=8$'}, 'Interpreter','latex');
xlabel('Discrete time $(n)$','Interpreter','latex');
ac = gca;
ac.FontSize = 18;
hold off
%
% Plot N=3
%
figure
hold on
x_ax = 5000:5100;
plot(x_ax,x(5000:5100),'k-o')
plot(x_ax,dpcm_rec_N{1,3}.y_mem(5000:5100),'g-s')
plot(x_ax,dpcm_rec_N{2,3}.y_mem(5000:5100),'r-+')
legend({'$x(n)$','$\hat{y}(n) - p=4$','$\hat{y}(n) - p=8$'}, 'Interpreter','latex');
xlabel('Discrete time $(n)$','Interpreter','latex');
ac = gca;
ac.FontSize = 18;
hold off