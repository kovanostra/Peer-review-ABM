% This function checks whether the paper is accepted or rejected. If it is
% rejected then there is a probability to be resubmitted to the same or to
% another journal. This probability gets lower and lower as the number of
% resubmission attempts increases. At the end, papers that fail to be
% resubmitted they get abandoned and never published.

r = rand(length(resubmissionProbability),1);

% The probability for a paper to be resubmitted
resubmitted = resubmissionProbability ~= 0;
resubmissionProbability(resubmitted) = (0.88).^(papers.resubmissions(resubmitted));

resubmission = (decision.reviewer == 0 & r <= resubmissionProbability);
giveUp = (r > resubmissionProbability & resubmissionProbability > 0);
accepted = (decision.reviewer == 1 & resubmissionProbability > 0);

%% Update the resubmission attempts
percentage = papers.percentage;
firstQuality = papers.firstQuality;
improvedQuality = papers.improvedQuality;
resubmissions = papers.resubmissions;
journal = papers.journal;
name = authors.name;
resources = authors.resources;
level = authors.level;
newJournals = find(isnan(journalsToUpdate(:,2)) == 1);

for iResubmission = 1:length(resubmissionProbability)

    if (resubmission(iResubmission) == 1)
        % This procedure finds the papers that are eligible for
        % resubmission, updates their quality if they were peer reviewed
        % before being rejected and submits them to a new journal.
        resubmissions(iResubmission) = resubmissions(iResubmission) + 1;
        [ resources(iResubmission), percentage(iResubmission), improvedQuality(iResubmission), journal(iResubmission), ... 
            totalResourcesInvested(iResubmission) ] = UpdateForResubmission( journals, resources(iResubmission), ...
            level(iResubmission), firstQuality(iResubmission), totalResourcesInvested(iResubmission), decision.joint(iResubmission));   

        notUpdated0 = find(journalsToUpdate(newJournals(1):end,3) >= 1);
        rejectedAuthor = find(journalsToUpdate(notUpdated0:end,5) == name(iResubmission));
        if ( isempty(notUpdated0) == 0 && isempty(rejectedAuthor) == 0)
            journalsToUpdate(notUpdated0(1) + rejectedAuthor(end) - 1,4) = decision.joint(iResubmission);
        end

        newLength = length(journalsToUpdate) + 1;
        journalsToUpdate(newLength,:) = [ journal(iResubmission) NaN resubmissions(iResubmission) NaN name(iResubmission) ];

    elseif (giveUp(iResubmission) == 1)
        % This  procedure finds the papers that will be abandoned and never 
        % get published.
        notUpdated1 = find(journalsToUpdate(newJournals(1):end,3) >= 1);
        rejectedAuthor = find(journalsToUpdate(notUpdated1:end,5) == name(iResubmission));
        journalsToUpdate(notUpdated1(1) + rejectedAuthor(end) - 1,4) = decision.joint(iResubmission); 

        % Papers that will not be resubmitted.
        resubmissionProbability(iResubmission) = 0;
    elseif (accepted(iResubmission) == 1)
        % THis procedure finds the papers that were accepted and thus not
        % going to be resubmitted.
        notUpdated2 = find(journalsToUpdate(newJournals(1):end,3) >= 1);
        acceptedAuthor = find(journalsToUpdate(notUpdated2:end,5) == name(iResubmission));
        journalsToUpdate(notUpdated2(1) + acceptedAuthor(end) - 1,4) = decision.joint(iResubmission);     
        
        % Papers that will not be resubmitted.
        resubmissionProbability(iResubmission) = 0;
    end
end

authors.resources = resources;
authors.level = level;
papers.firstQuality = firstQuality;
papers.improvedQuality = improvedQuality;
papers.percentage = percentage;
papers.resubmissions = resubmissions;
papers.journal= journal;