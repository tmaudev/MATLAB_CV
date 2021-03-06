function [ image ] = hysteresis( edge_map, mask_size )
%Hysteresis Connects Weak Edges to Strong Edges
%   Returns Better Edge Map

    offset = (mask_size + 1) / 2;
    
    [row, col] = size(edge_map);
    row = row - offset + 1;
    col = col - offset + 1;
    
    for c = offset:col
        for r = offset:row
            
            if edge_map(r, c) == 1
                temp = edge_map(r-offset+1:r+offset-1, c-offset+1:c+offset-1);
                temp(temp <= 0.2 & temp > 0) = 1;
                edge_map(r-offset+1:r+offset-1, c-offset+1:c+offset-1) = temp;
            end
        end
    end
    
    image = edge_map;
end

