function [ B, I, J ] = findMinIndex( picture )
%FindMinIndex Finds the minimum value in a matrix.
%   Returns first occurrence of minimum value.
    [B, I] = min(picture(:));
    [I, J] = ind2sub(size(picture), I);
end
