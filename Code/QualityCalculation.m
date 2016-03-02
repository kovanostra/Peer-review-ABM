function [ qualityOfPaper ] = QualityCalculation( scientistLevel, resourcesInvested )
% Calculation of the expected and the real Q score of the papers. Afterwards
% their values are stored to a vector that contains all the scores of all the 
% papers ever submitted.

global  sclContributionToQuality authorBias resourcesContributionToQuality sclParameter resourcesParameter

% Calculates the contribution of the invested resources of the authors in the
% Q score of the papers.
resourcesFactor = resourcesContributionToQuality.*(resourcesParameter*resourcesInvested')./(resourcesParameter.*resourcesInvested' + 1);

% Calculates the contribution of the scientific level of the authors in the
% Q score of the papers.
scientistLevelFactor = sclContributionToQuality.*(sclParameter.*scientistLevel)./(sclParameter.*scientistLevel + 1);

% Calculates the expected Q score of the papers.
expectedQualityOfPaper = scientistLevelFactor + resourcesFactor;
                
% Calculation of the final Q score of the paper, by sampling it from a
% normal distribution. Also stores the score of every submitted paper in
% a relevant vector.
qualityOfPaper = random('normal',expectedQualityOfPaper,expectedQualityOfPaper*authorBias);
end