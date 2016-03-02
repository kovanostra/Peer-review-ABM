function [ timeSpent ] = TimeEstimation( B, r )
% Estimates the time that the reviewer needs to evaluate the article by
% using data from Mulligan et al. (2013) for two different fields; Medicine
% and Physics. 
% The probability to spend a certain amount of time in the
% reviewing process corresponds to the percentage of the researchers that 
% said the process takes them that specific amount of time. 
% For the unreliable and the competitive reviewer no data exist, so the
% amount of time they spend reviewing an article is hypothesised.

%% In Medicine

% Reliable reviewer
% if (B == 0.05)
if (r <= 0.65)
    timeSpent = random('uniform',2,5);
elseif (r <= 0.87)
    timeSpent = random('uniform',6,10);
elseif (r <= 0.95)
    timeSpent = random('uniform',11,20);
elseif (r <= 0.97)
    timeSpent = random('uniform',21,30);
elseif (r <= 0.99)
    timeSpent = random('uniform',31,50);
else
    timeSpent = random('uniform',51,100);
end

% % Competitive reviewer
% elseif (B == 0.06)
%     if (r <= 0.65)
%         timeSpent = random('uniform',2,6);
%     elseif (r <= 0.87)
%         timeSpent = random('uniform',7,11);
%     elseif (r <= 0.95)
%         timeSpent = random('uniform',12,21);
%     elseif (r <= 0.97)
%         timeSpent = random('uniform',22,34);
%     elseif (r <= 0.99)
%         timeSpent = random('uniform',35,55);
%     else
%         timeSpent = random('uniform',56,100);
%     end
%     
% % Unreliable reviewer
% else
%     if (r <= 0.65)
%         timeSpent = random('uniform',2,4);
%     elseif (r <= 0.87)
%         timeSpent = random('uniform',5,8);
%     elseif (r <= 0.95)
%         timeSpent = random('uniform',9,15);
%     elseif (r <= 0.97)
%         timeSpent = random('uniform',16,25);
%     elseif (r <= 0.99)
%         timeSpent = random('uniform',26,35);
%     else
%         timeSpent = random('uniform',36,50);
%     end
%     
% end



%% In Physics

% % Reliable reviewer
% if (B == 0.5)
%     if (r <= 0.42)
%         timeSpent = random('uniform',2,5);
%     elseif (r <= 0.70)
%         timeSpent = random('uniform',6,10);
%     elseif (r <= 0.85)
%         timeSpent = random('uniform',11,20);
%     elseif (r <= 0.91)
%         timeSpent = random('uniform',21,30);
%     elseif (r <= 0.96)
%         timeSpent = random('uniform',31,50);
%     elseif (r <= 0.99)
%         timeSpent = random('uniform',56,100);
%     else
%         timeSpent = random('uniform',100,200);
%     end
%     
% % Competitive reviewer
% elseif (B == 0.6)
%     if (r <= 0.42)
%         timeSpent = random('uniform',2,6);
%     elseif (r <= 0.70)
%         timeSpent = random('uniform',7,11);
%     elseif (r <= 0.85)
%         timeSpent = random('uniform',12,21);
%     elseif (r <= 0.91)
%         timeSpent = random('uniform',22,34);
%     elseif (r <= 0.96)
%         timeSpent = random('uniform',35,55);
%     elseif (r <= 0.99)
%         timeSpent = random('uniform',56,100);
%     else
%         timeSpent = random('uniform',100,200);
%     end
%     
% % Unreliable reviewer
% else
%     if (r <= 0.42)
%         timeSpent = random('uniform',2,4);
%     elseif (r <= 0.70)
%         timeSpent = random('uniform',5,8);
%     elseif (r <= 0.85)
%         timeSpent = random('uniform',9,15);
%     elseif (r <= 0.91)
%         timeSpent = random('uniform',16,25);
%     elseif (r <= 0.96)
%         timeSpent = random('uniform',26,35);
%     elseif (r <= 0.99)
%         timeSpent = random('uniform',36,50);
%     else
%         timeSpent = random('uniform',51,80);
%     end
%     
% end


end

