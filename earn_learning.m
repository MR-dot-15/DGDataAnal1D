function earn_learning()
% earn_learning plots the learning curve for each subject

subjects = importdata('subject.txt');
load('subjectwiseBehavData.mat', 'subjwisedat');
n_subj = 23;

tiledlayout(6, 4, 'TileSpacing', 'none', 'Padding', 'none');
for subj_i = 1:n_subj
    behav_dat = subjwisedat{subj_i};
    [earned, max_earned, ~] = blockEarn(behav_dat);
    subplot(6, 4, subj_i);
    propEarned = earned ./ max_earned;
    plot(1:length(propEarned), propEarned, LineWidth = .5); 
    ylim([0 1]);
    legend(subjects{subj_i}, Location="southwest");
    grid("on");
end
sgtitle("Earning over 20 blocks");