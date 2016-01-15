function [ B, I, J ] = findMaxIndex( picture )
%FindMaxIndex Finds the maximum value in a matrix.
%   Returns first occurrence of maximum value.
    [B, I] = max(picture(:));
    [I, J] = ind2sub(size(picture), I);
end
