function output = obliterateLastElement(series);

% obliterateLastElement receives a matrix with time series as lines and
% removeslast elements in every one. Empty series do not change

output = series;

[numSeries T] = size(series);

indexes = repmat(1:T,numSeries,1).*(~isnan(series));

lastElements = max(indexes')';

%lastElements(find(lastElements == T)) = NaN;
lastElements(find(lastElements == 0)) = NaN;

for i = 1:numSeries
    if ~isnan(lastElements(i))
        output(i,lastElements(i)) = NaN;
    end
end
