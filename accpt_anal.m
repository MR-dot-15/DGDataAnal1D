%% Cond specific acceptance over time
clc;
init_trial = 1:4*18:360;
mean_hap = 1:length(init_trial);
mean_dis = 1:length(init_trial);
mean_neu = 1:length(init_trial);
time = 1:length(init_trial);

for i = time
    trial = init_trial(i);
    temp_accpt = prep_accpt_matrix(behavDataSummary(...
        allBehav, trial, trial+4*18-1, 7));
    mean_hap(i) = mean(temp_accpt(1, :));
    mean_dis(i) = mean(temp_accpt(2, :));
    mean_neu(i) = mean(temp_accpt(3, :));
end

plot(time, mean_hap, time, mean_dis, time, mean_neu);
xticklabels(string(init_trial)); grid("on");
xlabel("Segment"); ylabel("Acceptance");
legend(["Hap" "Dis" "Neu"]);
%% Distribution of acceptance rate (3X3)
n_subj = 47;
emots = 1:3; offers = 2;
plot_index = 1;

%condMatrix = zeros(9, n_subj); index = 1;

for emot = emots
    for offer = offers
        subj_temp = zeros(1,n_subj);
        cell_index = emot*10 + offer;
        
        for subj = 1:n_subj
            temp = condSpecAccpt_2b{subj}{cell_index}; %change for RT
            subj_temp(subj) = sum(temp == 1)/length(temp);
            %subj_temp(subj) = mean(temp); %for RT
        end
%         condMatrix(index, :) = subj_temp;
%         index = index + 1;
%         if offer == 2
%             align = 'right';
%         else
%             align = 'left';
%         end
%         subplot(3,3,plot_index); plot_index = plot_index + 1;
%         histogram(subj_temp, 7); hold on; grid minor;
%         xline(mean(subj_temp), 'k--',...
%             'LabelHorizontalAlignment',align,...
%             'LabelOrientation','horizontal',...
%             'Label', {"\mu="+num2str(mean(subj_temp),2)});
%         title(num2str(cell_index));
    end
end
sgtitle("Acceptance: blocks 16-20");
clear emots offers plot_index index...
    emot offer subj n_subj temp;

%% Find all-acceptors
n_subj = 47;
subjects = 1:n_subj;

slice_index = condMatrix(1,:)>.9;
for i = 2:9
    slice_index = and(slice_index,...
        condMatrix(i,:)>.9);
end
AAsubjects = subjects(slice_index);
disp(AAsubjects);
clear n_subj subjects i slice_index;

%% Block-segment wise histograms etc
clc;
% none excluded in anova
[x, grp_emot] = test_anova(condSpecAccpt_2b, []);
for i = 1:3
    subplot(3,3,i);
    histogram(x(grp_emot==i), 7); xlim([0 1]); grid minor; 
    tit = num2str(i) + "2 - none excluded";
    title(tit);
end

% excluding all acceptors
disp(AAsubjects);
[x, grp_emot] = test_anova(condSpecAccpt1, AAsubjects);
for i = 1:3
    subplot(3,3,i+3);
    histogram(x(grp_emot==i), 7); xlim([0 1]); grid minor; 
    tit = num2str(i) + "2 - AA excluded";
    title(tit);
end

% >.9 only for offer 2 excluded in anova
disp(to_skip);
[x, grp_emot] = test_anova(condSpecAccpt1, to_skip);
for i = 1:3
    subplot(3,3,i+6);
    histogram(x(grp_emot==i), 7); xlim([0 1]); grid minor; 
    tit = num2str(i) + "2 - Af2 excluded";
    title(tit);
end