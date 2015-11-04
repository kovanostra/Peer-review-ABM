% Here the journal based on the evaluation that the referees submit defines
% whether the paper gets accepted or not. There is also an 80% probability
% that the paper gets rejected by the editor if it does not fullfil the
% journal's requirements.
global noEditorialScreening


% The specific journal that the paper is submitted 
journal = papers.journal;
submissions = length(journal);

% Fix paper's quality if there has been an improvement
[ finalQuality ] = Index( papers, resubmissionProbability );

decision.reviewer = zeros(length(finalQuality),1);
decision.joint = zeros(length(finalQuality),1);
qualityEvaluated  = zeros(length(finalQuality),1);

%% Editorial phase
editorsEvaluation = random('uniform',0.90.*finalQuality',1.10.*finalQuality');
lowThresholdsOfJournals = journals(journal,3);
highThresholdOfJournals = journals(journal,4);

inHouseStricktness = random('uniform',0.00,0.80,length(finalQuality),1);
inHouseRejectionProbability = journal./105;

editorialRejection = (editorsEvaluation < lowThresholdsOfJournals) & (inHouseStricktness < inHouseRejectionProbability);

for iNoScreening = 1:submissions
    if (isempty(find(journal(iNoScreening) == noEditorialScreening, 1)) == 0)
        editorialRejection(iNoScreening) = 0;
    end
end

%% First round of reviews
firstRound = (editorialRejection == 0) & (resubmissionProbability > 0);

% Reviewer evaluates the paper's quality
[ qualityEvaluated(firstRound == 1) ] = Evaluation( journal(firstRound == 1), finalQuality(firstRound == 1) );

% Accepted immediately
accepted = [];
accepted = (qualityEvaluated >= highThresholdOfJournals) & decision.reviewer == 0;
decision.reviewer(accepted == 1) = 1;

%% Second round of reviews
secondRound = zeros(length(firstRound),1);

% Defining the papers that go to the second round of reviews
revisionsRequired  = (firstRound == 1) & (qualityEvaluated >= lowThresholdsOfJournals) & (decision.reviewer == 0);
secondRound(revisionsRequired) = 1;

% Updating the quality of the papers due to the first round of reviews
[ authors.resources(secondRound == 1), papers.percentage(secondRound == 1), papers.improvedQuality(secondRound == 1), ... 
    totalResourcesInvested(secondRound == 1) ] = UpdateOfQuality( authors.resources(secondRound == 1), ...
    authors.level(secondRound == 1), papers.firstQuality(secondRound == 1), totalResourcesInvested(secondRound == 1));       

% Second evaluation of the papers
[ qualityEvaluated(secondRound == 1) ] = Evaluation( journal(secondRound == 1), papers.improvedQuality(secondRound == 1)' );

% Accepted at the second round
acceptedWithRevisions = [];
acceptedWithRevisions = (qualityEvaluated >= highThresholdOfJournals) & secondRound == 1;
decision.reviewer(acceptedWithRevisions == 1) = 1;

%% Collection of the decisions for all the papers
decision.joint(secondRound == 1) = decision.reviewer(secondRound == 1) + 3;
decision.joint(secondRound == 0 & firstRound == 1) = decision.reviewer(secondRound == 0  & firstRound == 1);
decision.joint(editorialRejection == 1 & (resubmissionProbability > 0)) = 2;