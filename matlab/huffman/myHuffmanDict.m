% Author: Christos Gkournelos
% Date: 29/12/2018 
% 
% An custom implimentation of  Huffman dictionary generator
%
function [dict,avg_len] = myHuffmanDict(alphabet, probs, verbose)
  % 
  %  Input error checking 
  % 
  if nargin < 2
    error('Wrong input. \nThe function requires 2 input vectors', -1) 
  end
  if length(alphabet) ~= length(probs)
    error('Wrong input. \nThe length of alphabet and probalities does not match', -1) 
  end   
  if (~strcmp( class(probs), 'double') )
    error('Wrong input. \nThe probabilities vector must be of type double', -1)
  end
  if (min( probs ) < 0 )
    error('Wrong input. \nProbabilities of an input symbol cannot be negative', -1)
  end
  if (max( probs ) > 1 )
    error('Wrong input. \nProbabilities of an input symbol cannot be greater than 1', -1)
  end
  % 
  % Initialize  structs
  % 
  for i = 1:length(alphabet)
    origin_index{i} = i;
    if isnumeric(alphabet(i))
      symbol{i} = num2str(alphabet(i));
    elseif (isstr(alphabet(i)) || ischar(alphabet(i))) 
      symbol{i} = alphabet(i);
    elseif iscell(alphabet)
      symbol{i} = alphabet{i};
    else
      error('Wrong input. \nUnknown type of alpabet symbols. They must be chars vector or cell', -1)
    end % if
    code_table{i} = '';
  end %for
  dict.symbol = symbol; 
  dict.code = code_table;
  dict.prob = probs;
  origin_struct = struct('symbol',{symbol}, 'prob', probs, 'ind', {origin_index});
  [sorted_struct index] = mySortStruct(origin_struct, 'prob');  
  %
  % Main loop
  %
  while sorted_struct.prob ~= 1
    % Update
    updated_struct = myHuffMerge(sorted_struct, index);
    % Sort
    [sorted_struct index] = mySortStruct(updated_struct, 'prob');
  end % while
  avg_len = myHuffLength(dict);
  entro = myEntropy(dict.prob);
  if(verbose == 1) 
    fprintf('Huffman coding atributes: \n\t - average length = %.4f \n\t - entropy = %.4f (max = %.4f) \n\t - efficiency = %.4f \n\n', avg_len ,entro, log2(length(alphabet)), (entro/avg_len));
  end %if
  % 
  % This function will update the symbols and the propabilities
  % 
  function [updated_struct_] = myHuffMerge(s_, ~)
    first_symbol_ind_ = s_.ind{1};
    dict.code = myHuffCodeUpdate(dict.code,first_symbol_ind_,'1');
    second_symbol_ind_= s_.ind{2};
    dict.code = myHuffCodeUpdate(dict.code,second_symbol_ind_,'0');
    % Merge
    merged_symbol_ = [s_.symbol{1} s_.symbol{2}];
    merged_prob_   = s_.prob(1) + s_.prob(2);
    merged_index_ = [s_.ind{1} s_.ind{2}];
    % Clear
    s_.symbol(1:2) = '';
    s_.prob(1:2)   = '';
    s_.ind(1:2)   = '';
    % Update
    s_.symbol = [s_.symbol merged_symbol_];
    s_.prob = [s_.prob merged_prob_];
    s_.ind = [s_.ind merged_index_];
    updated_struct_ = s_;
  end % fuction myHuffMerge
  % 
  % This function will fill the code word on the dictionary
  % 
  function [code_table_] = myHuffCodeUpdate(code_table_,input_ind_,new_code_)
    for i = 1:length(input_ind_)
        code_table_{input_ind_(i)} = strcat(new_code_, code_table_{input_ind_(i)});      
    end
  end % function myHuffCodeUpdate
  function [avg_len_] = myHuffLength(dict_)
    avg_len_ = 0;
    for i = 1:length(dict_.symbol)
      avg_len_ = avg_len_ + dict_.prob(i)*length(dict_.code{i});
    end % for
  end % function myHuffLength
  function entro = myEntropy(probs)
    entro = sum(probs.*log2(1./probs));
  end % myEntropy
end % funtion myHuffmanDict