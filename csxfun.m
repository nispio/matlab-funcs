function C = csxfun(func,varargin)
% csxfun Apply function to each cell in array with singleton expansion enabled
%
%   C = csxfun(func,C1,C2,...,Cn) applies the function func to the elements of
%   input arguments C1 through Cn. 
%
%   C = csxfun(...,Name,Value) passes the name/value pairs given to the
%   function cellfun.  Possible names are 'UniformOutput' and 'ErrorHandler'.
%   Note that if no name/value pairs are provided, the default behavior is
%   the opposite of cellfun. csxfun assumes 'UniformOutput'=false.
%

%% Look for Name/Value pairs in arguments
T = find(cellfun('isclass', varargin, 'char'),1,'first');
if ~isempty(T)
    opts = varargin(T:end);
    varargin(T:end) = [];
else
    opts = {'UniformOutput',false};
end


%% Find out how many non-singleton dimensions we have
S = cellfun(@size, varargin, 'UniformOutput',false);
N = max(cellfun('size', S, 2));


%% Perform singleton expansion where necessary
S = cellfun(@(Y) [Y,ones(1,N-size(Y,2))], S, 'UniformOutput',false);
S0 = cell2mat(S.');
if any( (S0 ~= 1) & bsxfun(@ne, S0, max(S0)) )
    error('Mismatch in non-singleton dimensions!');
end
Z = cellfun(@(Y) max(S0)./Y, S, 'UniformOutput',false);
args = cellfun(@repmat, varargin, Z, 'UniformOutput',false);


%% Pass the expanded arguments to cellfun for evaluation
C = cellfun(func, args{:}, opts{:});

end
