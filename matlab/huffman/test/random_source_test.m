%
% This script is used for testing myHuffman implementation 
% with a random english letters source
%
clear; clc;
load('alphabet_symbols.mat'); % alphabet : loads the letters of english alphabet 
load('alphabet_probs.mat'); %probabilities : loads the probability of each letter based on wikepedia
letter_pos = 1:26; % index for letters in alphabet
%
% Genareate the random source_a
%
% random_pos_table = randsrc(10000,1,letter_pos);
random_pos_table = randsrc(10000,1,[letter_pos; cell2mat(probabilities)]);
source_a = char();
for i = 1:10000
  source_a(i) = alphabet(random_pos_table(i));
end % for
%
% Compute Hufmman dictionary
%
[dict, avg_code_len] = myHuffmanDict(alphabet, cell2mat(probabilities), 1);
%
% Encode source_a
%
enco = myHuffmanEnco(source_a, dict, 1);
%
% Decode again and check if the result is the same
%
deco = myHuffmanDeco(enco, dict);
if isequal(deco,source_a)
  disp('Perfect!! Our Huffman works fine with random sources.');
else
  error('Ooops maybe we missed something.');
end % if

