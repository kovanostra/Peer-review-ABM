function [ resources, percentage, improvedQuality, journal, totalResourcesInvested ] = UpdateForResubmission( journals, resources, level, ...
    firstQuality, totalResourcesInvested, decision )
%% Will search for another journal based on the quality of the manuscript before aking corrections
reductedQuality = 0.68.*firstQuality;
scientistTargeting = 0.50;

[ journal ] = WhereToSubmit( journals, reductedQuality, scientistTargeting);
%% Update the quality of the paper because of the reviewers' comments
remainingResources = (resources - totalResourcesInvested');
if (decision ~= 2)
    % Update the manuscript because of peer review before rejection
    discountFactor = random('normal',20/60,2/60,length(resources),1);
else
    % Minor update to the manuscript because of rejection withtout peer review
    discountFactor = random('normal',1/60,0.1/60,length(resources),1);
end
totalResourcesInvested = totalResourcesInvested' + discountFactor.*remainingResources;
[ improvedQuality ] = QualityCalculation( level', totalResourcesInvested);
percentage = (improvedQuality' - firstQuality)./firstQuality;

end