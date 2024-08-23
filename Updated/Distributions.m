%%%%%%%%%%%%%%%%%%%%%%%%%%
% Statistical analysis - Comparison of information flow between HC and C
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sahar  Last update: 2023-09-22

function [p_ks,p_kw] = Distributions(Normalized_infoflow_HC, Normalized_infoflow_C)
% INPUTS:
% - Normalized_infoflow_HC, Normalized_infoflow_C: Matrices of size (np, ns, ns)
%     where np = number of participants and ns = number of sources
%
% OUTPUT:
% - p_ks: p-value from the Kolmogorov-Smirnov test

% Parameters
num_bins = 50;
ns = size(Normalized_infoflow_HC, 2);

% Removing the main diagonal and reshaping the matrices
matrix1_reshaped = abs(extractValues(Normalized_infoflow_HC, ns));
matrix2_reshaped = abs(extractValues(Normalized_infoflow_C, ns));

% Plotting histograms
plotHistograms(matrix1_reshaped, matrix2_reshaped, num_bins);

% Kolmogorov-Smirnov test with two independent samples
[~, p_ks] = kstest2(matrix1_reshaped, matrix2_reshaped);


Numofsubsample = min(size(Normalized_infoflow_HC,1),size(Normalized_infoflow_C,1));

for sample = 1:1000
    matrix1_reshaped = abs(extractValues(Normalized_infoflow_HC(randperm(size(Normalized_infoflow_HC,1),Numofsubsample),:,:),ns));
    matrix2_reshaped = abs(extractValues(Normalized_infoflow_C(randperm(size(Normalized_infoflow_C,1),Numofsubsample),:,:),ns));


    % Concatenate data and create groups
    allData = [matrix1_reshaped, matrix2_reshaped];
    groups = [ones(size(matrix1_reshaped)), 2*ones(size(matrix2_reshaped))];

    % Kruskal-Wallis test
    [p_kw(sample), ~, ~] = kruskalwallis(allData, groups, 'off');
end

end



function plotHistograms(matrix1, matrix2, num_bins)
    % Function to plot the histograms

    % Calculate the overall range for the combined data
    combined_data = [matrix1'; matrix2'];
    max_val = max(abs(combined_data));
    bin_edges = linspace(0, max_val, num_bins+1); % define the bin edges based on the overall range

    figure('Name', 'Outputfigure');

    % Histogram for matrix1 (blue with black edges)
    histogram(abs(matrix1), bin_edges, 'Normalization', 'pdf', 'FaceColor', 'blue','EdgeColor', 'blue','LineWidth', 1, 'FaceAlpha', 0.5, 'EdgeColor', 'black');
    hold on;

    % Histogram for matrix2 as a 'stairs' plot (red line without filling)
    histogram(abs(matrix2), bin_edges, 'Normalization', 'pdf', 'FaceColor', 'red', 'EdgeColor', 'red', 'LineWidth', 1,'FaceAlpha', 0.2);

    % Setting labels, legends, and axis limits
    xlabel('$| \tau_{i \rightarrow j} |$ ', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('Density');
    legend('Male Concussed', 'Male Control'); %%% name of input 1, name of input 2
    xlim([0, max_val]);
    set(gca, 'FontSize', 10, 'FontName', 'Helvetica', 'LineWidth', 1, 'FontWeight', 'bold');
    set(gcf, 'color', 'white');
    
    hold off;
end

