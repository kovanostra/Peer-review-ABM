function [ resources, percentage, improvedQuality, totalResourcesInvested ] = UpdateOfQuality( resources, level, firstQuality, totalResourcesInvested )

%% Update the quality of the paper because of the reviewers' comments

discountFactor = random('normal',8/60,1/60,length(resources),1);
remainingResources = (resources - totalResourcesInvested');
totalResourcesInvested = totalResourcesInvested' + discountFactor.*remainingResources;

[ improvedQuality ] = QualityCalculation( level', totalResourcesInvested);
percentage = (improvedQuality' - firstQuality)./firstQuality;
end