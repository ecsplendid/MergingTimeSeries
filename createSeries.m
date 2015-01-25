function series = createSeries(expertTimes,volatility);

% createSeries takes a matrix expertTimes where line i contains 1s where
% expert i makes predictions and a vector of volatilities. It outputs a
% matrix of time series: line i contains the time series that expert i sees
% and NaNs after that.

[n m] = size(volatility);

if n~=1
    volatility = volatility';
end

[n m] = size(volatility);

if n~=1
    error('volatility must be a vector');
end

[numExperts T] = size(expertTimes);

if T~=m
    numExperts = numExperts';
end

[numExperts T] = size(expertTimes);

if T~=m
    error('the length of volatility does not match the size of expertTimes');
end

sums = sum(expertTimes,2); % the numbers of elements in experts' domains
longest = max(sums); % the longest series

series = NaN * ones(numExperts,longest); % start with NaN's

for i=1:numExperts
    I = find(expertTimes(i,:)==1);
    series(i,1:length(I)) = volatility(I);
    % we fill the beginning of line i wth the series
end