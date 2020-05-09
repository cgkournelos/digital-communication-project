% Author: Christos Gkournelos
% Date: 05/01/2019 
% 
% A function for computing the factors of
% the p-linear predictor
%
function [a_factors] = my_predictor_factors(p, x)
  % 
  %  Input error checking 
  % 
  if (nargin ~= 2)
    error('Wrong input. \nThe function requires 2 inputs', -1) 
  end % if
  N = length(x);
  %
  % Compute autocorrelation vector r_vec
  %
  for i = 1 : p
    sum = 0;
    for j = p+1 : N 
      sum = sum + x(j)*x(j-i);
    end %for
    r_vec(i) = sum / (N - p);
  end % for
  %
  % Compute autocorrelation matrix R_mat
  %
  for i = 1:p
    for j = 1 : p 
      sum = 0;
      for k = p+1 : N
        sum = sum + x(k-i)*x(k-j);
      end % for k
      R_mat(i,j) = sum / (N - p);
    end %for j
  end % for i
  %
  % Compute a factors 
  %
  a_factors = R_mat \ r_vec';
end % my_predictor_factors


