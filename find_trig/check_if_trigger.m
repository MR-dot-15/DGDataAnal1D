function trig = check_if_trigger(dat, ep)
ep = reshape(ep, 1, []);
trig = dat(2:end, 33);
trig = trig(ep);
trig = reshape(trig, [], 614);