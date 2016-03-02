function [ resourcesCounter ] = ResourcesCounter( resourcesCounter, totalResourcesInvested, qualityOfPapers, weekRange)
% Here we update the resources related tracking metric

extraResourcesInvested = (resourcesCounter(weekRange,2) - resourcesCounter(weekRange,1));
timeUntilPublication = qualityOfPapers(weekRange,6);

% The resources counter is defined by five values: 1. The initial resources invested, 
%                                                  2. The total extra resources invested, 
%                                                  3. The percentage of the extra to the initial resources, 
%                                                  4. The extra resources per week to be invested and
%                                                  5. The id of the author
resourcesCounter(weekRange,[2 3 4]) = [totalResourcesInvested' ...
                                      extraResourcesInvested./totalResourcesInvested' ...
                                      extraResourcesInvested./timeUntilPublication];
end

