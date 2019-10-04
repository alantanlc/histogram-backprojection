%% Clear command window and workspace
clear; clc; clf;

%% Read image
I = double(imread('./Training/0.jpg'));
r = I(:,:,1);
g = I(:,:,2);
b = I(:,:,3);

%% Compute color constancy
I_gray = r + g + b;
I_gray(I_gray == 0) = eps('double');
constancy_r = r ./ I_gray;
constancy_g = g ./ I_gray;

%% Quantization
num_bin_r = 8; % Number of bins
num_bin_g = 8; % Number of bins
q_r = 1 / num_bin_r; % Quantization
q_g = 1 / num_bin_g; % Quantization
bin_r = floor(constancy_r/q_r) + 1; % Quantized & Indexed Channel
bin_g = floor(constancy_g/q_g) + 1; % Quantized & Indexed Channel
bin_r(bin_r > num_bin_r) = num_bin_r;
bin_g(bin_g > num_bin_g) = num_bin_g;

%% Histogram
H = zeros(num_bin_r, num_bin_g);
I_size = size(I);
for i = 1:I_size(1)
    for j = 1:I_size(2)
        H(bin_r(i,j), bin_g(i,j)) = H(bin_r(i,j), bin_g(i,j)) + 1;
    end
end

%% Show image
subplot(1,2,1);
imshow(uint8(I));

%% Show histogram
S = round((H/max(H(:)))*25); % Matrix normalized to [0 ~ 25]
subplot(1,2,2);
hold on;
for i = 1:num_bin_r
    for j = 1:num_bin_g
        if S(i,j) ~= 0
           plot(i,j,'s','MarkerEdgeColor','k','MarkerFaceColor',[i/num_bin_r, j/num_bin_g, 0],'MarkerSize',S(i,j));
        end
    end
end
hold off;
grid on;
axis([1 num_bin_r 1 num_bin_g]);
xlabel('r bins');
ylabel('g bins');