% Author: Christos Gkournelos
% Date: 30/12/2018 
% 
% An custom implimentation of  Huffman encoding
%
function enco = myHuffmanEnco(sig , dict, verbose)
  % 
  %   --- Input error checking ----
  % 
  if nargin < 2
    error('Wrong input. \nThe function requires 2 input vectors', -1) 
  end
  [m,n] = size(sig);
  if ( m ~= 1 && n ~= 1)
      error('Wrong input. \nThe input signal must be a vector.', -1);
  end
  if ( ~isstruct(dict) )
      error('Wrong input. \nThe input dictionary must be a struct.', -1);
  end
  %
  % Main loop
  %
  enco = [];
  for i = 1:length(sig) % signal iterator
    t_code = '';
    for j = 1:length(dict.symbol) % dictionary iterator
      if(strcmp(sig(i), dict.symbol{j}))
        t_code = dict.code{j};
        break;
      end % if
    end % for j
    if isempty(t_code)
        sig(i)
        error('One of the input signal characters is not incuded in Huffman dictionary.');
    else      
        enco = [enco t_code];
    end % if
  end % for i
  if(verbose == 1)
    fprintf('Huffman encode atributes: \n\t- Input signal size = %.4f kB\n\t- Encoded signal size = %.4f kB\n\n', (length(sig)/1000), ((length(enco)/8)/1000));
  end %if
end % myHuffmanEnco