function fnames = collateAll(marker)
files = dir(marker);
fnames_cell = {files.name};
fnames = string(fnames_cell);