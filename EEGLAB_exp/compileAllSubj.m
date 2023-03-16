function compileAllSubj()
%COMPILEALLSUBJ Summary of this function goes here
%   Detailed explanation goes here

% access all the subj specific slices
matFiles = collateAll("*.mat");

% variables
nelectrode = 60;
nsubj = length(matFiles);
collatedEEG = zeros(nelectrode, nsubj, , 360);

% iterate over electrodes
for elec = 1:nelectrode
    for subj = 1:nsubj
        subjEEG = readmatrix(matFiles(subj));
        trialsSubjPlayed = size(subjEEG);
        trialsSubjPlayed = trialsSubjPlayed(2);

        
    end
end
end

