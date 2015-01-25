% requires:
% series, expertTimes, volatility, competitorPredictions
% name, expertTypes


series = createSeries(expertTimes, volatility);
% contain the series for experts

if strcmpi(method, 'last')
    preds = predictMostRecent(series,0.3);
end
if strcmpi(method, 'EWMA')
    preds = predictEWMA(series,0.95,0.3);
end

if ~match(series,preds)
    error('matrixes of series and predictions do not match');
end

expertsPredictions = putPredictionsInPlace(expertTimes,preds);

outcomes = volatility;

%[mixturePredictions weights] = mixSleeping(expertsPredictions,outcomes,0,1);
mixturePredictions = mixSleeping(expertsPredictions,outcomes,0,1);

mixtureLoss = (mixturePredictions' - outcomes).^2;

competitorLoss = (competitorPredictions - outcomes).^2;

outputFileName = ['.' dirSeparator name  dirSeparator method dirSeparator expertTypes '.txt'];
save(outputFileName, 'mixtureLoss', '-ASCII');