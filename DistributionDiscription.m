%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3 statistical mesures for each individual
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sahar last update: 2024-07-02


% Here is how you should call this function in "main":
    % [COV1, COV2, skewness1, skewness2, kurtosis1, kurtosis2] = DistributionDiscription_indv (Normalized_infoflow_HC, Normalized_infoflow_C)
    % each output (e.g. COV1) will be a vector with the length same as the
    % number of individuals in that specific group.



function [COV1, COV2, skewness1, skewness2, kurtosis1, kurtosis2] = DistributionDiscription_indv (Normalized_infoflow_HC, Normalized_infoflow_C)
% INPUTS:
% Normalized_infoflow_HC/Normalized_infoflow_C: each should be matrix of size (np, ns, ns) 
%	np = number of participants
%   ns = number of sources 

ns = size(Normalized_infoflow_C,2);
np1 = size(Normalized_infoflow_HC,1);
np2 = size(Normalized_infoflow_C,1);
% Preallocate arrays for statistical measures
COV1 = zeros(np1, 1);
skewness1 = zeros(np1, 1);
kurtosis1 = zeros(np1, 1);

COV2 = zeros(np2, 1);
skewness2 = zeros(np2, 1);
kurtosis2 = zeros(np2, 1);


for i = 1:np1
    subsample1 = abs(extractValues(Normalized_infoflow_HC(i,:,:),ns));
        
    % Compute statistical measures
    COV1(i) = std(subsample1) / mean(subsample1);
    skewness1(i) = skewness(subsample1);
    kurtosis1(i) = kurtosis(subsample1); 
end
for i = 1:np2
    subsample2 = abs(extractValues(Normalized_infoflow_C(i,:,:),ns));
        
    % Compute statistical measures
    COV2(i) = std(subsample2) / mean(subsample2);
    skewness2(i) = skewness(subsample2);
    kurtosis2(i) = kurtosis(subsample2); 
end


end

