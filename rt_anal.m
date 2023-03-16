%% Collate all RT data
clc;
iter = [1, 6, 11, 16];
plot_iter = 1;
for j = iter
    n = 39;
    t = 18*5;
    rt = zeros(t, n);
    
    for i = 1:n
        temp = subjExcAvi{i};
        temp = temp(j:j+t-1,4);
        rt(:,i) = temp';
    end
    
    rt_flat = reshape(rt, 1, []);
    fprintf("%d-%d: mean = %.3f\n", j, j+4,...
        mean(rt_flat));
    
    subplot(2, 2, plot_iter); plot_iter = plot_iter + 1;
    histogram(rt_flat, 20);
    title(num2str(j) + " onwards");
end
%% Subject-wise comparison of RT over a particular quarter
clc;
n = 39;
t = 18*5;
rt_j_subj = zeros(1, n);

fprintf("Subj\tMean RT\n");

% quarter index
j = 16;
for i = 1:n
    temp = subjExcAvi{i};
    temp = temp(j:j+t-1,4);
    rt_j_subj(i) = mean(temp);
    fprintf("%2d\t\t%.3f\n", i, mean(temp));
end


histogram(rt_j_subj, 10);
title("RT hist over subj-s for " + num2str(j));
%% Over trial analysis for one subj
clc;
n = 1;

subj_rt = subjExcAvi{n};
subj_rt = subj_rt(:,4);
smooth_subj_rt = movmean(subj_rt, 18);

figure;
plot(smooth_subj_rt);
%% Left-right switch and reaction time
clc; figure;
n1 = 22; n2 = 17;
t = 100;
rt1 = zeros(t, 1);
rt2 = zeros(t, 1);

for i = 1:n1
    temp = subjCollated1{i};
    temp = temp(1:t,4);
    rt1 = (rt1 + temp)/2;
end
for i = 1:n2
    temp = subjCollated2{i};
    temp = temp(1:t,4);
    rt2 = (rt2 + temp)/2;
end
temp = subjCollated1{1}; temp = temp(1:t,3);
temp = abs(diff(temp))'; ind1 = [0, temp];
lr1 = 1:t; lr1 = lr1(ind1 == 2);

temp = subjCollated2{1}; temp = temp(1:t,3);
temp = abs(diff(temp))'; ind2 = [0, temp];
lr2 = 1:t; lr2 = lr2(ind2 == 2);

subplot(1, 2, 1);
plot(rt1);
xline(lr1, 'k--'); xlim([1 t]);
legend(["RT-1" "L-R switch"]);
subplot(1, 2, 2);
plot(rt2);
xline(lr2, 'k--'); xlim([1 t]);
legend(["RT-2" "L-R switch"]);
%% Generate RT distribution
clc; figure;
n = 17;
t = 360;
rt = zeros(t, n);

for i = 1:n
    temp = subjCollated2{i};
    temp = temp(:,4);
    rt(:,i) = temp;
end

done_upto = 15; %<--------------
rt_sim = 1:(t-done_upto*18);
target_name = "kum28-Jan-2023behavData" + ".xlsx"; %<--------------
target_mat = readmatrix(target_name);
target_rt = target_mat(1:done_upto*18, 4)';
mean_og = mean(target_rt);
disp(mean_og);
range_og = max(target_rt)-min(target_rt);

% dmean = mean(rt(1:done_upto*18,:), "all")...
%     - mean(target_rt);

for i = 1:(t-done_upto*18)
    rt_sim(i) = datasample(rt(done_upto*18+i,:),1);
    if rt_sim(i) <= 0
        rt_sim(i) = min(target_rt);
    end
end
range_new = max(rt_sim)-min(rt_sim);
rt_sim = (range_og/range_new).*rt_sim;
mean_new = mean(rt_sim);
rt_sim = rt_sim + (mean_og - mean_new);
rt_new = horzcat(target_rt, rt_sim)';
disp(mean(rt_new));

target_mat(:,4) = rt_new;
writematrix(target_mat, target_name);

plot(1:360, mean(rt, 2)', (1:360)', rt_new);
legend(["Mean" "Subj"]);