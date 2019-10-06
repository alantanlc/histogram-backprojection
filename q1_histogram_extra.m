%% Clear command window and workspace
clear; clc;

%% Set figure window size
set(gcf, 'Position', get(0, 'Screensize'));

%% Read images
files = dir('./Training/*.jpg');
num_files = length(files);
file_names = [];
for i = 1:num_files
    file_names = [file_names; str2num(erase(files(i).name, '.jpg'))];
end
file_names = sort(file_names);

%% Compute and show 3D opponent and 2D color constancy histograms
for n = 1:num_files-1
    %% Clear figure
    clf;
    
    %% Load two images
    I1 = imread(strcat(files(n).folder, '/', num2str(file_names(n)), '.jpg'));
    I2 = imread(strcat(files(n+1).folder, '/', num2str(file_names(n+1)), '.jpg'));
    
    %% Compute 3D opponent histograms
    num_bins_rg = 16;
    num_bins_by = 16;
    num_bins_wb = 8;
    opp_hist_1 = opphist3(I1, num_bins_rg, num_bins_by, num_bins_wb);
    opp_hist_2 = opphist3(I2, num_bins_rg, num_bins_by, num_bins_wb);
    
    %% Compute 2D color constancy histograms
    num_bins_r = 8;
    num_bins_g = 8;
    con_hist_1 = conhist2(I1, num_bins_r, num_bins_g);
    con_hist_2 = conhist2(I2, num_bins_r, num_bins_g);
    
    %% Show images
    subplot(2,3,1);
    imshow(I1);
    subplot(2,3,4);
    imshow(I2);
    
    %% Show 3D opponent histograms
    subplot(2,3,2);
    hold on;
    H = opp_hist_1;
    S = round(H / max(H(:)) * 25); % Matrix normalized to [0 ~ 25]
    for i = 1:num_bins_rg
        for j = 1:num_bins_by
            for k = 1:num_bins_wb
                if S(i,j,k) ~= 0
                    plot3(i,j,k,'s','MarkerEdgeColor','k','MarkerFaceColor',[i/num_bins_rg, j/num_bins_by, k/num_bins_wb],'MarkerSize',S(i,j,k));
                end
            end
        end
    end
    hold off;
    grid on;
    axis([1 num_bins_rg 1 num_bins_by 1 num_bins_wb]);
    xlabel('rg bins');
    ylabel('by bins');
    zlabel('wb bins');
    
    subplot(2,3,5);
    hold on;
    H = opp_hist_2;
    S = round(H / max(H(:)) * 25); % Matrix normalized to [0 ~ 25]
    for i = 1:num_bins_rg
        for j = 1:num_bins_by
            for k = 1:num_bins_wb
                if S(i,j,k) ~= 0
                    plot3(i,j,k,'s','MarkerEdgeColor','k','MarkerFaceColor',[i/num_bins_rg, j/num_bins_by, k/num_bins_wb],'MarkerSize',S(i,j,k));
                end
            end
        end
    end
    hold off;
    grid on;
    axis([1 num_bins_rg 1 num_bins_by 1 num_bins_wb]);
    xlabel('rg bins');
    ylabel('by bins');
    zlabel('wb bins');
    
    % Compute and show 2D color constancy histogram
    subplot(2,3,3);
    hold on;
    H = con_hist_1;
    S = round(H / max(H(:)) * 25); % Matrix normalized to [0 ~ 25]
    for i = 1:num_bins_r
        for j = 1:num_bins_g
            if S(i,j) ~= 0
               plot(i,j,'s','MarkerEdgeColor','k','MarkerFaceColor',[i/num_bins_r, j/num_bins_g, 0],'MarkerSize',S(i,j));
            end
        end
    end
    hold off;
    grid on;
    axis([1 num_bins_r 1 num_bins_g]);
    xlabel('r bins');
    ylabel('g bins');
    
    subplot(2,3,6);
    hold on;
    H = con_hist_2;
    S = round(H / max(H(:)) * 25); % Matrix normalized to [0 ~ 25]
    for i = 1:num_bins_r
        for j = 1:num_bins_g
            if S(i,j) ~= 0
               plot(i,j,'s','MarkerEdgeColor','k','MarkerFaceColor',[i/num_bins_r, j/num_bins_g, 0],'MarkerSize',S(i,j));
            end
        end
    end
    hold off;
    grid on;
    axis([1 num_bins_r 1 num_bins_g]);
    xlabel('r bins');
    ylabel('g bins');
    
    pause;
end
