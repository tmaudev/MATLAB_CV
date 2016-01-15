boat = imread('Boat2.tif');
building = imread('building.gif');
window = imread('corner_window.jpg');
window_gray = rgb2gray(window);
corridor = imread('corridor.jpg');
corridor_gray = rgb2gray(corridor);
nyc = imread('New York City.jpg');
tree = imread('tree.jpg');

mask_dim = 3;
log_dim = 5;
log_sd = sqrt(2);
sigma = 0.9;
mask1 = 1/(mask_dim ^ 2) * ones(mask_dim, mask_dim);
mask_gauss = fspecial('gaussian', mask_dim, sigma);
mask_prewitt_h = 1.0 * ones(3, 1) * [-1, 0, 1];
mask_prewitt_v = 1.0 * [-1; 0; 1] * ones(1, 3);
mask_sobel_h = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
mask_sobel_v = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
mask_log = LoGFilter(log_dim, log_sd);

test_avg = convolution(boat, mask1);
test_median = medianFilter(boat, mask_dim);
test_gauss = convolution(boat, mask_gauss);
test_prewitt = differentiation(corridor_gray, mask_prewitt_v, mask_prewitt_h);
test_sobel = differentiation(corridor_gray, mask_sobel_v, mask_sobel_h);
test_log = convolution(window_gray, mask_log);

figure(1), imshow(test_avg);
figure(2), imshow(test_median);
figure(3), imshow(test_gauss);
figure(4), imshow(test_prewitt);
figure(5), imshow(test_sobel);
figure(6), imshow(test_log);