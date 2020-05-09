% Author: Christos Gkournelos
% Date: 05/01/2019 
% 
% A function which emulates a DPCM receiver system 
%   
function [rec_vars] = my_dpcm_rec(y_quant, p, a_factors, init_vec )
  % 
  %  Input error checking 
  % 
  if (nargin ~= 4)
    error('Wrong input. \nThe function requires 3 inputs', -1) 
  end % if
  if (length(init_vec) ~= p)
    error('Wrong input. \nInitialization vector must be same size with p ', -1) 
  end
  if (length(a_factors) ~= p)
    error('Wrong input. \nPrediction factors vector must be same size with p ', -1) 
  end
  %
  % Initialization
  %
  y_pred = init_vec;
  y_mem = init_vec;
  %
  % Main DPCM encoding loop
  % 
  for i = (p+1):length(y_quant)
    y_pred(i) = sum(a_factors .* fliplr(y_mem((i-p):(i-1))));
    y_mem(i) = y_quant(i) + y_pred(i);
  end % for i
  %
  % Fill the return structure
  %
  rec_vars.y_pred = y_pred;
  rec_vars.y_mem = y_mem;
end % my_dpcm_rec