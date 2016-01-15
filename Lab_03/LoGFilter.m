function [ filter ] = LoGFilter( mask_size, sd )
%LoGFilter Return Laplacian of Gaussian Filter
%   Calculated based on standard deviation.

    gaussian_mask = fspecial('gaussian', mask_size, sd);
    laplacian_mask = fspecial('laplacian');
    
    filter = convolution(gaussian_mask, laplacian_mask);

end
