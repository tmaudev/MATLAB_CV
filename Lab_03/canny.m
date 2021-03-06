function [ image ] = canny( original, mask_size, sobel_threshold, sigma, t_low, t_high )
%Canny Canny Edge Detection Implementation
%   Produced Edge Highlighted Image

    % Step 1: Perform Gaussian Filtering to Remove Noise
    mask_gauss = fspecial('gaussian', mask_size, sigma);
    smooth_image = convolution(original, mask_gauss);
    
    % Step 2: Gradient Approximation (Sobel Operator)
    [gradient_image, v, h] = sobel(smooth_image, sobel_threshold, 0);

    % Step 3: Edge Direction
    angles = radtodeg(atan2(v, h));
    angles(angles < 0) = angles(angles < 0) + 180;
    
    % Step 4: Edge Direction Approximation for Image Tracing
    angles(angles < 22.5 & angles > 0) = 0;
    angles(angles < 180 & angles > 157.5) = 0;
    angles(angles < 67.5 & angles > 22.5) = 45;
    angles(angles < 112.5 & angles > 67.5) = 90;
    angles(angles < 157.5 & angles > 112.5) = 135;
    
    % Step 5: Non-Maximum Suppression
    suppressed_image = nonMaxSuppression(gradient_image, angles, mask_size);
    image = suppressed_image;
    
    % Step 6: Double Thresholding
    image(image < t_low) = 0;
    image(image < t_high & image > t_low) = 0.2;
    image(image > t_high) = 1;
    
    image = hysteresis(image, mask_size);
    image = (image == 1);
    
end

