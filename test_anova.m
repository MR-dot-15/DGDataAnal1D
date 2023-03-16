function [dat_extended_list, grp_emot] = test_anova(source_cell, exclude_index)
% TEST_ANOVA(param) for different ANOVA tests
%
% *Input-*
% source_cell: output of behavDatSumary
%
% *Output-*
% p = probab vals returned by ANOVAN

% WITHOUT NORMALIZATION

%load('subjectwiseBehavData_mod.mat', 'subjwisedat');
n_subj = length(source_cell);
subj_list = 1:n_subj;
subj_list = setdiff(subj_list, exclude_index);

emotions = 1:3; 
dat_extended_list = zeros(1, 3*length(subj_list));

% TWO-WAY ANOVA for unbalanced---------------------------------------------

% offers = 2:4;
% grp_subj = zeros(1, 9*n_subj);
% grp_emot = repmat([1 1 1 2 2 2 3 3 3], 1, n_subj);
% grp_off = repmat([2 3 4], 1, 3*n_subj);

% k = 1;
% for subj = 1:n_subj
%     grp_subj(subj:subj+9-1) = subj;
%     for emot = emotions
%         for off = offers
%             key = 10*emot + off;
%             temp = dat{subj}{key};
%             dat_extended_list(k) = sum(temp == 1)/length(temp);
%             k = k + 1;
%         end
%     end
% end
% 
% p = anovan(dat_extended_list', {grp_emot grp_off}, ...
%     'model', "interaction", 'varnames', {'grp_emot', ...
%     'grp_off'});

% ONE-WAY ANOVA for different offers---------------------------------------

grp_emot = repmat(emotions, 1, length(subj_list));

offer = 2; j = 1;

for subj = subj_list
    for emot = emotions
        key = 10*emot + offer;
        temp = source_cell{subj}{key};
        dat_extended_list(j) = sum(temp == 1)/length(temp);
        j = j + 1;
    end
end

fprintf("1w-ANOVA for offer = %d\n", offer);

p1 = anova1(dat_extended_list, grp_emot, 'off');
fprintf("1. p = %.3f for len(group) = %d\n",...
    p1, length(dat_extended_list));

% eliminating entries with "full or null" acceptance
% FOR NO GOOD REASON, MIND THAT
% slice = or(dat_extended_list == 1, dat_extended_list == 0);
% dat_extended_list_mod = dat_extended_list(~slice);
% grp_emot_mod = grp_emot(~slice);
% 
% p2 = anova1(dat_extended_list_mod, grp_emot_mod, 'off');
% fprintf("2. p = %.3f for len(new-group) = %d\n",...
%     p2, length(dat_extended_list_mod));
