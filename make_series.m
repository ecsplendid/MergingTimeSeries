name = 'rts307';

DATA = load([name '.csv']);
% the first line should be removed in advance
% cannot specify comma-separated format in this version of MATLAB
% therefore column 7

[T, k] = size(DATA);

strikes = DATA(:,7);

timesInVicinities = [];

expertTypes = 'single_filtered_1';

expertTypesAlt = 'mixture_filtered_5';

for d = 1:1; % the diameter of the vicinity

    timesInVicinities = [timesInVicinities; createVicinities(strikes,d)];

    % row i of timesInVicinities contains 1s for moment of time where the
    % strike was in vicinity i
end
    
put = DATA(:,8);

expertTimes = multiplyVicinitiesByParameter(timesInVicinities,put);
% each line contains 1s in an expert's domain

expertTimes = expertTimes;;

volatility = DATA(:,10);

series = createSeries(expertTimes, volatility);
% contain the series for experts

fileName = ['series_' name '_' expertTypes '.txt'];

save(fileName, 'series', '-ASCII');

% outputFileName = [name '_series.txt'];
% save(outputFileName, 'series', '-ASCII');
 
% preds = predictMostRecent(series,0.3);
% method = 'last';

% importedName = ['routput_series_' expertTypes '.txt'];
% preds = load(importedName);
% method = 'arima';
% 
% % outputFileName = [name '_preds.txt'];
% % save(outputFileName, 'preds', '-ASCII');
% 
% if ~match(series,preds)
%     error('matrixes of series and predictions do not match');
% end
% 
% expertsPredictions = putPredictionsInPlace(expertTimes,preds);
% 
% % outputFileName = [name '_experts_predictions.txt'];
% % save(outputFileName, 'expertsPredictions', '-ASCII');
% 
% outcomes = volatility;
% 
% %[mixturePredictions weights] = mixSleeping(expertsPredictions,outcomes,0,1);
% mixturePredictions = mixSleeping(expertsPredictions,outcomes,0,1);
% 
% mixtureLoss = (mixturePredictions' - outcomes).^2;
% 
% competitorPredictions = DATA(:,11)/100;
% competitorLoss = (competitorPredictions - outcomes).^2;
% 
% % plot(mixtureLoss,'r');
% % hold on;
% % plot(competitorLoss,'b'); 
% % 
% % legend('Mixture loss','RTSSE loss');
% % 
% % lossd5 = mixtureLoss;
% 
% outputFileName = ['.\'  name  '\' method '\' expertTypesAlt '.txt'];
% save(outputFileName, 'mixtureLoss', '-ASCII');
