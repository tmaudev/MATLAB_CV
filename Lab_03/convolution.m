function [ image ] = convolution( original, mask )
%Convolution Matrix Convolution Implementation
%   Performs Convolution with Odd, Square Filter Mask.

    [mask_row, mask_col] = size(mask);
    
    offset = (mask_row + 1) / 2;
    
    original = im2double(original);
    image = original;
    
    [row, col] = size(original);
    row = row - offset + 1;
    col = col - offset + 1;
    
    for c = offset:col
        for r = offset:row
            
            temp = original(r-offset+1:r+offset-1, c-offset+1:c+offset-1) .* mask;
            value = sum(temp(:));

            image(r, c) = value;
        end
    end
end