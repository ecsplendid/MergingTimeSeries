function answer = match(series,preds);

% match checks whether matrixes series and preds contain NaN's at the same
% places.

ind1 = isnan(series);
ind2 = isnan(preds);

answer = (sum(sum((ind1-ind2).^2))==0);