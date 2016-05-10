close all;
image = imread('go1.jpg');
template_b = imread('blackTemp.jpg');
template_w = imread('whiteTemp.jpg');
image_orig = image;
image = rgb2gray(image);
template_b = rgb2gray(template_b);
template_w = rgb2gray(template_w);

%Apply Gaussian Filter to Image and Templates
image = imgaussfilt(image, 1);
template_b = imgaussfilt(template_b, 1);
template_w = imgaussfilt(template_w, 1);

%Threshold Image
image(image > 40 & image < 210) = 130;
image(image <= 40) = 0;
image(image >= 220) = 255;

%Threshold Templates
template_b(template_b > 40 & template_b < 210) = 130;
template_b(template_b <= 40) = 0;
template_b(template_b >= 220) = 255;

template_w(template_w > 40 & template_w < 210) = 130;
template_w(template_w <= 40) = 0;
template_w(template_w >= 220) = 255;

figure(1), imshow(image);

%Perform Template Matching
corr_b = normxcorr2(template_b, image);
figure(2), imshow(corr_b);

%Apply Median Filter to Feature Space
corr_b = medfilt2(corr_b, [11, 11]);
figure(3), imshow(corr_b);

%Threshold Feature Space
corr_b = corr_b > 0.44;

%Perform Template Matching
corr_w = normxcorr2(template_w, image);

%Apply Median Filter to Feature Space
corr_w = medfilt2(corr_w, [11, 11]);
figure(4), imshow(corr_w);

%Threshold Feature Space
corr_w = corr_w > 0.44;

%Perform Connected-Component Analysis
stats_b = regionprops(corr_b, 'centroid');
centroids_b = cat(1, stats_b.Centroid);
hFig1 = figure(5);
hAx1 = axes;
imshow(image_orig,'Parent',hAx1);

%%Draw Rectangles on Image
for i = 1:size(centroids_b,1)
    imrect(hAx1, [centroids_b(i,1) - size(template_b,2),...
        centroids_b(i,2) - size(template_b,1),...
        size(template_b,2), size(template_b,1)]);
end

%Perform Connected-Component Analysis
stats_w = regionprops(corr_w, 'centroid');
centroids_w = cat(1, stats_w.Centroid);

hFig2 = figure(6);
hAx2 = axes;
imshow(image_orig,'Parent',hAx2);

%%Draw Rectangles on Image
for i = 1:size(centroids_w,1)
    imrect(hAx2, [centroids_w(i,1) - size(template_w,2),...
        centroids_w(i,2) - size(template_w,1),...
        size(template_w,2), size(template_w,1)]);
end