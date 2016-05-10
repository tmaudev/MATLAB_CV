close all;
image = imread('go1.jpg');
template = imread('whiteTemp.jpg');
image = rgb2gray(image);
template = rgb2gray(template);

corr = normxcorr2(template, image); %Perform template matching
figure(231),imshow(corr)

corr(corr < .57) = 0; %retain higher values
figure(213125), imshow(corr);

peaks = imregionalmax(corr);
figure(321321),imshow(peaks)

[y, x] = find(peaks); %Find peaks in imag
yNew = y - size(template,1); %Shift x and y due to template matching offset
xNew = x - size(template,2);

hFig = figure(21314);
hAx = axes;
imshow(image,'Parent',hAx);

%%Draw rectangles on image
for i = 1:size(x,1)
    imrect(hAx, [xNew(i),yNew(i), size(template,2), size(template,1)]);
end