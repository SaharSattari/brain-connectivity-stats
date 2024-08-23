function result_flattened = extractValues(matrix, ns)
% Function to remove the diagonal from the matrix and reshape it

    np = size(matrix, 1);  % number of participants or the size of the first dimension
    matrix_reshaped = [];

    for i = 1:np
        temp = [];
        for j = 1:ns
            for k = 1:ns
                if j ~= k
                    temp = [temp, matrix(i, j, k)];
                end
            end
        end
        matrix_reshaped = [matrix_reshaped; temp];
    end
result_flattened = reshape(matrix_reshaped', [1, numel(matrix_reshaped)]);

end