%%% Canny Edge Detector Full Answer

%% 0. import a picture
I = imread('giraffe.jpeg');
width = size(I,1);
height = size(I,2);

%%%%%%
figure(1)
imshow(I)
title('original image')
%%%%%%

%% 1. convert RGB to grayscale
Igray = rgb2gray(I)

%%%%%%
figure(2)
imshow(Igray)
title('grayscale')
%%%%%%

I = double(Igray); % convert the values for image matrix into double for convolution later
Icopy = I;     % image copy for convolution

%% 2. Apply Gaussian filter for smoothing (removing noise in the photo)

% Gaussian filter parameters
k = 2;                % the size of kernel (2k+1, 2k+1)
sigma = 1.2;            % Standard Deviation
B = zeros(2*k+1, 2*k+1); % initialise the Gaussian Kernel matrix

% Filter value assignment

%%%%%%%%%%%%%%%%%%%%%%%
%%% Write your code %%%
%%%%%%%%%%%%%%%%%%%%%%%


% Convolution Image with Gaussian Filter

%%%%%%%%%%%%%%%%%%%%%%%
%%% Write your code %%%
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%
pause(1)
figure(3)
imshow(uint8(I))
title("gaussian filter applied")
%%%%%%

%% 3. Finding the intensity gradient of the image (edge detection)

% Sobel Edge Detector kernel
mask_x = [-1, 0, 1; -2, 0, 2;-1, 0, 1];  % 3x3 mask for vertical edges
mask_y = [-1, -2, -1; 0, 0, 0; 1, 2, 1]; % 3x3 mask for horizontal edges
angle = zeros(width, height);     % initialisation of angle of gradient matrix (used for edge thinning)

G = I;
Ix = I; % Ix is the matrix to show the horizontal gradient of I
Iy = I; % Iy is the matrix to show the vertical gradient of I

% Convolution

%%%%%%%%%%%%%%%%%%%%%%%
%%% Write your code %%%
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%
pause(1)
figure(4)
imshow(uint8(Ix))
title('X gradient')

pause(1)
figure(5)
imshow(uint8(Iy))
title('y gradient')

pause(1)
figure(6)
imshow(uint8(G))
title('Sobel Edge Detector')
%%%%%%

%% 4. Gradient magnitude thresholding or lower bound cut-off suppression (edge thinning)

% angle reassigning to 0, 45, 90, 135 (horizontal, vertical, two diagonals)

%%%%%%%%%%%%%%%%%%%%%%%
%%% Write your code %%%
%%%%%%%%%%%%%%%%%%%%%%%

% Non-Maximum Supression
BW = zeros(width, height) % A matrix to contain edge information after non-maximum supression

%%%%%%%%%%%%%%%%%%%%%%%
%%% Write your code %%%
%%%%%%%%%%%%%%%%%%%%%%%

            
BW = BW.*G;
pause(1)
figure(7)
imshow(uint8(BW))
title('Edge Thinned')



%% 5. Double Thresholding

%Value for Thresholding
T_Low = 0.1;
T_High = 0.4;

T_Low = T_Low * max(max(BW)); % Lower Bound Threshold
T_High = T_High * max(max(BW)); % Higher Bound Threshold
T_res = zeros(width, height);

%%%%%%%%%%%%%%%%%%%%%%%
%%% Write your code %%%
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%
pause(1)
figure(8)
imshow(uint8(T_res.*255))
title("Double Threshold applied")
%%%%%%

%% 6. Hysteresis Thresholding

%%%%%%%%%%%%%%%%%%%%%%%
%%% Write your code %%%
%%%%%%%%%%%%%%%%%%%%%%%

final = uint8(T_res.*255);

%%%%%%
pause(1)
figure(9)
imshow(final)
title("Final filtered image")
%%%%%%
