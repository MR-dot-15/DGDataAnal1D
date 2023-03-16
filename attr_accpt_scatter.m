attr_all = importdata('faceattrAll.txt');
%subj = importdata('subject.txt');
n_subj = 19;

attraction_score = attr_all(2:end,:);

for i = 1:n_subj
    accpt_i = faceSpecificAccpt(i,:);
    attr_i = attraction_score(i,:);
    scatter(attr_i, accpt_i); hold on;
end