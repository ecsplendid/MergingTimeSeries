function plotSome( );

dirSeparator = '\';
% change depending on the OS

figure(1);
hold on;

name = 'eeru1206';

fileName = ['.' dirSeparator name dirSeparator 'competitor.txt'];
competitorLoss = load(fileName);

method = 'EWMA';

mode = 'mixture';
include = 'filtered';

d = 5;

graphs = [];
labels = [];

expertTypes = [mode '_' include  '_' mat2str(d)];

fileName = ['.' dirSeparator name  dirSeparator method dirSeparator expertTypes '.txt'];
mixtureLoss = load(fileName);

cumLoss = cumsum(mixtureLoss-competitorLoss);
graphs = [graphs cumLoss];
    
labels = strvcat(labels, [' diameter ' mat2str(d) '; total loss (adjusted): ' mat2str(cumLoss(end))]);

%%%%%%%%%%%%%%%%%%%%%%

mode = 'mixture';
include = 'filtered';

d=5;

expertTypes = [mode '_' include  '_' mat2str(d)];

fileName = ['.' dirSeparator name  dirSeparator method dirSeparator expertTypes '.txt'];
mixtureLoss = load(fileName);

cumLoss = cumsum(mixtureLoss-competitorLoss);
graphs = [graphs cumLoss];
    
labels = strvcat(labels, [' diameter ' mat2str(d) '; total loss (adjusted): ' mat2str(cumLoss(end))]);

%%%%%%%%%%%%%%%%%

plot(graphs);
legend(labels);

grid on;

titleBar = ['Dataset: ' name '.   Method: ' method '.   Mode: ' mode '.   Included: ' include '.  Competitor: ' mat2str(sum(competitorLoss)) ]

title(titleBar);
