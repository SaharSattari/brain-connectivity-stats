%% 1. Load data

Results1 = load('/Users/juliannemcleod/Documents/Effective Connectivity Pre-Final/Results/MaleAdolescents_Concussed/source/MaleAdolescents_Concussed_Results.mat');
Resutls2 = load('/Users/juliannemcleod/Documents/Effective Connectivity Pre-Final/Results/MaleAdolescents_Control/source/MaleAdolescents_Control_Results.mat');

Input1 = zeros(length(Results1.Flow_info),10,10);
for counter = 1:length(Results1.Flow_info)
    Input1(counter,:,:) = Results1.Flow_info(counter).ntij;
end

Input2 = zeros(length(Resutls2.Flow_info),10,10);
for counter = 1:length(Resutls2.Flow_info)
    Input2(counter,:,:) = Resutls2.Flow_info(counter).ntij;
end

%% 2. Generate probability density histograms of IFRs and calulate KS and KW (comparing the distributions of Tij values)

[p_ks,p_kw] = Distributions(Input1, Input2);
DistributionDiscription (Input1, Input2, 11); %%% change number to ~half the number of participants in each sample (12/21 or 0.57% in FHN2019)

%% 3. Generate frequency histograms of pearson correlation coefficients for rw (comparing the pattern of Tij values) **Make sure to have this function folder openbefore running: octave-networks-toolbox-master

NetworkComparison(Input1, Input2)

%% Output is a list of each subject's rw value (empty rw1 and rw2 before by doing rw2=[] in command window)

Tauij1 = abs(Input1);
Tauij2 = abs(Input2);
for diag = 1:10
    Tauij1(:,diag,diag) = 0;
    Tauij2(:,diag,diag) = 0;
end

% % starting with pearson function
% % Compute Node Degrees:
     for counter = 1: size(Tauij1,1)
rw1(counter) = pearsonW(squeeze(Tauij1(counter,:,:)));
     end

     for counter = 1: size(Tauij2,1)
rw2(counter) = pearsonW(squeeze(Tauij2(counter,:,:)));
     end

 %% t.test comparing the rWs in each group 

[h,p,ci,stats] = ttest2(rw1, rw2)
