% Author: Christos Gkournelos
% Date: 30/12/2018 
% 
% An custom implimentation of  Huffman decoding
%
function deco = myHuffmanDeco(comp , dict)
  % 
  %   --- Input error checking ----
  % 
  if nargin ~= 2
    error('Wrong input. \nThe function requires 2 input vectors', -1) 
  end
  [m,n] = size(comp);
  if ( m ~= 1 && n ~= 1)
      error('Wrong input. \nThe input signal must be a vector.', -1);
  end
  if ( ~isstruct(dict) )
      error('Wrong input. \nThe input dictionary must be a struct.', -1);
  end
  %
  % Main loop
  %
  deco = {};
  code_pos = 1;
  while (code_pos <= length(comp))
    matches = dict;
    temp_code = comp(code_pos);
    not_found = 1;
    while (not_found)
      if (code_pos > length(comp))
        matches = findMatches(temp_code, code_pos - 1, matches, 1);
      else
        matches = findMatches(temp_code, code_pos, matches);
      end %if
      if(length(matches.code) ~= 1)
        code_pos = code_pos + 1;
        temp_code = comp(code_pos);
      else
        code_pos = 1;
        found_symbol = matches.symbol;
        not_found = 0;  
        comp = comp(length(matches.code{1})+1:end);
      end % if
    end % while not_found
    deco = [deco found_symbol];
  end % while lenght(comp)
  deco = cell2mat(deco);
  % 
  % This function will find the possible matches of the input signal with the dict
  % 
  function matches_ = findMatches(code_, pos_, dict_ , code_len_)
    if nargin == 3
      code_len_ = 0;
    end
    matches_.symbol = {};
    matches_.code = {};
    j = 1; 
    for i = 1:length(dict_.code)
      if (strcmp(dict_.code{i}(pos_), code_)) 
        if(code_len_ == 0)
          matches_.symbol(j) = dict_.symbol(i);
          matches_.code(j) = dict_.code(i);     
          j = j + 1;
        else
          if(length(dict_.code{i}) == code_len_)
            matches_.symbol(j) = dict_.symbol(i);
            matches_.code(j) = dict_.code(i);     
            j = j + 1;
          end %if        
        end %if                
      end % if
    end %for
  end % function findMatches
end % function myHuffmanDeco