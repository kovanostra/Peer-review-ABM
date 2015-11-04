function [ authors, scientistLevel, resourcesInvested ] = DefineAuthorAndResourcesToSpend( scientists, weeklySubmissions )
% Defines the index of the author who submits his work 
% and the amount of the resources he invests to it
authors = randperm(length(scientists),weeklySubmissions);                  % The authors that submit their work

willNotSubmit = find(scientists(authors,2) <= 1);                          % Finds authors with resources less than 1 and excludes them from the submission process
authors(willNotSubmit==0) = [];

discountFactor = random('uniform',0.2,0.7,length(authors),1);              % The percentage of their resources that is discounted for the submission
scientistLevel = scientists(authors,4);                                    % The authors' scientific level
resourcesInvested = (discountFactor.*scientists(authors,2))';              % The amount of their invested resources
end

