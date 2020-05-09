%
% This script is used for testing myHuffman implementation 
% with a second order kwords source
%
clear; clc;
load('alphabet_symbols.mat'); % alphabet : loads the letters of english alphabet 
load('alphabet_probs.mat'); %probabilities : loads the probability of each letter based on wikepedia
load('kwords.mat'); % kwords : This table contains the letters from kwords.txt
%
% Fill the source_b vector
%
t_array = table2array(kwords);
source_b = char();
for i = 1:length(t_array)
  source_b = [source_b char(t_array(i))];
end % for
% Convert source_b from char vector to cell
jj = 1;
ii = 1;
while (ii < length(source_b))
  source_b_2{jj} = [source_b(ii) source_b(ii+1)];
  ii = ii + 2;
  jj = jj + 1;
end % while

% Convert alphabet to cell
%
for ii = 1:length(alphabet)
  alphabet_cell{ii} = alphabet(ii);
end % for
for ii = 1:length(probabilities)
  probabilities_cell{ii} = probabilities(ii);
end % for
%
% Create the 2-order of the alphabet 
%
[alphabet_2 probabilities_2] = myNOrderSourceGen(alphabet_cell, probabilities, 2);
%
% Compute the Hufmman dictionary of the 2-order A source
%
[dict, avg_code_len] = myHuffmanDict(alphabet_2,cell2mat(probabilities_2),1);
%
% Encode source_b_2
%
enco = myHuffmanEnco(source_b_2,dict,1);
%
% Decode again and check if the result is the same
%
% deco = myHuffmanDeco(enco, dict);
% if isequal(deco,cell2mat(source_b_2))
%   disp('Perfect!! Our Huffman works fine with random sources.');
% else
%   error('Ooops maybe we missed something.');
% end % if
fprintf('-----------------\n');
%
% Update the probabilities for each couple of symbols
%
[updated_alphabet_2 updated_probs_2] = myFreqCompute(source_b_2,alphabet_2);
%
% Compute new Hufmman dictionary
%
[updated_dict_2, updated_avg_code_len_2] = myHuffmanDict(updated_alphabet_2,cell2mat(updated_probs_2),1);
%
% Encode source_b
%
updated_enco_2 = myHuffmanEnco(source_b_2,updated_dict_2,1);
%
% Decode again and check if the result is the same
%
updated_deco = myHuffmanDeco(updated_enco_2, updated_dict_2);
if isequal(updated_deco,cell2mat(source_b_2))
  disp('Perfect!! Our updated Huffman works fine kwords source.');
else
  error('Ooops maybe we missed something.');
end % if
