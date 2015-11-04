function [ scientists, cummulativeScientificInformation ] = UpdateTheScientificCommunity( scientists, totalScientificInformation, publishedQuality, iTime )

weeklyUpdate = random('uniform',0.1,1,length(scientists),1);
scientists(:,[2 4]) = scientists(:,[2 4]) + [weeklyUpdate weeklyUpdate];
cummulativeScientificInformation(iTime) = sum(totalScientificInformation(1:iTime));

% Update of the scientific's community level due to the new publications
totalScientificInformationTemp = 0.1*mean(totalScientificInformation);

if (isempty(publishedQuality) == 0)
    if (totalScientificInformationTemp > 0)
        informationBias = 0.1.*totalScientificInformationTemp;
        scientists(:,4) = scientists(:,4) + random('normal', totalScientificInformationTemp , informationBias, length(scientists), 1);
    end
end

end