function attr_accpt_correlation()
% ATTR_ACCPT_CORRELATION() finds the correlation b/w-
% 1. average acceptance % against a face
% 2. attractive score assigned to that face
% ... for the i-th subject
% Finally plots a bootstrapped histogram of the correlation coeff

% load faceSpecificAccpt
load('acceptance_per_face.mat', 'faceSpecificAccpt');

attr_all = importdata('faceattrAll.txt');
n_subj = 23;

%face_index = attr_all(1,:);
attraction_score = attr_all(2:end,:);

% correlation
rho = zeros(n_subj,1);

for i = 1:n_subj
    accpt_i = faceSpecificAccpt(i,:);
    attr_i = attraction_score(i,:);
    
    x = accpt_i - mean(accpt_i);
    y = attr_i - mean(attr_i);
    rho(i) = sum(x.*y)/(sum(x.^2)*...
        sum(y.^2))^.5;
end

N = 19;
iter = 1000;
boot_val = 1:iter;

for boot = 1:iter
    sample = datasample(rho, N);
    sample_mean = mean(sample);
    boot_val(boot) = sample_mean;
end

histogram(boot_val, NumBins = 20); hold on;
grid("on"); title("Bootstrapped distribution of \rho");
xlabel('\rho'); 

e = mean(boot_val);
q1 = quantile(boot_val, 0.025);
q2 = quantile(boot_val, 0.975);
disp([e q1 q2]);