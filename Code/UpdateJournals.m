function [ scientists, journals, journalsToUpdate, reviewingTime ] = UpdateJournals( scientists, journals, journalsToUpdate, reviewingTime )

tempAccept = journalsToUpdate(:,2) == 0 & (journalsToUpdate(:,4) == 1 | journalsToUpdate(:,4) == 4);
accepted = journalsToUpdate(tempAccept,1);
tempReject = journalsToUpdate(:,2) == 0 & (journalsToUpdate(:,4) == 0 | journalsToUpdate(:,4) == 2 | journalsToUpdate(:,4) == 3);
rejected = journalsToUpdate(tempReject,1);
tempEditor = journalsToUpdate(:,2) == 0 & journalsToUpdate(:,4) == 2;
rejectedInHouse = journalsToUpdate(tempEditor,1);

% Condition for updating at acceptance
for iAcceptance = 1:length(accepted)
    journals(accepted(iAcceptance),5) = journals(accepted(iAcceptance),5) + 1;
end

% Condition for updating at rejection
for iRejection = 1:length(rejected)
    journals(rejected(iRejection),6) = journals(rejected(iRejection),6) + 1;
end

% Condition for updating at in-house rejection
for iInHouse = 1:length(rejectedInHouse)
    journals(rejectedInHouse(iInHouse),8) = journals(rejectedInHouse(iInHouse),8) + 1;
end
    
journals(:,7) = journals(:,5)./(journals(:,5) + journals(:,6));            % Update the journals' acceptance rate
journals(:,9) = journals(:,8)./(journals(:,5) + journals(:,6));            % Update the journals' editorial rejection rate

% Only one round of reviews needed
tempFirstRound = journalsToUpdate(:,2) == 0 & (journalsToUpdate(:,4) == 0 | journalsToUpdate(:,4) == 1);
journal = journalsToUpdate(tempFirstRound,1);
if (isempty(journal) == 0)
    % Find a reviewer of a scientific level that matches to the journal's impact factor
    [ reviewingTime, scientists ] = FindReviewer( scientists, journal, reviewingTime );
end

% A second round of reviews needed
tempSecondRound = journalsToUpdate(:,2) == 0 & (journalsToUpdate(:,4) == 3 | journalsToUpdate(:,4) == 4);
journal = journalsToUpdate(tempSecondRound,1);
if (isempty(journal) == 0)
    % Find a reviewer of a scientific level that matches to the journal's impact factor
    for i = 1:2
        [ reviewingTime, scientists ] = FindReviewer( scientists, journal, reviewingTime );
    end
end

delete = journalsToUpdate(:,2) == 0;
journalsToUpdate(delete,:) = [];

journalsToUpdate(:,2) = journalsToUpdate(:,2) - 1;
end

