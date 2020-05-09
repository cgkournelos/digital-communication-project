% Author: Christos Gkournelos
% Date: 03/01/2019 
% 
% An custom implimentation for creating 
% an N-order symbol source 
%
function [new_source, new_probs] = myNOrderSourceGen(init_source, init_probs, N)
  new_source = {};
  new_probs = {};
  if (N == 2)
    for i = 1:length(init_source)
      for j = 1:length(init_source)
        new_source{(length(new_source)) + 1} = [init_source{i} init_source{j}];
        new_probs{(length(new_probs)) + 1} = init_probs{i}*init_probs{j}; 
      end % for j
    end % for i
  elseif (N > 2)
    [source_, probs_] = myNOrderSourceGen(init_source, init_probs, N-1);
    for i = 1:length(init_source)
      for j = 1:length(source_)
        new_source{(length(new_source)) + 1} = [init_source{i} source_{j}];
        new_probs{(length(new_probs)) + 1} = init_probs{i}*probs_{j}; 
      end % for j
    end % for i
  elseif (N < 2)
    error('N-order must be higher to 2');
  end % if
end % myN_OrderSourceGen
