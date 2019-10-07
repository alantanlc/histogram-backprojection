function J = backproject(M, I, num_bins_rg, num_bins_by, num_bins_wb)
    %% Compute 3D opponent color histograms
    H1 = opphist3(M, num_bins_rg, num_bins_by, num_bins_wb);
    H2 = opphist3(I, num_bins_rg, num_bins_by, num_bins_wb);

    %% Compute ratio histogram
    for i = 1:num_bins_rg
        for j = 1:num_bins_by
            for k = 1:num_bins_wb
                R(i,j,k) = min(H1(i,j,k) / H2(i,j,k), 1);
            end
        end
    end
    
    %% Convert test image type to double
    I = double(I);

    %% Get RGB channels
    r = I(:,:,1);
    g = I(:,:,2);
    b = I(:,:,3);

    %% Compute opponent color axes
    opponent_rg = r - g;
    opponent_by = 2 .* b - r - g;
    opponent_wb = r + g + b;
    
    %% Axes min, max, range
    min_rg = 0 - 255;
    min_by = 2 * 0 - 255 - 255;
    min_wb = 0 + 0 + 0;
    max_rg = 255 - 0;
    max_by = 2 * 255 - 0 - 0;
    max_wb = 255 + 255 + 255;
    range_rg = max_rg - min_rg + 1;
    range_by = max_by - min_by + 1;
    range_wb = max_wb - min_wb + 1;
    
    %% Normalize color axes values to 0 and 1
    norm_rg = (opponent_rg - min_rg) ./ range_rg;
    norm_by = (opponent_by - min_by) ./ range_by;
    norm_wb = (opponent_wb - min_wb) ./ range_wb;
    
    %% Quantization
    bin_rg = floor(norm_rg * num_bins_rg) + 1;
    bin_by = floor(norm_by * num_bins_by) + 1;
    bin_wb = floor(norm_wb * num_bins_wb) + 1;
    
    %% Backproject ratio histogram
    I_size = size(I);
    for i = 1:I_size(1)
        for j = 1:I_size(2)
            J(i,j) = R(bin_rg(i,j), bin_by(i,j), bin_wb(i,j));
        end
    end
end