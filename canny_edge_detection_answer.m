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
for i=1:2*k+1
    for j=1:2*k+1
        B(i,j) = exp(-((i-(k+1))^2+(j-(k+1))^2)/(2*sigma^2))/(2*pi*sigma^2);
    end
end

% Convolution Image with Gaussian Filter
for i=k+1:width - k
    for j=k+1:height-k
        gaussian_filtered = B.*Icopy(i-k:i+k, j-k:j+k);
        avg_value_g=sum(gaussian_filtered(:));
        I(i, j) = avg_value_g;
    end
end

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
Ix = I;
Iy = I; 

% Convolution
for i=2:width-1
    for j=2:height-1
        matrix_x = mask_x.*Icopy(i-1:i+1, j-1:j+1);
        matrix_y = mask_y.*Icopy(i-1:i+1, j-1:j+1);
        Gx=sum(matrix_x(:));
        Gy=sum(matrix_y(:));
        G(i, j) = sqrt(Gx^2 + Gy^2);
        Ix(i, j) = Gx;
        Iy(i, j) = Gy;
        angle(i,j) = atan2(Gy, Gx);
    end
end


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
angle2 = zeros(width, height);
for i=1:width
    for j=1:height
        if ((angle(i, j) >= -pi/8 ) && (angle(i, j) < pi/8) || (angle(i, j) >= 7*pi/8) && (angle(i, j) < -7*pi/8 ))
            angle2(i, j) = 0;
        elseif ((angle(i, j) >= pi/8) && (angle(i, j) < 3*pi/8) || (angle(i, j) >= -7*pi/8) && (angle(i, j) < -5*pi/8))
            angle2(i, j) = pi/4;
        elseif ((angle(i, j) >= 3*pi/8 && angle(i, j) < 5*pi/8) || (angle(i, j) >= -5*pi/8 && angle(i, j) < -3*pi/8))
            angle2(i, j) = pi/2;
        elseif ((angle(i, j) >= 5*pi/8 && angle(i, j) < 7*pi/8) || (angle(i, j) >= -3*pi/8 && angle(i, j) < -pi/8))
            angle2(i, j) = 3*pi/4;
        end;
    end;
end;

% Non-Maximum Supression
BW = zeros(width, height)
for i=2:width-1
    for j=2:height-1
        if (angle2(i,j)==0)
            BW(i,j) = (G(i,j) == max([G(i,j), G(i,j+1), G(i,j-1)]));
        elseif (angle2(i,j)==pi/4)
            BW(i,j) = (G(i,j) == max([G(i,j), G(i+1,j-1), G(i-1,j+1)]));
        elseif (angle2(i,j)==pi/2)
            BW(i,j) = (G(i,j) == max([G(i,j), G(i+1,j), G(i-1,j)]));
        elseif (angle2(i,j)==3*pi/4)
            BW(i,j) = (G(i,j) == max([G(i,j), G(i+1,j+1), G(i-1,j-1)]));
        end;
    end;
end;
            
BW = BW.*G;
pause(1)
figure(7)
imshow(uint8(BW))
title('Edge Thinned')



%% 5. Double Thresholding

%Value for Thresholding
T_Low = 0.1;
T_High = 0.2;

T_Low = T_Low * max(max(BW));
T_High = T_High * max(max(BW));
T_res = zeros(width, height);
for i = 1:width
    for j = 1:height
        
        if (BW(i, j) < T_Low)
            T_res(i, j) = 0;
        elseif (BW(i,j) <= T_High && BW(i,j) > T_Low)
            T_res(i, j) = 0.5;
        elseif (BW(i, j) > T_High)
            T_res(i, j) = 1;
            
        %Using 8-connected components
        end;
    end;
end;

%%%%%%
pause(1)
figure(8)
imshow(uint8(T_res.*255))
title("Double Threshold applied")
%%%%%%

%% 6. Hysteresis Thresholding
for i = 1:width
    for j = 1:height
       
        %Using 8-connected components
        if (T_res(i, j) == 0.5)
            if ( BW(i+1,j)>T_High || BW(i-1,j)>T_High || BW(i,j+1)>T_High || BW(i,j-1)>T_High || BW(i-1, j-1)>T_High || BW(i-1, j+1)>T_High || BW(i+1, j+1)>T_High || BW(i+1, j-1)>T_High)
                T_res(i,j) = 1;
            else
                T_res(i,j) = 0;
            end;
        end;
    end;
end;

final = uint8(T_res.*255);

%%%%%%
pause(1)
figure(9)
imshow(final)
title("Final filtered image")
%%%%%%
