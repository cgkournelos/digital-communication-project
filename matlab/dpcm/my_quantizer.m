% Author: Christos Gkournelos
% Date: 05/01/2019 
% 
% An custom implimentation of a N-bits quantizer 
%
function [y_quant] = my_quantizer (y , N, min_value, max_value)
  % 
  %  Input error checking 
  % 
  if (nargin ~= 4)
    error('Wrong input. \nThe function requires 4 inputs', -1) 
  end % if
  if y < min_value 
    y = min_value;
  elseif y > max_value
   y = max_value;
  end % if 
  %
  % Compute centers vector
  %
  delta = 2*max_value/(2^(N));
  centers(1) = max_value - (delta / 2);
  for i = 2:(2^N)
    centers(i) = centers(i-1) - delta;
  end % for
  %
  % Find y's quantized value
  %
  for i = 1 : (2^N)
    if ((y >= (centers(i) - delta/2)) && (y <= (centers(i) + delta/2)))
      y_quant = centers(i);
      break;
    end % if
  end % for
end % my_quantizer
