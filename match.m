function out = match(I, M, num_bins_rg, num_bins_by, num_bins_wb)    
    intersection = 0;
    M_sum = 0;
    
    % Compute intersection of the histograms
    for i = 1:num_bins_rg
        for j = 1:num_bins_by
            for k = 1:num_bins_wb
                intersection = intersection + min(I(i,j,k), M(i,j,k));
                M_sum = M_sum + M(i,j,k);
            end
        end
    end
    
    % Convert intersection to fractional match value
    out = intersection / M_sum;
end