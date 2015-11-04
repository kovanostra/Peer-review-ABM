function [ qualityEvaluated ] = Evaluation( journal, qualityOfPaper )
global competitiveProbability  impactFactorsReverse

rTimeError = rand(length(qualityOfPaper),1);
rCompetitive = competitiveProbability(journal)';
rCompetitiveHelp = rand(length(qualityOfPaper),1);

errorFactor = zeros(length(qualityOfPaper),1);
competitive = zeros(length(qualityOfPaper),1);

%% Define error factor
% Reviewing time error
errorFactor(rTimeError <= 0.65) = 0.1;
errorFactor(rTimeError > 0.65 & rTimeError <= 0.87) = 0.05;
errorFactor(rTimeError > 0.87) = 0.01;

% Journal error
reverseIF = impactFactorsReverse;
errorFactor = errorFactor + 0.15.*reverseIF(journal);

% Quality error
errorFactor = errorFactor - 0.05.*qualityOfPaper';

% Competitive
competitiveWrath = random('uniform',0.01,0.05,length(qualityOfPaper),1);
competitive(rCompetitiveHelp >= rCompetitive) = competitiveWrath(rCompetitiveHelp >= rCompetitive);

% Evaluation
evaluationMean = qualityOfPaper - competitive';
errorFactor(errorFactor < 0) = 0;
evaluationSTD = qualityOfPaper.*errorFactor';
qualityEvaluated = random('normal',evaluationMean, evaluationSTD); 
end