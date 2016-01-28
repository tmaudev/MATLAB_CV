clear;
close all;

boat = imread('Boat2.tif');
building = imread('building.gif');
window = imread('corner_window.jpg');
window_gray = rgb2gray(window);
corridor = imread('corridor.jpg');
corridor_gray = rgb2gray(corridor);
nyc = imread('New York City.jpg');
tree = imread('tree.jpg');

mask_dim = 5;
log_dim = 5;
log_sd = sqrt(2);
sigma = 0.9;
mask1 = 1/(mask_dim ^ 2) * ones(mask_dim, mask_dim);
mask_gauss = fspecial('gaussian', mask_dim, sigma);
mask_log = fspecial('log', log_dim, log_sd);

test_avg = convolution(boat, mask1);
test_median = medianFilter(boat, mask_dim);
test_gauss = convolution(boat, mask_gauss);

test_prewitt = prewitt(corridor_gray, 0.2);
test_sobel = sobel(corridor_gray, 0.17, 1);

test_log = convolution(window_gray, mask_log);
test_canny = canny(corridor_gray, mask_dim, 0.17, 1.4, 0.2, 0.3);

figure(1), subplot(221), imshow(test_avg);
title('Average Filter');
figure(1), subplot(222), imshow(test_median);
title('Median Filter');
figure(1), subplot(223), imshow(test_gauss);
title('Gaussian Filter');
figure(2), subplot(221), imshow(test_prewitt);
title('Prewitt');
figure(2), subplot(222), imshow(test_sobel);
title('Sobel');
figure(2), subplot(223), imshow(test_log, []);
title('Laplacian of Gaussian');
figure(2), subplot(224), imshow(test_canny);
title('Canny');