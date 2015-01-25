function gamma = mixSleeping(expertsPredictions,outcomes,A,B);

% mixSleeping(expertPredictions,outcomes,A,B) merges expertsPredictions
% with weights in the square-loss game on [A, B] with the exponential
% learning rate beta
% the substitution formula gamma = (g(B)-g(A))/(2(B-A))+(B+A)/2 is used

% alternative
% function [gamma, allWeights] = mixSleeping(expertsPredictions,outcomes,A,B);

if A>B
    C = B;
    B = A;
    A =C;
end

[numExperts T] = size(expertsPredictions);

eta = 2/(B-A)^2;

weights = ones(numExperts,1);

weights = weights/sum(weights);

%allWeights = weights;

for t=1:T
    
    awake = ~isnan(expertsPredictions(:,t));
    
    numAwake = length(awake);
    
    if numAwake == 0
        
        gamma(t) = 0.3; % default value
        
    else
         
        predictionsAwake = expertsPredictions(awake,t);
        weightsAwake = weights(awake);
    
        lossesB = (predictionsAwake - B).^2;
        lossesA = (predictionsAwake - A).^2;

        gB = -log(sum(exp(-eta*lossesB).*weightsAwake)/sum(weightsAwake))/eta;
        gA = -log(sum(exp(-eta*lossesA).*weightsAwake)/sum(weightsAwake))/eta;

        gamma(t) = (gA-gB)/(2*(B-A))+(B+A)/2;
    
        lossMixture = (outcomes(t) - gamma(t))^2;
        weightsUpdate = ones(numExperts,1)*exp(-eta*lossMixture);
    
        lossAwake = (predictionsAwake-outcomes(t)).^2;
        weightsUpdate(awake) = exp(-eta*lossAwake);
    
        weights = weights.*weightsUpdate;
        weights = weights/sum(weights);
   
        %allWeights = [allWeights weights];
    end
end


    