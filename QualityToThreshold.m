function [ journals ] = QualityToThreshold( scientists, journals, time, weeksInAYear )

global scientistsPopulation journalsPopulation

N = scientistsPopulation;
J = journalsPopulation;

if ( mod(time,weeksInAYear) == 0 )
    
    [ ~, scientistLevel, totalResourcesInvested ] = DefineAuthorAndResourcesToSpend( scientists, N );
    [ sampleQualityOfPapers ] = QualityCalculation( scientistLevel, totalResourcesInvested);

    quantiles = quantile(sampleQualityOfPapers,linspace(0,1,J))';
    quantiles(1) = mean(quantiles(1:2));
    
    raiseThresholdOfTopJournals = zeros(J,1);
    raiseThresholdOfTopJournals(end-20:end,1) = 1;
    noise1 = random('uniform',0.01,0.20,J,1) - sort(random('normal',0.00,0.045,J,1)) + raiseThresholdOfTopJournals(:,1).*sort(random('normal',0.00,0.015,J,1));
    noise2 = noise1 - 0.095;
    
    journals(:,3) = 0.90.*quantiles + noise1;
    journals(:,4) = 1.20.*journals(:,3) + noise2;
    
end 
end