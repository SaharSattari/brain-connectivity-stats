%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Graph based comparison between patterns of effective connectivity
%%%%%%%%%%%%%%%%%%%%%%%%
% Sahar 2023-09-26


function [permutation_error] = NetworkComparison(Normalized_infoflow_HC, Normalized_infoflow_C)

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

[~, ~, ~, ~, rW1_actual,rW2_actual] = graphfeatures(Tauij1,Tauij2);
[~,p] = ttest2(rW1_actual,rW2_actual);

numPermutations = 10000;
% permutedRW1 = zeros(numPermutations, 1);
% permutedRW2 = zeros(numPermutations, 1);

error_counter = 0;
for i = 1:numPermutations
    % Randomly shuffle the pooled data
    shuffledIndices = randperm(totalSubjects);
    
    % Split into two new groups based on original sizes
    permutedGroup1 = pooledData(shuffledIndices(1:numGroup1), :, :);
    permutedGroup2 = pooledData(shuffledIndices(numGroup1+1:end), :, :);

    % Compute rW for averaged permuted data
    [~, ~, ~,~, permutedRW1,permutedRW2] = graphfeatures(permutedGroup1,permutedGroup2);
    [~,p_permuted(i)] = ttest2(permutedRW1,permutedRW2);
    if p_permuted(i)<p
        error_counter = error_counter+1;
    end

end

permutation_error = error_counter/numPermutations;




edges = linspace(min(p_permuted), max(p_permuted), 50);

% Plot histograms
figure;

% Calculate percentiles for Group 1
percentile_5_group1 = prctile(p_permuted, 5);
percentile_95_group1 = prctile(p_permuted, 95);

% Plot histogram
figure;


subplot(2,1,1);
histogram(p_permuted, edges, 'FaceColor', 'b');
hold on
scatter(p, 0, 150, 'ro', 'filled');

scatter(percentile_5_group1, 0, 150, 'kd', 'filled');   
scatter(percentile_95_group1, 0, 150, 'kd', 'filled');

title('Distribution of Permuted statistics');
legend('Permuted error distribution', 'actual error');
set(gca,'FontSize',10,'FontName','Times New Roman', 'LineWidth',1, 'FontWeight', 'bold');
set(gcf,'color','white');


end
