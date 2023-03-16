function baseOff = findBaseOff(dat)
<<<<<<< HEAD
n = length(dat);
baseOff = zeros(n,1);
ofr = dat(:,2);

for i = 1:n
=======
baseOff = zeros(360,1);
ofr = dat(:,2);

for i = 1:360
>>>>>>> origin/main
    baseOff(i) = getBaseOffer(ofr(i));
end