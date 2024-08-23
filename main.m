Results1 = load('K:\Jules data\tDCS results for sahar - Sept. 22 2023\tdcs_nonlearners_T2 - result\source\tdcs_nonlearners_T2_Results.mat');
Resutls2 = load('K:\Jules data\tDCS results for sahar - Sept. 22 2023\observation_learners_T2 - result\source\observation_learners_T2_Results.mat');

Input1 = zeros(length(Results1.Flow_info),10,10);
for counter = 1:length(Results1.Flow_info)
    Input1(counter,:,:) = Results1.Flow_info(counter).ntij;
end


Input2 = zeros(length(Resutls2.Flow_info),10,10);
for counter = 1:length(Resutls2.Flow_info)
    Input2(counter,:,:) = Resutls2.Flow_info(counter).ntij;
end

%% Find distributions:

[p_ks,p_kw] = Distributions(Input1, Input2);
DistributionDiscription (Input1, Input2, 4);


%% Graph based comparion
NetworkComparison(Input1, Input2)