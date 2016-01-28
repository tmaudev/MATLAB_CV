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
            temp = image(r-offset+1:r+offset-1, c-offset+1:c+offset-1);
            temp(offset, offset) = 0;

            diag_mask = ones(mask_size, mask_size);
            diag_mask(logical(eye(size(diag_mask)))) = 0;
            
            if angles(r, c) == 0
                if image(r, c) <= max(temp(offset, :))
                    image(r, c) = 0;
                else
                    temp = image(r, c);
                    image(r, c - offset + 1: c + offset - 1) = 0;
                    image(r, c) = temp;
                end
            elseif angles(r, c) == 45
                temp = rot90(temp);
                
                if image(r, c) <= max(diag(temp))
                    image(r, c) = 0;
                else
                    temp = image(r, c);
                    image(r - offset + 1 : r + offset - 1, c - offset + 1 : c + offset - 1) =...
                        image(r - offset + 1 : r + offset - 1, c - offset + 1 : c + offset - 1) .* diag_mask;
                    image(r, c) = temp;
                end
            elseif angles(r, c) == 90
                if image(r, c) <= max(temp(:, offset))
                    image(r, c) = 0;
                else
                    temp = image(r, c);
                    image(r - offset + 1 : r + offset - 1, c) = 0;
                    image(r, c) = temp;
                end
            elseif angles(r, c) == 135
                if image(r, c) <= max(diag(temp))
                    image(r, c) = 0;
                else
                    temp = image(r, c);
                    image(r - offset + 1 : r + offset - 1, c - offset + 1 : c + offset - 1) =...
                        image(r - offset + 1 : r + offset - 1, c - offset + 1 : c + offset - 1) .* diag_mask;
                    image(r, c) = temp;
                end
            end
        end
    end
end

