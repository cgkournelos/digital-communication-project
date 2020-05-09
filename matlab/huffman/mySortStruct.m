% Author: Christos Gkournelos
% Date: 29/12/2018 
% 
% An custom implimentation for struct sorting
%
function [sorted_struct ind] = mySortStruct(s, field_name, direction)
  % 
  %   --- Input error checking ----
  % 
  if ~isstruct(s)
    error('Wrong input: \nFirst input supplied is not a struct.', -1)
  end % if
  if ~ischar(field_name) || ~isfield(s, field_name)
    error('Wrong input: \nSecond input is not a valid field_name.', -1)
  end % if

  % Direction by default is asceding
  if nargin < 3
    direction = 1;
  elseif ~isnumeric(direction) || numel(direction)>1 || ~ismember(direction, [-1 1])
    error('Wrong input. \nDirection must equal 1 for ascending order or -1 for descending order.')
  end % if
  [dummy ind] = sort(s.(field_name));
  fields = fieldnames(s);
  for ii=1:length(fields)
    field_ = char(fields(ii));
    if length(ind) == length(s.(field_))
      sorted_struct.(field_) = s.(field_)(ind);
    end % if
  end % for ii
end % mySortStruct