function [ image, v, h ] = sobel( original, threshold_percent, t_flag )
%Sobel Sobel Operator Implementation
%   Estimates Gradient of Image

    mask_sobel_h = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
    mask_sobel_v = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
    
    [v, h] = differentiation(original, mask_sobel_v, mask_sobel_h);
    image = sqrt(v .^ 2 + h .^ 2);
    
    if t_flag == 1
        image = image > threshold_percent * max(image(:));
    end
end
