%
% This script is used for testing myHuffman implementation 
% with kwords source
%
clear; clc;
load('alphabet_symbols.mat'); % alphabet : loads the letters of english alphabet 
load('alphabet_probs.mat'); % probabilities : loads the probability of each letter based on wikepedia
load('kwords.mat'); % kwords : This table contains the letters from kwords.txt
%
% Fill the source_b vector
%
t_array = table2array(kwords);
source_b = char();
for i = 1:length(t_array)
  source_b = [source_b char(t_array(i))];
end % for
%
% Compute Hufmman dictionary
%
[dict, avg_code_len] = myHuffmanDict(alphabet,cell2mat(probabilities),1);
%
% Encode source_b
%
enco = myHuffmanEnco(source_b,dict,1);
%
% Decode again and check if the result is the same
%
deco = myHuffmanDeco(enco, dict);
if isequal(deco,source_b)
  disp('Perfect!! Our Huffman works fine with kwords source.');
else
  error('Ooops maybe we missed something.');
end % if
fprintf('-----------------\n');
%
% Update the probabilities for each symbol
%
[updated_alphabet updated_probs] = myFreqCompute(source_b);
%
% Compute new Hufmman dictionary
%
[updated_dict, updated_avg_code_len] = myHuffmanDict(updated_alphabet,cell2mat(updated_probs), 1);
%
% Encode source_b
%
updated_enco = myHuffmanEnco(source_b,updated_dict,1);
%
% Decode again and check if the result is the same
%
updated_deco = myHuffmanDeco(updated_enco, updated_dict);
if isequal(updated_deco,source_b)
  disp('Perfect!! Our updated Huffman works fine kwords source.');
else
  error('Ooops maybe we missed something.');
end % if
