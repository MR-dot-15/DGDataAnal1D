function rt_dat = prep_rt_matrix(source_cell)
n_subj = 19;
rt_dat = zeros(3,3);

for emot = 1:3
    for offer = 2:4
        cell_ind = 10*emot+offer;
        rt_mean = 0;
        for subj = 1:19
            temp_dat = source_cell{subj}{cell_ind};
            rt = sum(temp_dat)/length(temp_dat);
            rt_mean = rt_mean + rt;
        end
        rt_mean = rt_mean/n_subj;
        rt_dat(emot, offer-1) = rt_mean;
    end
end