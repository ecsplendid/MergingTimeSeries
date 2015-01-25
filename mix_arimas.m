% requires:
% series, expertTimes, volatility, competitorPredictions
% name, expertTypes


mode = 'mixture';
include = 'filtered';

timesInVicinities = [];

for d = 1:5; % the diameter of the vicinity

    expertTypes = [mode '_' include  '_' mat2str(d)];
    
    timesInVicinities = [timesInVicinities; createVicinities(strikes,d)];

    % row i of timesInVicinities contains 1s for moment of time where the
    % strike was in vicinity i

    filtered = multiplyVicinitiesByParameter(timesInVicinities,put);
    % each line contains 1s in an expert's domain
    % filtered

    expertTimes = filtered;
   % add unfiltered

end


pred_series = load('.\rts307\arima\mixture_filtered_5_preds_withnaive.txt');

method = 'arima';

expertsPredictions = putPredictionsInPlace( expertTimes, pred_series );

outcomes = volatility;

%[mixturePredictions weights] = mixSleeping(expertsPredictions,outcomes,0,1);
mixturePredictions = mixSleeping(expertsPredictions,outcomes,0,1);

mixtureLoss = (mixturePredictions' - outcomes).^2;

competitorLoss = (competitorPredictions - outcomes).^2;

outputFileName = ['.' dirSeparator name  dirSeparator method dirSeparator expertTypes '.txt'];
save(outputFileName, 'mixtureLoss', '-ASCII');