%
% This script is used for testing myHuffman implementation 
% with a second order random english letters source
%
clear; clc;
load('alphabet_symbols.mat'); % alphabet : loads the letters of english alphabet 
load('alphabet_probs.mat'); %probabilities : loads the probability of each letter based on wikepedia
letter_pos = 1:676; % index for letters in alphabet
%
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
% Genareate the random source_a
%
% random_pos_table = randsrc(10000,1,letter_pos);
random_pos_table = randsrc(5000,1,[letter_pos; cell2mat(probabilities_2)]);
source_a_2 = {};
for i = 1:5000
  source_a_2{i} = alphabet_2{random_pos_table(i)};
end % for
%
% Encode source_a_2
%
enco = myHuffmanEnco(source_a_2,dict,1);
%
% Decode again and check if the result is the same
%
deco = myHuffmanDeco(enco, dict);
if isequal(deco,cell2mat(source_a_2))
  disp('Perfect!! Our Huffman works fine with random sources.');
else
  error('Ooops maybe we missed something.');
end % if