function predictions = predictEWMA(series,lambda,prior);

% predictEWMA receives a matrix consisting of lines of time series
% and outputs the matrix of predictions obtained by EWMA

if ~isSeriesMatrix(series)
    series = series';
end

if ~isSeriesMatrix(series)
    error('The input is not a matrix of time series');
end

[numSeries T] = size(series);

series2 = truncate(series,0,1);

series3 = obliterateLastElement(series2);
% the last element in every series is not predicting anything

column1 = series3(:,1);
column1(find(~isnan(column1))) = prior;
% predictions are made only for non-empty series

predictions = column1;

for i=1:(T-1)
    predictions = [predictions, (1 - lambda) * predictions(:,end) + lambda * series3(:,i)];
end


