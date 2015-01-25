function predictions = predictMostRecent(series,prior);

% predictMostRecent receives a matrix consisting of lines of time series
% and outputs the matrix of predictions by the most recent element

if ~isSeriesMatrix(series)
    series = series'
end

if ~isSeriesMatrix(series)
    error('The input is not a matrix of time series');
end

series2 = truncate(series,0,1);
% everything outside [0,1] is treted as an outlier and reduced to [0,1]

series3 = obliterateLastElement(series2);
% the last element in every series is not predicting anything

column1 = series3(:,1);
column1(find(~isnan(column1))) = prior;
% predictions are made only for non-empty series

predictions = [column1 series3(:,1:(end-1))];
