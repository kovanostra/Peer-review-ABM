function [ authors, authorsScientificLevel, resourcesInvested ] = DefineAuthorAndResourcesToSpend( scientists, weeklySubmissions )
% Here we define the id number of authors that are randomly selected to
% create papers. However, not all from those selected can submit. Only
% those that have resources higher than 1 will be able to create papers.
% The rest should wait until they obtain more before submitting at a
% later round if they get selected again.

authors = randperm(length(scientists),weeklySubmissions);                  

willNotSubmit = find(scientists(authors,2) <= 1);                          
authors(willNotSubmit==0) = [];

% The discount factor represents the percentage of resources an author will
% spend on the paper. This amount will immediately be subtracted from the
% author's total resources at the time of submission. However, that will not 
% affect his/her scientific level. Scientific level changes only after the 
%last decision of a paper.
discountFactor = random('uniform',0.2,0.7,length(authors),1);              
authorsScientificLevel = scientists(authors,4);                                    
resourcesInvested = (discountFactor.*scientists(authors,2))';              
end

