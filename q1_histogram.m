%% Clear command window and workspace
clear; clc; clf;

%% Read Image
I = imread('./Training/0.jpg');

%% Compute 3D opponent color histogram
num_bins_rg = 16;
num_bins_by = 16;
num_bins_wb = 8;
H1 = opphist3(I, num_bins_rg, num_bins_by, num_bins_wb);

%% Compute 2D color constancy histogram
num_bins_r = 8;
num_bins_g = 8;
H2 = conhist2(I, num_bins_r, num_bins_g);

%% Show image
set(gcf, 'Position', [0 250 2000 500]);
subplot(1,3,1);
imshow(I);

%% Show 3D histogram
S = round(H1 / max(H1(:)) * 25); % Matrix normalized to [0 ~ 25]
subplot(1,3,2);
hold on;
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

%% Show 2D histogram
S = round(H2 / max(H2(:)) * 25); % Matrix normalized to [0 ~ 25]
subplot(1,3,3);
hold on;
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
