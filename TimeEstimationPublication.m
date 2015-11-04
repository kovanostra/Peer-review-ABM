function [ timeEstimation ] = TimeEstimationPublication( decision )

r = rand;

if decision == 2
    % Editorial rejection
    if r <= 0.15
        timeEstimation = 1;
    else
        timeEstimation = randi([1,3]);
    end
    
elseif decision == 0 || decision == 1
    % First decision (rejection:0 or acceptance:1)
    if r <= 0.69
        timeEstimation = randi([4,11]);
    elseif r <= 0.95
        timeEstimation = randi([12,24]);
    else 
        timeEstimation = randi([25,52]);
    end
    
elseif decision == 3 || decision == 4
    % Decision after revisions (rejection:3 or acceptance:4)
    if r <= 0.2
        timeEstimation = randi([4,11]);
    elseif r <= 0.72
        timeEstimation = randi([12,24]);
    else
        timeEstimation = randi([25,52]);
    end

end       
end