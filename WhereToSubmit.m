function [ journalToSubmit ] = WhereToSubmit( journals, qualityOfPaper, percentage )
% Selects a journal, inside an appropriate range of reputations, in order 
% for the author to submit the paper.

global journalsPopulation

journalToSubmit = zeros(length(qualityOfPaper),1);

% Definition of the length of the range of the journals that are candidates
% for the submition of the paper. We also add small amount of noise to the
% min and max values of that range.
submissionRangeLength = 2.*abs(random('normal',qualityOfPaper/5,qualityOfPaper/20));
noiceInThePercentage = random('normal',percentage,0.01);

minRange = qualityOfPaper - noiceInThePercentage.*submissionRangeLength;
maxRange = qualityOfPaper - (1 - noiceInThePercentage).*submissionRangeLength;

lowThresholdsOfJournals = journals(:,3);
J = journalsPopulation;

for iJournals = 1:length(qualityOfPaper)
    % Journals with threshold higher than qualityOfPaper - minRange
    lowestJournalToSubmit = find(lowThresholdsOfJournals >= minRange(iJournals),1,'first');
    lowestJournalAbsence = isempty(lowestJournalToSubmit);

    % Journals with threshold lower than qualityOfPaper + maxRange
    highestJournalToSubmit = find(lowThresholdsOfJournals <= maxRange(iJournals),1,'last');
    highestJournalAbsence = isempty(highestJournalToSubmit);
    
    if (lowestJournalAbsence == 0) && (highestJournalAbsence == 0) && (lowestJournalToSubmit <= highestJournalToSubmit)
        % Selects randomly a journal inside the required range
        index = randi([lowestJournalToSubmit,highestJournalToSubmit]);
        journalToSubmit(iJournals) = index;       
    elseif (lowestJournalAbsence == 0) && (highestJournalAbsence == 0) && (lowestJournalToSubmit > highestJournalToSubmit)
        index = datasample([lowestJournalToSubmit highestJournalToSubmit],1);
        journalToSubmit(iJournals) = index;
    elseif (highestJournalAbsence == 1)
        % This case is valid only if the paper is of extremely low quality, so
        % the author submits it only to the lowest ranked journals
        journalToSubmit(iJournals) = randi([1, 10]);
    elseif (lowestJournalAbsence == 1)
        % This case is valid only if the paper is of extraordinary quality, so
        % the author submits it only to the highest ranked journals
        journalToSubmit(iJournals) = randi([J-10, J]);
    end
end

end

