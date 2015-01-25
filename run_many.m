name = 'rts307';

method = 'EWMA';

dirSeparator = '\';
% change depending on the OS

DATA = load([name '.csv']);
% the first line should be removed in advance
% cannot specify comma-separated format in this version of MATLAB
% therefore column 7

[T, k] = size(DATA);
strikes = DATA(:,7);
volatility = DATA(:,10);
competitorPredictions = DATA(:,11)/100;
put = DATA(:,8);

competitorLoss = (competitorPredictions-volatility).^2;
outputFileName = ['.' dirSeparator name  dirSeparator 'competitor.txt'];
save(outputFileName, 'competitorLoss', '-ASCII');

%%%%%%%%%%%%%%%%%%%%
% single filtered and unfiltered

mode = 'single';
include = 'both';

timesInVicinities = [];

for d = 1:5; % the diameter of the vicinity

    expertTypes = [mode '_' include  '_' mat2str(d)];
    
    timesInVicinities = createVicinities(strikes,d);

    % row i of timesInVicinities contains 1s for moment of time where the
    % strike was in vicinity i

    filtered = multiplyVicinitiesByParameter(timesInVicinities,put);
    % each line contains 1s in an expert's domain
    % filtered

    expertTimes = [timesInVicinities; filtered];
   % add unfiltered

  % run_once;
   
end

disp('%%% single filtered and unfiltered done');

%%%%%%%%%%%%%%%%%%%%
% mixtures  filtered and unfiltered

mode = 'mixture';
include = 'both';

timesInVicinities = [];

for d = 1:5; % the diameter of the vicinity

    expertTypes = [mode '_' include  '_' mat2str(d)];
    
    timesInVicinities = [timesInVicinities; createVicinities(strikes,d)];

    % row i of timesInVicinities contains 1s for moment of time where the
    % strike was in vicinity i

    filtered = multiplyVicinitiesByParameter(timesInVicinities,put);
    % each line contains 1s in an expert's domain
    % filtered

    expertTimes = [timesInVicinities; filtered];
   % add unfiltered

   run_once;
   
end

disp('%%% mixtures filtered and unfiltered done');

%%%%%%%%%%%%%%%%%%%%
% mixtures filtered only

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

   run_once;
   
end

disp('%%% mixtures filtered done');

%%%%%%%%%%%%%%%%%%%%
% single unfiltered

mode = 'single';
include = 'unfiltered';

timesInVicinities = [];

for d = 1:5; % the diameter of the vicinity

    expertTypes = [mode '_' include  '_' mat2str(d)];
    
    timesInVicinities = createVicinities(strikes,d);

    % row i of timesInVicinities contains 1s for moment of time where the
    % strike was in vicinity i

    expertTimes = timesInVicinities;
   % add unfiltered

   run_once;
   
end

disp('%%% single unfiltered done');

%%%%%%%%%%%%%%%%%%%%
% mixture unfiltered

mode = 'mixture';
include = 'unfiltered';

timesInVicinities = [];

for d = 1:5; % the diameter of the vicinity

    expertTypes = [mode '_' include  '_' mat2str(d)];
    
    timesInVicinities = [timesInVicinities; createVicinities(strikes,d)];

    % row i of timesInVicinities contains 1s for moment of time where the
    % strike was in vicinity i

    expertTimes = timesInVicinities;
   % add unfiltered

   run_once;
   
end

disp('%%% mixture unfiltered done');