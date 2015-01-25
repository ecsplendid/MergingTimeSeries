function finalInd = multiplyVicinitiesByParameter(ind,put);

% multiplyVicinitiesByParameter takes a matrix of 0s and 1s corresponding
% to vicinities and a vector of parameters (e.g. put/call) and outputs a
% "Cartesian product", i.e., the first line of finalInd contains 1s
% whenever the strike was in vicinity 1 and the parameter in put was equal
% to the first possible value etc.

[n m] = size(put);

if n~=1
    put = put';
end

[n m] = size(put);

if n~=1
    error('put must be a vector');
end

[r s] = size(ind);

if s~=m
    ind = ind';
end

[r s] = size(ind);

if s~=m
    error('the time is out of joint: sizes of ind and put do not match');
end

finalInd = [];
[n m] = size(ind);

values = sort(unique(put)); % all values in put (normally just 0 and 1)

numValues = length(values);

for i=1:numValues
    I = (put  == values(i));
    finalInd = [finalInd; ind.*repmat(I,n,1)];
end