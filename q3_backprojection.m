% Clear command window and workspace
clear; clc; clf;

% Read in model and test images
M = imread('./Training/16.jpg');
I = imread('./TestScenes/132.jpg');

%% Backprojection
num_bins_rg = 16;
num_bins_by = 16;
num_bins_wb = 8;
J = backproject(M, I, num_bins_rg, num_bins_by, num_bins_wb);

%% Display resulting backprojected image
set(gcf, 'Position', get(0, 'Screensize'));
subplot(1,3,1);
imshow(M);
subplot(1,3,2);
imshow(I);
subplot(1,3,3);
imshow(J);