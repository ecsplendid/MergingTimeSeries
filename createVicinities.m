function timesInVicinities = createVicinities(strikes,diameter);

% createVicinities returns a matrix of zeroes and ones so that line 1
% has 1s for moments of time when the strike was in the vicinity 1 and 0
% otherwise.
% The arguments are the vector of strikes as they happened and the desired
% size of the vicinity.

[n m] = size(strikes);

if n~=1
    strikes = strikes';
end

[n m] = size(strikes);

if n~=1
    error('strikes must be a vector');
end

strikesSet = sort(unique(strikes)); % the possible strikes

numStrikes = length(strikesSet); % number of possible strikes

numVicinities = numStrikes - diameter +1; % the number of vicinities

beginning = (1:numVicinities)'; % initial points of vicinities

indicesOfVicinities = repmat(beginning, 1, diameter) + repmat(0:(diameter - 1), numVicinities, 1);

vicinities = strikesSet(indicesOfVicinities);
% rows of this matrix are vicinities of size diameter of strikes

[r s] = size(vicinities);

if (diameter == 1) && (r == 1)
    vicinities = vicinities';
end

timesInVicinities = [];

for i=1:numVicinities
    I = ismember(strikes,vicinities(i,:));
    timesInVicinities = [timesInVicinities; I];
end