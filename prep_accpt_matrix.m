function cond_acceptance = prep_accpt_matrix(source_cell)
n_subj = length(source_cell);
disp(n_subj);
cond_acceptance = zeros(3,3);

for emot = 1:3
    for offer = 2:4
        cell_ind = 10*emot+offer;
        accpt_mean = 0;
        for subj = 1:n_subj
            temp_dat = source_cell{subj}{cell_ind};
            acceptance = sum(temp_dat == 1)/length(temp_dat);
            accpt_mean = accpt_mean + acceptance;
        end
        accpt_mean = accpt_mean/n_subj;
        cond_acceptance(emot, offer-1) = accpt_mean;
    end
end