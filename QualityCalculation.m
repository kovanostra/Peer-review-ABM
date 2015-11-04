function [ qualityOfPaper ] = QualityCalculation( scientistLevel, resourcesInvested )
% Calculation of the expected and the real quality of the
% papers. Afterwards their values are stored to a vector that 
% contains all the qualities of all the papers ever submitted

global  sclContributionToQuality authorBias resourcesContributionToQuality sclParameter resourcesParameter

% Calculates the contribution of the invested resources of the authors in the
% quality of the papers
resourcesFactor = resourcesContributionToQuality.*(resourcesParameter*resourcesInvested')./(resourcesParameter.*resourcesInvested' + 1);

% Calculates the contribution of the scientific level of the authors in the
% quality of the papers
scientistLevelFactor = sclContributionToQuality.*(sclParameter.*scientistLevel)./(sclParameter.*scientistLevel + 1);

% Calculates the estimated quality of the papers
expectedQualityOfPaper = scientistLevelFactor + resourcesFactor;
                
% Finds what is the actual quality of the paper by sampling it from a
% normal distribution. Also stores the quality of every submitted paper in
% a relevant vector
qualityOfPaper = random('normal',expectedQualityOfPaper,expectedQualityOfPaper*authorBias);


end