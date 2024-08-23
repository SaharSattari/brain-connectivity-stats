%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Graph based comparison between patterns of effective connectivity
%%%%%%%%%%%%%%%%%%%%%%%%
% Sahar 2023-09-26


function NetworkComparison(Normalized_infoflow_HC, Normalized_infoflow_C)

Tauij1 = abs(Normalized_infoflow_HC);
Tauij2 = abs(Normalized_infoflow_C);

% remove diagonal NAN values 
for diag = 1:10
    Tauij1(:,diag,diag) = 0;
    Tauij2(:,diag,diag) = 0;
end


% Pool the data
pooledData = cat(1, Tauij1, Tauij2);

numGroup1 = size(Tauij1, 1);
numGroup2 = size(Tauij2, 1);
totalSubjects = numGroup1 + numGroup2;

% Calculate actual r_W values for original data
[~, ~, ~, ~, rW1_actual,rW2_actual] = graphfeatures(mean(Tauij1,1),mean(Tauij2,1));
numPermutations = 10000;
permutedRW1 = zeros(numPermutations, 1);
permutedRW2 = zeros(numPermutations, 1);

for i = 1:numPermutations
    % Randomly shuffle the pooled data
    shuffledIndices = randperm(totalSubjects);
    
    % Split into two new groups based on original sizes
    permutedGroup1 = pooledData(shuffledIndices(1:numGroup1), :, :);
    permutedGroup2 = pooledData(shuffledIndices(numGroup1+1:end), :, :);
    
    % Average the Tauij matrices within each group
    avgPermutedGroup1 = mean(permutedGroup1, 1);
    avgPermutedGroup2 = mean(permutedGroup2, 1);
    
    % Compute rW for averaged permuted data
    [~, ~, ~,~, permutedRW1(i),permutedRW2(i)] = graphfeatures(avgPermutedGroup1,avgPermutedGroup2);
end

% % Compute p-values
% pValue1 = mean(permutedRW1 > rW1_actual);
% pValue2 = mean(permutedRW2 > rW2_actual);

% Define common bins for consistency in visualization
edges = linspace(min([permutedRW1; permutedRW2]), max([permutedRW1; permutedRW2]), 50);

% Plot histograms
figure;

subplot(2,1,1);
histogram(permutedRW1, edges, 'FaceColor', 'b');
hold on
scatter(rW1_actual, 0, 150, 'ro', 'filled');
title('Distribution of Permuted rW for Group 1');
legend('Permuted rW distribution', 'Actual rW');
set(gca,'FontSize',10,'FontName','Times New Roman', 'LineWidth',1, 'FontWeight', 'bold');
set(gcf,'color','white');

subplot(2,1,2);
histogram(permutedRW2, edges, 'FaceColor', 'r');
hold on
scatter(rW2_actual, 0, 150, 'ro', 'filled');
title('Distribution of Permuted rW for Group 2');
legend('Permuted rW distribution', 'Actual rW');
set(gca,'FontSize',10,'FontName','Times New Roman', 'LineWidth',1, 'FontWeight', 'bold');
set(gcf,'color','white');
sgtitle('Permuted rW Distributions for Both Groups');

end
