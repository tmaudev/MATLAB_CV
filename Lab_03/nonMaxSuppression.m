function [ image ] = nonMaxSuppression( original, angles, mask_size )
%NonMaxSuppression Suppress Non-Edge Pixels
%   Thins Edge Lines

    offset = (mask_size + 1) / 2;
    
    image = original;
    [row, col] = size(original);
    row = row - offset + 1;
    col = col - offset + 1;
    
    for c = offset:col
        for r = offset:row
            temp = original(r-offset+1:r+offset-1, c-offset+1:c+offset-1);
            value = median(temp(:));

            if angles(r, c) == 0
                if original(r, c) < max(temp(offset, :))
                    image(r, c) = 0;
                end
            elseif angles(r, c) == 45
                temp = rot90(temp);
                
                if original(r, c) < max(diag(temp))
                    image(r, c) = 0;
                end
            elseif angles(r, c) == 90
                if original(r, c) < max(temp(:, offset))
                    image(r, c) = 0;
                end
            elseif angles(r, c) == 135
                if original(r, c) < max(diag(temp))
                    image(r, c) = 0;
                end
            end
        end
    end
end

