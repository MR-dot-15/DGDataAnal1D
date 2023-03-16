<<<<<<< HEAD
function allBehavDat = collateAll(markers_list)
fnames = [];
for marker = markers_list
    files = dir(marker);
    fnames_cell = {files.name};
    fnames = horzcat(fnames, string(fnames_cell));
end
=======
function allBehavDat = collateAll(marker)
files = dir(marker);
fnames_cell = {files.name};
fnames = string(fnames_cell);
>>>>>>> origin/main
n = length(fnames);

fileID = fopen("subject.txt", "w");
allBehavDat = cell(1,n);

for i = 1:n
    % save the subject code to "subject.txt"
    % and save the subject-specific 
    % behav data to the "allBehavDat" cell
    to_print = char(fnames(i));
    behavDat = readmatrix(to_print);

<<<<<<< HEAD
    to_print = to_print(1:5) + "\n";
=======
    to_print = to_print(1:3) + "\n";
>>>>>>> origin/main
    fprintf(fileID, to_print);

    allBehavDat{i} = behavDat;
end
fclose(fileID);