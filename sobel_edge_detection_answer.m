% Sobel_edge_detection full answer

I = rgb2gray(imread('giraffe.jpeg'));
original = I % Keep the original photo
I = double(I); % read image
Ix = I;
Iy = I; 
In = I;                 % copy image for convolution

% Sobel Edge Detector kernel
mask_x = [-1, 0, 1; -2, 0, 2;-1, 0, 1]; % 3x3 mask for vertical edges
mask_y = [-1, -2, -1; 0, 0, 0; 1, 2, 1]; % 3x3 mask for horizontal edges



% Convolution 
for i=2:size(I, 1) - 1
    for j=2:size(I, 2)-1
        matrix_x = mask_x.*In(i-1:i+1, j-1:j+1);
        matrix_y = mask_y.*In(i-1:i+1, j-1:j+1);
        avg_value_x=sum(matrix_x(:));
        avg_value_y=sum(matrix_y(:));
        I(i, j) = sqrt(avg_value_x^2 + avg_value_y^2);
        Ix(i, j) = avg_value_x;
        Iy(i, j) = avg_value_y;
    end
end

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
