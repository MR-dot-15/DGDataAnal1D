function dat = prep_Cell_with_Subj_Data(file)
% PREP_CELL_WITH_SUBJ_DATA(file) prepares a cell where i-th entry contains
% the corresponding behav data (360X9 matrix)
%
% Input:
% file: subject.txt, containing code-name of the subjects
%
% Output:
% dat: n-long cell, i-th cell i's behav data

subjectname = importdata(file);
n = length(subjectname);
dat = cell(1, n);

cd behavDat/;
for i = 1:n
    subjcode = subjectname{i};
    disp("doing " + subjcode);
    fn = collateAll(subjcode + "*.xls");
    dat{i} = readmatrix(fn);
end
cd ../