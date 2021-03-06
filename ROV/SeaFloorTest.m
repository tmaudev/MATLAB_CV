clear;
close all;

floor = imread('SeaFloor.jpg');
floor_1 = imread('SeaFloor_2.jpg');
floor_2 = imread('SeaFloor_1.jpg');

floor_gray = rgb2gray(floor);
floor_gray_1 = rgb2gray(floor_1);
floor_gray_2 = rgb2gray(floor_2);

floor_median = medianFilter(floor_gray, 9);
floor_median_1 = medianFilter(floor_gray_1, 9);
floor_median_2 = medianFilter(floor_gray_2, 9);

points_1 = detectSURFFeatures(floor_median_1);
points_2 = detectSURFFeatures(floor_median_2);

figure(1), subplot(3,2,1), imshow(floor_1);
title('Original #1');
figure(1), subplot(3,2,2), imshow(floor_2);
title('Original #2');

figure(1), subplot(3,2,3), imshow(floor_gray_1);
title('Grayscale #1');
figure(1), subplot(3,2,4), imshow(floor_gray_2);
title('Grayscale #2');

figure(1), subplot(3,2,5), imshow(floor_median_1);
title('Median Filtered #1');
figure(1), subplot(3,2,6), imshow(floor_median_2);
title('Median Filtered #2');

figure(2), subplot(1,2,1), imshow(floor_1);
title('Features #1');
hold on;
points_1 = selectStrongest(points_1, 50);
plot(points_1);

figure(2), subplot(1,2,2), imshow(floor_2);
title('Features #2');
hold on;
points_2 = selectStrongest(points_2, 50);
plot(points_2);

[features_1, points_1] = extractFeatures(floor_median_1, points_1);
[features_2, points_2] = extractFeatures(floor_median_2, points_2);

pairs = matchFeatures(features_1, features_2);

matched_1 = points_1(pairs(:,1), :);
matched_2 = points_2(pairs(:,2), :);

[tform, inliers_1, inliers_2] = ...
    estimateGeometricTransform(matched_1, matched_2, 'affine');

figure(3), showMatchedFeatures(floor_1, floor_2, inliers_1,...
    inliers_2, 'montage');
title('Matched Features');

total_x = 0;
total_y = 0;
for k = 1 : length(matched_1)
    point_x1 = matched_1(k).Location;
    point_y1 = matched_1(k).Location;
    point_x2 = matched_2(k).Location;
    point_y2 = matched_2(k).Location;
    
    x_diff = point_x2(1,1) - point_x1(1,1);
    y_diff = point_y2(1,2) - point_y1(1,2);
    
    total_x = total_x + x_diff;
    total_y = total_y + y_diff;
end

avg_x = total_x / length(matched_1);
avg_y = total_y / length(matched_1);

pixel_distance = sqrt(avg_x^2 + avg_y^2);
distance_label = sprintf('Distance Approximation: %0.2f Pixels',...
    pixel_distance);
image_size = size(floor_1);
label = text(0, image_size(1,1) + 14, distance_label);
label.FontSize = 14;