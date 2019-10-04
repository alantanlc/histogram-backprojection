%% Representation of the quantized 3D joint RGB histogram
% This code plots a qualitative 3D RGB Histogram
% In the result figure, each square represent a non-empty seed in the quantized 3D joint RGB histogram 
% which its area is proportional to the value of the corresponding seed in the histogram.
% The code waits for user input (to select an area) , processes the input and plots the result
% Alireza Asvadi
% http://www.a-asvadi.ir
% 2013
% Questions regarding the code may be directed to alireza.asvadi@gmail.com
clear; clc; clf;
%% Read Image
I    = imread('./Training/0.jpg'); 
%% QUANTIZATION
B     = 8;                                                % Number of Bins
Q     = 256/B;                                            % Quantization
SI    = (floor(double(I)/Q))+1;                           % Quantized & Indexed Image [1 ~ Bin]
%% HISTOGRAM
H     = zeros(B,B,B);   % Object Histogram
I_SIZE = size(I);
for i = 1:I_SIZE(1)                                          % Number Of Rows
    for j = 1:I_SIZE(2)                                           % Number Of Columns
       H(SI(i,j,1),SI(i,j,2),SI(i,j,3)) = H(SI(i,j,1),SI(i,j,2),SI(i,j,3))+1;
    end
end
%% SHOW
S =  round((H/max(H(:)))*25);                             % Matrix normalized to [0 ~ 25]
hold on
for i = 1:B
    for j = 1:B
        for k = 1:B            
            if S(i,j,k) ~= 0    
            plot3(i,j,k,'s','MarkerEdgeColor','k','MarkerFaceColor',[i,j,k]/B,'MarkerSize',S(i,j,k)) % try 'o'
            end
        end
    end    
end
hold off
grid on
axis([1 B 1 B 1 B]);
xlabel('Red.Bins')
ylabel('Green.Bins')
zlabel('Blue.Bins')