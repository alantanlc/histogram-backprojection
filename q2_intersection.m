% Clear command window and workspace
clear; clc; clf;

%% Read images
files = dir('./Training/*.jpg');
num_files = length(files);

%% Compute 3D histograms
num_bin_rg = 16;
num_bin_by = 16;
num_bin_wb = 8;
histograms = zeros(num_bin_rg, num_bin_by, num_bin_wb, num_files);
for i = 1:num_files
    histograms(:, :, :, i) = 0;
end

%% Compute match values
match_values = zeros(num_files, num_files);
for i = 1:length(files)
    for j = 1:length(files)
        match_values(i, j) = 0;
    end
end

%% Compute fractional match value
I(1:num_bin_rg, 1:num_bin_by, 1:num_bin_wb) = 10;
M(1:num_bin_rg, 1:num_bin_by, 1:num_bin_wb) = 10;
M_sum = 0;
for i = 1:num_bin_rg
    for j = 1:num_bin_by
        for k = 1:num_bin_wb
            H(i,j,k) = min(I(i,j,k), M(i,j,k));
            M_sum = M_sum + M(i,j,k);
        end
    end
end
H(i,j,k) = H(i,j,k) ./ M_sum;

%% Display histogram intersection matrix
