% Clear command window and workspace
clear; clc;

%% Read images
files = dir('./Training/*.jpg');
num_files = length(files);
file_names = [];
for i = 1:num_files
    file_names = [file_names; str2num(erase(files(i).name, '.jpg'))];
end
file_names = sort(file_names);

%% Compute 3D histograms
num_bins_rg = 16;
num_bins_by = 16;
num_bins_wb = 8;
for i = 1:num_files
    I = imread(strcat(files(i).folder, '/', num2str(file_names(i)), '.jpg'));
    H(:, :, :, i) = opphist3(I, num_bins_rg, num_bins_by, num_bins_wb);
end

%% Compute match values
for i = 1:num_files
    for j = 1:num_files
        M(i,j) = match(H(:,:,:,i), H(:,:,:,j));
    end
end

%% Display histogram intersection matrix
S = round(M * 7);  % Matrix normalized to [0 ~ 7]
clf;
hold on;
axis ij;
axis([1 num_files 1 num_files]);
set(gca, 'xaxisLocation', 'top')
for i = 1:num_files
    for j = 1:num_files
        if S(i,j) ~= 0
           plot(i,j,'square','MarkerEdgeColor','none','MarkerFaceColor','k','MarkerSize',S(i,j));
        end
    end
end
hold off;
