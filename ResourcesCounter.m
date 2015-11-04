function [ resourcesCounter ] = ResourcesCounter( resourcesCounter, totalResourcesInvested, qualityOfPapers, weekRange)
% Here we update the resources' related tracking metric
extraResourcesInvested = (resourcesCounter(weekRange,2) - resourcesCounter(weekRange,1));
timeUntilPublication = qualityOfPapers(weekRange,6);
resourcesCounter(weekRange,[2 3 4]) = [totalResourcesInvested' ...
                                      extraResourcesInvested./totalResourcesInvested' ...
                                      extraResourcesInvested./timeUntilPublication];
end

