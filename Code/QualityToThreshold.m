function [ journals ] = QualityToThreshold( scientists, journals, time, weeksInAYear )
% This function connects the thresholds of the journals to the quality of
% all the potentially produced manuscripts. The thresholds are (re)calculated
% every year. 
% 
% For calculating them we first define the random amount of resources that 
% every scientist would use to create a paper if he/she was selected to do 
% so. Then we calculate the the quality for all of them and created the
% potential distribution of papers.
% 
% Scientists do not really create papers. The puprose of this procedure
% is to obtain a distribution that shows what journals expect to be the
% Q scores of produced papers in general for that time period. 

global scientistsPopulation journalsPopulation

N = scientistsPopulation;
J = journalsPopulation;

if ( mod(time,weeksInAYear) == 0 )
    
    % Identifying the eligible authors (R > 1), the resources they will spend 
    % and the Q scores of papers that would hypothetically be created.
    [ ~, scientistLevel, totalResourcesInvested ] = DefineAuthorAndResourcesToSpend( scientists, N );
    [ sampleQualityOfPapers ] = QualityCalculation( scientistLevel, totalResourcesInvested);

    % We split the distribution of Q scores into equal parts and select the
    % first value from each part. For the first quantile, because the first
    % value is very low, we select the average between the first and the
    % second quantile.
    quantiles = quantile(sampleQualityOfPapers,linspace(0,1,J))';
    quantiles(1) = mean(quantiles(1:2));
    
    % We create a level of noise that will create thresholds, which will
    % produce the desired distributions of acceptance and desk-rejection
    % rates.
    raiseThresholdOfTopJournals = zeros(J,1);
    raiseThresholdOfTopJournals(end-20:end,1) = 1;
    noise1 = random('uniform',0.01,0.20,J,1) - sort(random('normal',0.00,0.045,J,1)) + raiseThresholdOfTopJournals(:,1).*sort(random('normal',0.00,0.015,J,1));
    noise2 = noise1 - 0.095;
    
    % Here we set the value of the thresholds connected to the quantiles of
    % the Q score distribution and to the noise.
    journals(:,3) = 0.90.*quantiles + noise1;
    journals(:,4) = 1.20.*journals(:,3) + noise2;
    
end 
end