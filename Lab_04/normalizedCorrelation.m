function [ output_args ] = normalizedCorrelation( original, template )
%NormalizedCorrelation Performs a Normalized Correlation
%   Used for Template Matching

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

