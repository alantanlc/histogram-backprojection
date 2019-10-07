% Clear command window and workspace
clear; clc; clf;

% Read in model and test images
M_files = [0, 4, 14, 16, 65, 44, 50, 103, 172, 53];
I_files = [128, 128, 132, 132, 133, 139, 154, 161, 175, 189];

for i = 1:length(M_files)
    %% Read in model and test images
    M = imread(strcat('./Training/', num2str(M_files(i)), '.jpg'));
    I = imread(strcat('./TestScenes/', num2str(I_files(i)), '.jpg'));
    
    %% Backprojection
    num_bins_rg = 16;
    num_bins_by = 16;
    num_bins_wb = 8;
    radius = 370;
    [J, B, x, y, m] = backproject(M, I, radius, num_bins_rg, num_bins_by, num_bins_wb);

    %% Display results
    set(gcf, 'Position', get(0, 'Screensize'));
    subplot(2,2,1);
    imshow(M);
    title('Model');
    subplot(2,2,2);
    imshow(I);
    title('Test');
    subplot(2,2,3);
    imshow(J, []);
    title('Backprojected image');
    subplot(2,2,4);
    imshow(B, []);
    hold on;
    axis ij;
    plot(x,y,'r+','MarkerSize',30,'LineWidth',2);
    title(['Convolution with disc kernel of radius ', num2str(radius)]);
    linkaxes;
    
    %% Pause
    pause;
end