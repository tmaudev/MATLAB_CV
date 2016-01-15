function [ v, h ] = differentiation( original, mask_v, mask_h )
%Differentiation Derivative Approximation (Horizontal and Vertical)
%   Calculates Image Gradients

    v = convolution(original, mask_v);
    h = convolution(original, mask_h);
    
end
