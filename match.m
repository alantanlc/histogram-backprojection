function out = match(I, M)
    num_bins_rg = 16;
    num_bins_by = 16;
    num_bins_wb = 8;
    
    intersection = 0;
    M_sum = 0;
    
    for i = 1:num_bins_rg
        for j = 1:num_bins_by
            for k = 1:num_bins_wb
                intersection = intersection + min(I(i,j,k), M(i,j,k));
                M_sum = M_sum + M(i,j,k);
            end
        end
    end
    
    out = intersection / M_sum;
end