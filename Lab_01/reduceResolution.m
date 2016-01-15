function [ img ] = reduceResolution( picture )
%ReduceResolution Reduces resolution of image.
%   Skips every other pixel to reduce resolution by a factor of 2.

    [row, col] = size(picture);
    img = picture(1:2:row, 1:2:col);
end

