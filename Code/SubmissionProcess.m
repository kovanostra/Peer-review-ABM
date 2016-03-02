%% The submission process for each one of the scientists that send their work for publication

% Each week/time step a random population of scientists is selected to invest
% resources and create a paper.
weeklyAuthors = 800;
weeklySubmissions = round(random('normal',weeklyAuthors,0.1.*weeklyAuthors)); 

% Defines the thresholds of the journals relative to the Q scores of the
% papers they expect to be created every year.
[ journals ] = QualityToThreshold( scientists, journals, time, weeksInAYear );

% Finds who is the author and the amount of the resources he/she spends in  
% order to submit a paper.
[ author, authorsScientificLevel, totalResourcesInvested ] = DefineAuthorAndResourcesToSpend( scientists, weeklySubmissions );

% Stores the author of each manuscript.
weekRange = numberOfPapers:numberOfPapers + length(author) - 1;
qualityOfPapers(weekRange,7) = author;

% Subtracts the invested resources from the total resources of a scientist.
scientists(author,2) = scientists(author,2) - totalResourcesInvested';

% Calculation of the expected and the real Q score of the paper. Afterwards 
% this value is stored to a vector that contains all the scores of all the 
% papers ever created.
[ qualityOfPapers(weekRange,1) ] = QualityCalculation( authorsScientificLevel, totalResourcesInvested);

% Definition of whether the author will target journals of high reputation, 
% compared to the quality of the paper, or not. Then the "WhereToSubmit" 
% function matches the paper with the id number of the first journal to be
% submitted.
scientistTargeting = 0.45;
[ qualityOfPapers(weekRange,5) ] = WhereToSubmit( journals, qualityOfPapers(weekRange,1), scientistTargeting );

currentLength = length(journalsToUpdate) + 1;
futureLength = currentLength + length(weekRange) - 1;

% Variable that helps identify papers, journals and scientists. It is
% useful for measuring purposes only and does not play role in the
% procedures of the model. Its values are: 1. Id of the journal to be updated,
%                                          2. In which time step to update, 
%                                          3. Submission attempts until
%                                          this point,
%                                          4. Decision taken for the paper and
%                                          5. The id of the author

journalsToUpdate(currentLength:futureLength,1) = qualityOfPapers(weekRange,5); 
journalsToUpdate(currentLength:futureLength,2) = NaN;                           
journalsToUpdate(currentLength:futureLength,3) = 0;                             
journalsToUpdate(currentLength:futureLength,4) = NaN;                           
journalsToUpdate(currentLength:futureLength,5) = author;                        

% Store the initial amount of resources used for the paper and also its author
resourcesCounter(weekRange,1) = totalResourcesInvested;
resourcesCounter(weekRange,5) = author;

% This will help determining whether a paper will be resubmitted or not.
% ALl papers are resubmitted at least once.
resubmissionProbability = ones(length(weekRange),1);