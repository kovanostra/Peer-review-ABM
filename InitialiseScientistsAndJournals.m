function [ scientists, journals ] = InitialiseScientistsAndJournals( )
% Initialisation of the scientists and the journals
global scientistsPopulation journalsPopulation impactFactorsReverse 

%% Scientists
% The population of the scientists is an independent variable that we need
% to define each time.
scientistsPopulation = 25000;                                                                                                                                        
N = scientistsPopulation;

% Initialise papers per scientist as in Mulligan supplimentary material p.57
r = rand(1,N);
initialPublications = zeros(1,N);
parfor iScientist = 1:N
    if (r(iScientist) <= 0.14)
        initialPublications(iScientist) = randi([1,5]);
    elseif (r(iScientist) <= 0.27)
        initialPublications(iScientist) = randi([6,10]);
    elseif (r(iScientist) <= 0.45)
        initialPublications(iScientist) = randi([11,20]);
    elseif (r(iScientist) <= 0.71)
        initialPublications(iScientist) = randi([21,50]);
    elseif (r(iScientist) <= 0.89)
        initialPublications(iScientist) = randi([51,100]);
    else
        initialPublications(iScientist) = randi([100,200]);
    end
end

% Here we connect the resurces of the scientists with their publications to
% date. It comes as the equation resources = a*publications, where a is
% randomly drawn from a uniform distribution.

initialResources = initialPublications.*random('uniform',0.1,3,1,N);

% The scientific level of scientists is defined as the sum of their
% resources and publications.
initialScientificLevel = initialResources + initialPublications;

% Scientists are defined by four values: 1. Their id number, 
%                                        2. Their resources, 
%                                        3. Their publications to date and 
%                                        4. Their scientific level.
scientists = [(1:N);...
              (initialResources);...
              (initialPublications);...
              (initialScientificLevel)]';

%% Journals
% Here we load the impact factors of the journals standardised to unity and
% from that we define each time the population of the journals.
load('impactFactors.mat');
journalsPopulation = length(impactFactors);
J = journalsPopulation;                                                    

in0 = zeros(1,J);
% Journals are defined by eight values: 1. Their id number, 
%                                       2. Their impact factor, 
%                                       3. Their low threshold, 
%                                       4. Their high threshold,
%                                       5. The amount of papers they have accepted, 
%                                       6. the amount of papers they have rejected, 
%                                       7. Their acceptance rate,
%                                       8. The amount of papers they have desk-rejected and 
%                                       9. Their desk-rejection rate.

journals = [(1:J);...
            (impactFactors(:,2)');...
            (in0);...
            (in0);...
            (in0);...
            (in0);...
            (in0);...
            (in0);...
            (in0)]';

impactFactorsReverse = journals(end:-1:1,2);
end