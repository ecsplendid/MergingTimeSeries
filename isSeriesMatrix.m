function answer = isSeriesMatrix(series);

% isSeriesMatrix checks whether series is a well-formed matrix of time
% series, i.e., each line has the form x1 x2 ... xk NaN ... NaN

[num T] = size(series);

% the function checks whether the number of the last non-NaN element equals
% the number of non-NaN elements

ind = ~isnan(series);

lastElementsNum = max((repmat(1:T,num,1).*ind)')';

sums = lastElementsNum-sum(ind,2);

answer = (sum(sum(sums.^2)) == 0);
