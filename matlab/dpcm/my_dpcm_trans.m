% Author: Christos Gkournelos
% Date: 05/01/2019 
% 
% A function which emulates a DPCM trasmitter system 
%   
function [trans_vars] = my_dpcm_trans(x, p, N)
  % 
  %  Input error checking 
  % 
  if (nargin ~= 3)
    error('Wrong input. \nThe function requires 3 inputs', -1) 
  end % if
  %
  % Initialization
  %
  max_quant_val =  3.5;
  min_quant_val = -3.5; 
  for i = 1 : p 
    y(i) = x(i);
    y_pred(i) = x(i);
    y_quant(i) = my_quantizer(x(i), N, min_quant_val, max_quant_val);
    y_mem(i) = y_pred(i) + y_quant(i);
  end % for
  %
  % Find prediction filter factors and quantize them
  %
  a_factors = my_predictor_factors(p, x);
  for i = 1 : length(a_factors)
    a_quant(i) = my_quantizer(a_factors(i), 8, -2, 2);
  end % for
  %
  % Main DPCM encoding loop
  % 
  for i = (p+1) : length(x)
    y_pred(i) = sum(a_quant .* fliplr(y_mem((i-p):(i-1))));
    y(i) = x(i) - y_pred(i);
    y_quant(i) = my_quantizer(y(i), N, min_quant_val, max_quant_val);
    y_mem(i) = y_pred(i) + y_quant(i);
  end % i
  %
  % Fill the return structure
  %
  trans_vars.y = y;
  trans_vars.y_pred = y_pred;
  trans_vars.y_quant = y_quant;
  trans_vars.y_mem = y_mem;
  trans_vars.a_factors = a_factors;
  trans_vars.a_quant = a_quant;
end % my_dpcm_impl
