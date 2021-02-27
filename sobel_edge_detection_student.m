% sobel_edge_detection tutorial

I = rgb2gray(imread('cat2.jpg'));
original = I    % Keep the original photo
I = double(I);  % read image
Ix = I;         % Matrix containing horizontal gradient of I
Iy = I;         % Matrix containing vertical gradient of I
In = I;         % copy image for convolution

% Sobel Edge Detector kernel

%%%%%%%%%%%%%%%%%%%%%%%
%%% Write your code %%%
%%%%%%%%%%%%%%%%%%%%%%%

% Convolution 

%%%%%%%%%%%%%%%%%%%%%%%
%%% Write your code %%%
%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
imshow(original)
title('original')
figure(2)
imshow(uint8(I))
title('Sobel Edge Detector')
figure(3)
imshow(uint8(Ix))
title('X gradient')
figure(4)
imshow(uint8(Iy))
title('y gradient')
