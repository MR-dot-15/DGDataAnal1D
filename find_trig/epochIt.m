function [epoching_index, dur] = epochIt(dat)
    % image starting
    start_ind = 1;

    % first row is col index
    % trigger column 33
    trig = dat(2:end,33); 
    t = length(trig);
    trig = diff(trig);

    % 73 triggers mand- 72 + 1 block
    if sum(trig == 4) ~= 73
        disp("73 trig not found");
        disp(sum(trig == 4));
    end

    % find the time stamps when 2->6
    t_stamps = 1:t;
    % index is shifted by 1, due to "diff"
    t_stamps = t_stamps(trig == 4) + 1;
    
    % img presentation; trigger no-
    % 3rd...7th... so on, including the block trigger
    img_stamps = t_stamps(start_ind:4:end);

    % epoch matrix
    % freq is supposed to be 512
    % most of the 1s intervals have 
    % freq samples...
    freq = 512;
    dur = 1.2 * freq;
    epoching_index = zeros(length(img_stamps)...
        , round(dur));
    % fill the epoch matrix up
    for i = 1:length(img_stamps)
        llim = img_stamps(i)-round(.2*freq);
        ulim = img_stamps(i)+freq-1;
        epoching_index(i, :) = llim:ulim;
    end