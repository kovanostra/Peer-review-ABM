%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SIMULATION OF THE TRADITIONAL PEER REVIEW SYSTEM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                                   %% MAIN PART %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clc;
% Initialise the constants of the simulation
InitialiseConstantsAndGlobals

while (iTime <= time)  
    iTime
    tic,
    %% The submission process
    SubmissionProcess
    
    %% The whole peer review and publication process
    ThePeerReviewProcess

    %% Finalising calculations
    numberOfPapers = numberOfPapers + length(weekRange);

    % Resources counter variables.
    [ resourcesCounter ] = ResourcesCounter( resourcesCounter, totalResourcesInvested, qualityOfPapers, weekRange);

    % Update of the per-time step and of the cummulative scientific 
    % information that is released to the system.
    [ scientists, qualityOfPapers, totalScientificInformation(iTime), publishedQuality, resourcesCounter ] = ScientificInformation( scientists, journals, ...  
        qualityOfPapers, numberOfPapers, publishedQuality, resourcesCounter );
    
    % Update of the scientific's community level due to the new
    % publications.
    [ scientists, cummulativeScientificInformation ] = UpdateTheScientificCommunity( scientists, totalScientificInformation, publishedQuality, iTime );

    % Update of the time that papers need in order to be published.
    qualityOfPapers(1:numberOfPapers - 1,6) = qualityOfPapers(1:numberOfPapers - 1,6) - 1;
    
    % Update acceptance rates
    [ scientists, journals, journalsToUpdate, reviewingTime ] = UpdateJournals( scientists, journals, journalsToUpdate, reviewingTime );

    % Calculation of yearly time spent in peer review and of the yearly
    % amount of published papers.
    if (mod(iTime,weeksInAYear) == 0)
        yearIndex = iTime/weeksInAYear;
        yearlyTimeSpentForReviewing(yearIndex) = sum(reviewingTime);
        finalDecisions = find(qualityOfPapers(1:numberOfPapers - 1,6) < 0);
        publishedPapers = find(mod(qualityOfPapers(finalDecisions,6),1) == 0);
        yearlyPublishedPapers(yearIndex) = length(publishedPapers);
    end
    
    % After the burn-in period of one year, the system is reinitialised.
    Reinitialise
    
    % Update the time
    iTime = iTime + 1;  
    toc
end
%% Cleaning some outputs and producing the final results and plots
Results
