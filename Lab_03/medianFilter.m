function [ image ] = medianFilter( original, mask_size )
%MedianFilter Median Filter Implementation
%   Filters Image with Odd, Square Filter Mask.

    offset = (mask_size + 1) / 2;
    
    image = original;
    [row, col] = size(original);
    row = row - offset + 1;
    col = col - offset + 1;
    
    for c = offset:col
        for r = offset:row
            temp = original(r-offset+1:r+offset-1, c-offset+1:c+offset-1);
            value = median(temp(:));

            image(r, c) = value;
        end
    end
end