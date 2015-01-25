function plotAll( );
%%
dirSeparator = '\';
% change depending on the OS

figure(1);
clf
hold on;

name = 'rts307';

fileName = ['.' dirSeparator name dirSeparator 'competitor.txt'];
competitorLoss = load(fileName);

graphs = [];
labels = [];

method = 'EWMA';

mode = 'mixture';
include = 'filtered';

dias = [1 5]

for i = 1:length(dias)
    
    d = dias(i)
    
    expertTypes = [mode '_' include  '_' mat2str(d)];
    
    fileName = ['.' dirSeparator name  dirSeparator method dirSeparator expertTypes '.txt'];

    mixtureLoss = load(fileName);

    cumLoss = cumsum(mixtureLoss-competitorLoss);
    graphs = [graphs cumLoss];
    labels = strvcat(labels, [ method ' diameter ' mat2str(d) '; total loss (adjusted): ' mat2str(cumLoss(end))]);
    
end



% get rr plot

rr = ['D:\Papers\Region Experts 1\StrikePriceExperts\slidingridge\results\rr_'  name '_win250_relevantlosses.txt' ];
rr_preds = load(rr);

plot(graphs(:,1),'k:','LineWidth',2)
plot(graphs(:,2),'k','LineWidth',2)

plot(cumsum(rr_preds),'k--','LineWidth',3)


expertTypes = ['mixture' '_' include  '_' mat2str(5)];
fileName = ['.' dirSeparator name  dirSeparator 'arima' dirSeparator expertTypes '.txt'];

    %mixtureLoss = load(fileName);

  %  cumLoss = cumsum(mixtureLoss-competitorLoss);
%plot(cumLoss,'k','LineWidth',1)

%,'ARIMA Diameters 1 to 5'

legend({'EWMA Naive Algorithm','EWMA Diameters 1 to 5','Sliding Kernel Ridge Regression'});

grid on;
title(titleBar);
titleBar = ['Dataset: ' name '.   Method: ' method '.   Mode: ' mode '.   Included: ' include '.  Competitor: ' mat2str(sum(competitorLoss)) ]
axis square

sum(rr_preds)

title('')

%print -depsc2 eeru1206.eps



%%

titleBar = ['Dataset: ' name '.   Method: mixed.   Mode: ' mode '.   Included: ' include '.  Competitor: ' mat2str(sum(competitorLoss)) ]

title(titleBar);