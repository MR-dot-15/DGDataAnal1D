function accpt = face_Specific_Accept(behavDatCell, photID)
% FACE_SPECIFIC_ACCEPT(behavDatCell, photID)
% Finds mean acceptance of a given subject against a given face
% **Input:**
% behavDatCell: output of prep_Cell_with_Subj_Data.m
% photID: prep_Cell_with_Subj_Data.txt
%   
% **Output:**
% accpt: matrix (# subjects X # face) containing the mean acceptance val

% id of photo files used
photID = importdata(photID);
% sort based on the order in the form
% so that the sequence is maintained
photID = sortrows(photID, 4);
phot_n = length(photID);

% subjects
subj_n = length(behavDatCell);

% data holder
accpt = zeros(subj_n, phot_n);

for subj_i = 1:subj_n
    ith_behavdat = behavDatCell{subj_i};
    for phot_i = 1:phot_n
        % emotion and index of the given photo
        emot = photID(phot_i,1);
        index = photID(phot_i, 2);
        % all emots and indices in the behav dat
        emot_col = ith_behavdat(:,1);
        index_col = ith_behavdat(:,5);
        % calculate acceptance
        acceptance = ith_behavdat(and(emot_col==emot, ...
            index_col==index),7);
        acceptance = sum(acceptance == 1)/length(acceptance);

        % update data holder
        accpt(subj_i, phot_i) = acceptance;
    end
end