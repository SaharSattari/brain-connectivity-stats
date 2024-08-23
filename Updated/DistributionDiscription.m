%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3 statistical mesures for each group
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sahar last update: 2023-09-25

function DistributionDiscription (Normalized_infoflow_HC, Normalized_infoflow_C, nIndividuals)
% INPUTS:
% Normalized_infoflow_HC/Normalized_infoflow_C: each should be matrix of size (np, ns, ns) 
%	np = number of participants
%   ns = number of sources 
% nIndividuals: the number of individuals in each subsample

nSubsamples = 100000;
ns = size(Normalized_infoflow_C,2);

% Preallocate arrays for statistical measures
COV1 = zeros(nSubsamples, 1);
skewness1 = zeros(nSubsamples, 1);
kurtosis1 = zeros(nSubsamples, 1);

COV2 = zeros(nSubsamples, 1);
skewness2 = zeros(nSubsamples, 1);
kurtosis2 = zeros(nSubsamples, 1);


for i = 1:nSubsamples
    subsample1 = abs(extractValues(Normalized_infoflow_HC(randperm(size(Normalized_infoflow_HC,1),nIndividuals),:,:),ns));
    subsample2 = abs(extractValues(Normalized_infoflow_C(randperm(size(Normalized_infoflow_C,1),nIndividuals),:,:),ns));
        
    % Compute statistical measures
    COV1(i) = std(subsample1) / mean(subsample1);
    skewness1(i) = skewness(subsample1);
    kurtosis1(i) = kurtosis(subsample1);
    
    COV2(i) = std(subsample2) / mean(subsample2);
    skewness2(i) = skewness(subsample2);
    kurtosis2(i) = kurtosis(subsample2);
end

% Plotting
figure;

% 3D scatter plot
subplot(2,2,1);
scatter3(COV1, skewness1, kurtosis1,15, 'b','filled' );
hold on;
scatter3(COV2, skewness2, kurtosis2,15, 'r','filled');
title('3D scatter plot (COV, skewness, kurtosis)');
xlabel('COV'); ylabel('Skewness'); zlabel('Kurtosis');

% 2D Projections
subplot(2,2,2);
scatter(COV1, skewness1,15, 'b','filled');
hold on;
scatter(COV2, skewness2,15, 'r','filled');
title('2D (COV, skewness)');
xlabel('COV'); ylabel('Skewness');

subplot(2,2,3);
scatter(COV1, kurtosis1, 15,'b','filled');
hold on;
scatter(COV2, kurtosis2, 15,'r','filled');
title('2D (COV, kurtosis)');
xlabel('COV'); ylabel('Kurtosis');

subplot(2,2,4);
scatter(skewness1, kurtosis1,15, 'b','filled');
hold on;
scatter(skewness2, kurtosis2, 15,'r','filled');
title('2D (skewness, kurtosis)');
xlabel('Skewness'); ylabel('Kurtosis');

set(gca,'FontSize',10,'FontName','Times New Roman', 'LineWidth',1, 'FontWeight', 'bold');
set(gcf,'color','white');
end

