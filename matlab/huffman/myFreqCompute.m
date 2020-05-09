% Author: Christos Gkournelos
% Date: 02/01/2019 
% 
% An custom implimentation for computing the frequency of 
% each symbol in a char array
%
function [alphabet freq] = myFreqCompute(input_stream)
  % initialize the alphabet
  cell_flag = 0;
  if iscell(input_stream)
    cell_flag = 1;
    util_struct.symbol{1} = input_stream{1};
  else
    util_struct.symbol{1} = input_stream(1);
  end % if
  util_struct.appearance{1} = 1;
  for i = 2 : length(input_stream)
    allready_exist = 0;
    for j = 1 : length(util_struct.symbol)
      if(cell_flag == 1)
        if (isequal(input_stream{i}, util_struct.symbol{j} ))
          allready_exist = 1;
          util_struct.appearance{j} = util_struct.appearance{j} + 1;
        end % if
      else
        if(strcmp(input_stream(i), util_struct.symbol{j}))
          allready_exist = 1;
          util_struct.appearance{j} = util_struct.appearance{j} + 1;
        end % if
      end % if
    end % for
    if(allready_exist == 0)
      if (cell_flag == 1)
        util_struct.symbol{length(util_struct.symbol)+1} =  input_stream{i};
      else
        util_struct.symbol = [util_struct.symbol input_stream(i)];
      end % if
      util_struct.appearance = [util_struct.appearance 1];
    end %if
  end % for
  for j = 1 : length(util_struct.symbol)
    util_struct.freq{j} = util_struct.appearance{j} / length(input_stream);
  end %for
  freq = util_struct.freq;
  alphabet = util_struct.symbol;
end % myFreqCompute