function [d_time_stamps, rt] = druglord_somnath(eegfile, behav_dat, block)
% DRUGLORD_SOMNATH(eegfile, behav_data) finds functional trigger indices
%
% Inputs:
% eegfile = eeg data matrix for n-th block
% behav_dat = entire behav data matrix
% block = block to be checked for
%
% Output:

n = 18;
rt = behav_dat(:,4);
llim = n*(block-1)+1;
rt = rt(llim:llim + 17);

eegfile = eegfile(2:end,:);

trig = eegfile(:,33);
trig = diff(trig);
trig = [0 trig'];
trig_at = trig == 4;

time_stamps = 1:length(trig);
time_stamps = time_stamps(trig_at) + 1;
d_time_stamps = diff(time_stamps);
d_time_stamps = d_time_stamps';
d_time_stamps = d_time_stamps ./ 512;

block_trig = 1;
if round(d_time_stamps(1), 1) ~= 2.5
    block_trig = 0;
    disp("1. block trig not found");
else
    disp("1. block trig exists");
end

no_trig = sum(trig == 4);
fprintf("2. %d trigs: approx %d blocks present\n", no_trig, round(no_trig/4));

% dt_reaction = round(d_time_stamps(4:4:end),1);
% rt_round = round(rt, 1);
% 
% if and(block_trig, length(dt_reaction)==length(rt_round))
%     if all(dt_reaction == rt_round)
%         fprintf("3. all trials present- proceeding with normal indexing\n");
%         first_img_trig = 3;
%     else
%         fprintf("3. check manually, dt_reaction doesn't match with rt\n");
%     end
% else
%     blk_missed = 18 - no_trig/4;
%     rt_to_check = rt_round(1:round(blk_missed+2));
%     disp(rt_to_check);
%     for i = 1:4
%         for j = 1:length(rt_to_check)
%             disp([rt_to_check(j), round(d_time_stamps(i),1)]);
%             disp('----');
%             if rt_to_check(j) == round(d_time_stamps(i),1)
%                 break
%             end
%         end
%     end
%     if and(j == length(rt_to_check), i == 4)
%         fprintf("3. search failed\n");
%         return;
%     else
%         fprintf("3. starting at %d-th trial\n", j);
%         if i == 1
%             first_img_trig = 4;
%         else
%             first_img_trig = i - 1;
%         end
%     end
% end
% 
% % img presentation trigger
% img_stamps = time_stamps(first_img_trig:4:end);
% 
% % epoch matrix
% % freq is supposed to be 512
% freq = 512;
% dur = 1.2 * freq;
% epoching_index = zeros(length(img_stamps)...
%     , round(dur));
% % fill the epoch matrix up
% for i = 1:length(img_stamps)
%     llim = img_stamps(i)-round(.2*freq);
%     ulim = img_stamps(i)+freq-1;
%     epoching_index(i, :) = llim:ulim;
% end