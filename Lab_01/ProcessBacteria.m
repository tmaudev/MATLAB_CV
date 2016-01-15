bacteria = imread('bacteria.bmp');          % Read in image
bacteria_binary = bacteria < 102;           % Create binary image (thresholding)
bacteria_label = bwlabel(bacteria_binary);  % Create labeled image
rgb_bacteria = label2rgb(bacteria_label);   % Create visual labeled image (colors)

tot_area = sum(bacteria_binary(:));         % Calculate area of all bacteria
fprintf('Total Area: %d\n\n', tot_area);

bacteria_areas = regionprops(bacteria_binary, 'Area'); % Find areas of each individual bacteria

% Print out areas of each bacteria
total = 0;
fprintf('Bacteria Areas:\n');
for n = 1:21
    area = bacteria_areas(n).Area;
    total = total + area;
    fprintf('%d: %d\n', n, area);
end

fprintf('Confirm Total Area: %d = %d\n\n', total, tot_area);
