% The submission process for each one of the scientists that send their work for publication
weeklyAuthors = 800;
weeklySubmissions = round(random('normal',weeklyAuthors,0.1.*weeklyAuthors)); 

% Define the thresholds of the journals
[ journals ] = QualityToThreshold( scientists, journals, time, weeksInAYear );

% Finds who is the author and the amount of the resources he spends in order to submit his work
[ author, scientistLevel, totalResourcesInvested ] = DefineAuthorAndResourcesToSpend( scientists, weeklySubmissions );

% Store the author of each manuscript
weekRange = numberOfPapers:numberOfPapers + length(author) - 1;
qualityOfPapers(weekRange,7) = author;

% Subtract the invested resources
scientists(author,2) = scientists(author,2) - totalResourcesInvested';

% Calculation of the expected and the real quality of the paper. Afterwards this value is stored to a vector that 
% contains all the qualities of all the papers ever submitted
[ qualityOfPapers(weekRange,1) ] = QualityCalculation( scientistLevel, totalResourcesInvested);

% Finds in which journal to submit the paper
scientistTargeting = 0.45;
[ qualityOfPapers(weekRange,5) ] = WhereToSubmit( journals, qualityOfPapers(weekRange,1), scientistTargeting );

% Variable that helps identify papers, journals and scientists
currentLength = length(journalsToUpdate) + 1;
futureLength = currentLength + length(weekRange) - 1;

journalsToUpdate(currentLength:futureLength,1) = qualityOfPapers(weekRange,5);  % Journal to update
journalsToUpdate(currentLength:futureLength,2) = NaN;                           % Time step to update
journalsToUpdate(currentLength:futureLength,3) = 0;                             % Submission attempts until this point
journalsToUpdate(currentLength:futureLength,4) = NaN;                           % Accepted or rejected
journalsToUpdate(currentLength:futureLength,5) = author;                        % Authors

% Store the initial amount of resources used for the paper and also its author
resourcesCounter(weekRange,1) = totalResourcesInvested;
resourcesCounter(weekRange,5) = author;

% This will check whether there will be resubmissions or not
resubmissionProbability = ones(length(weekRange),1);