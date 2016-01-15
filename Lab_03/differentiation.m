function [ image ] = differentiation( original, mask_v, mask_h )
%Differentiation Produces Derivative Approximation Image
%   Calculates Image Gradients

    v = convolution(original, mask_v);
    h = convolution(original, mask_h);

    image = sqrt(v .^ 2 + h .^ 2);
    
end
