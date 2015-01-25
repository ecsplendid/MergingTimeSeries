function predictions = putPredictionsInPlace(expertTimes,preds);

% putPredictionsInPlace put experts' preds where axpertTimes equal 1

[numExperts T] = size(expertTimes);

[n numInSeries] = size(preds);

if numExperts~=n
    error('the numbers of experts do not match');
end

ind = ~isnan(preds);
lastElementNums = max((repmat(1:numInSeries,numExperts,1).*ind)')';
% numbers of predictions for each time series

if (sum(expertTimes,2)-lastElementNums).^2~=0
    error('number of predictions does not match the number of positions')
end

predictions = NaN * ones(size(expertTimes));

for i=1:numExperts
    numPreds = lastElementNums(i);    
    predictions(i,expertTimes(i,:)==1) = preds(i,1:numPreds);
end
