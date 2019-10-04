%% Clear command window and workspace
clear; clc; clf;

%% Read Image
I = double(imread('./Training/22.jpg'));
r = I(:,:,1);
g = I(:,:,2);
b = I(:,:,3);

%% Compute opponent color axes
opponent_rg = r - g;
opponent_by = 2 .* b - r - g;
opponent_wb = r + g + b;

%% Axes min, max, and range
min_rg = 0 - 256;
max_rg = 256 - 0;
min_by = 2 * 0 - 256 - 256;
max_by = 2 * 256 - 0 - 0;
min_wb = 0 + 0 + 0;
max_wb = 256 + 256 + 256;
range_rg = max_rg - min_rg;
range_by = max_by - min_by;
range_wb = max_wb - min_wb;

%% Normalize color axes
norm_rg = (opponent_rg - min_rg) ./ range_rg;
norm_by = (opponent_by - min_by) ./ range_by;
norm_wb = (opponent_wb - min_wb) ./ range_wb;

%%  Quantization
num_bin_rg = 16; % Number of bins
num_bin_by = 16; % Number of bins
num_bin_wb = 8; % Number of bins
q_rg = 1 / num_bin_rg; % Quantization
q_by = 1 / num_bin_by; % Quantization
q_wb = 1 / num_bin_wb; % Quantization
bin_rg = floor(norm_rg/q_rg) + 1; % Quantized & Indexed Channel [1 ~ num_bin_rg]
bin_by = floor(norm_by/q_by) + 1; % Quantized & Indexed Channel [1 ~ num_bin_by]
bin_wb = floor(norm_wb/q_wb) + 1; % Quantized & Indexed Channel [1 ~ num_bin_wb]

%% Histogram
H = zeros(num_bin_rg, num_bin_by, num_bin_wb);
I_size = size(I);
for i = 1:I_size(1)
    for j = 1:I_size(2)
        H(bin_rg(i,j), bin_by(i,j), bin_wb(i,j)) = H(bin_rg(i,j), bin_by(i,j), bin_wb(i,j)) + 1;
    end
end

%% Show image
subplot(1,2,1);
imshow(uint8(I));

%% Show 3D histogram
S = round((H/max(H(:)))*25); % Matrix normalized to [0 ~ 25]
subplot(1,2,2);
hold on;
for i = 1:num_bin_rg
    for j = 1:num_bin_by
        for k = 1:num_bin_wb
            if S(i,j,k) ~= 0
                plot3(i,j,k,'s','MarkerEdgeColor','k','MarkerFaceColor',[i/num_bin_rg,j/num_bin_by,k/num_bin_wb],'MarkerSize',S(i,j,k));
            end
        end
    end
end
hold off;
grid on;
axis([1 num_bin_rg 1 num_bin_by 1 num_bin_wb]);
xlabel('rg bins');
ylabel('by bins');
zlabel('wb bins');