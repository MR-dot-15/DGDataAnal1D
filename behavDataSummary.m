function data = behavDataSummary(behavDatCell, llim, ulim, col)
% BEHAVDATASUMMARY(behavDatCell, col) spits out a cell of cells containing 
% the target variable sliced by emotions (1,2,3) X offers (2,3,4)
%
% Inputs:
% subject_names: txt file containing the subject names
% behavDatCell: cell indexed by subject id containing corresp behav data
% llim and ulim: llim-th trial to ulim-th trial--both included
% col: target variable (e.g. 4 for rt, 7 for resp, etc)
%
% Output:
% a cell of cells
% data{subj_id}{condition} = target var slice for that condition
% Note that, condition = 10*emotion + offer
%
% Example usage:
% resp_dat = behavDataSummary(subjwisedat, 7)
clc;


% subj-s eligible to be included
% depending on ulim
% temp = behavDatCell{6};
% temp = temp(:,18*6+1:end); %<-- removed first 6 Aviyank
% behavDatCell{6} = temp;

aviyank_there = true;
to_skip = [];

if ulim > 18*5
    to_skip = horzcat(to_skip, [40 45 47]);
    disp("Removed pmi, avi, vis");
end
if ulim > 18*10
    to_skip = horzcat(to_skip, [43 46]);
    disp("Removed swa, gau");
end
if ulim > 18*14
    to_skip = horzcat(to_skip, 6);
    aviyank_there = false;
    disp("Removed avi-2");
end
if ulim > 18*15
    to_skip = horzcat(to_skip, [42 44]);
    aviyank_there = false;
    disp("Removed the pup kiddos- kum, biv");
end

% subjects
subj_n = length(behavDatCell);
subjectNames = importdata("subject.txt");

% preparing data cells
data = cell(1, subj_n);
cond_slice = cell(1, 3);

for subj = setdiff(1:subj_n, to_skip)
    % access the behav data in the cell
    temp = behavDatCell{subj}; identifier = temp(1,1);
    temp = temp(llim:ulim, :); emot_col = temp(:,1);

    % offer-based slicing
    % special for mr gandu Aviyank
    if and(aviyank_there, subj == 6)
        load('aviyank_off.mat', 'aviyank_off');
        aviyank_off = aviyank_off(llim:ulim);
        off2 = (aviyank_off == 2); 
        off3 = (aviyank_off == 3); 
        off4 = (aviyank_off == 4);
    else
        if identifier == 3
            load('offers.mat', 'base1');
            base1 = base1(llim:ulim);
            off2 = (base1 == 2); off3 = (base1 == 3); off4 = (base1 == 4);
        elseif identifier == 2
            load('offers.mat', 'base2');
            base2 = base2(llim:ulim);
            off2 = (base2 == 2); off3 = (base2 == 3); off4 = (base2 == 4);
        end
    end

    for emot = 1:3
        for offr = 2:4
            % "cell_index" defined here
            cell_index = 10*emot + offr;            
            name = string(subjectNames{subj});
            fprintf(name+" code-%d\n", cell_index);
            
            if offr == 2
                slice = and(emot_col == emot, off2);
            elseif offr == 3
                slice = and(emot_col == emot, off3);
            elseif offr == 4
                slice = and(emot_col == emot, off4);
            end

            sliced = temp(slice, col);
            cond_slice{cell_index} = sliced;
            data{subj} = cond_slice;
        end
    end
end

% clean up the data- remove cells with no entry
data(:,to_skip) = [];