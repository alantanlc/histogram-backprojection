function H = conhist2(I, num_bins_r, num_bins_g)
    %% Convert image type to double
    I = double(I);
    
    %% Get RGB channgels
    r = I(:,:,1);
    g = I(:,:,2);
    b = I(:,:,3);
    
    %% Compute color constancy axes
    wb = r + g + b;
    wb(wb == 0) = eps('double');
    constancy_r = r ./ wb;
    constancy_g = g ./ wb;
    
    %% Quantization
    bin_r = floor(constancy_r * num_bins_r) + 1;
    bin_g = floor(constancy_g * num_bins_g) + 1;
    bin_r(bin_r > num_bins_r) = num_bins_r;
    bin_g(bin_g > num_bins_g) = num_bins_g;
    
    %% Histogram
    H = zeros(num_bins_r, num_bins_g);
    I_size = size(I);
    for i = 1:I_size(1)
        for j = 1:I_size(2)
            H(bin_r(i,j), bin_g(i,j)) = H(bin_r(i,j), bin_g(i,j)) + 1;
        end
    end
end