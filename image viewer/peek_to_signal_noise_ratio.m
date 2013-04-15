function [ result ] = peek_to_signal_noise_ratio( img1, img2 )
%PEEK_TO_SIGNAL_NOISE_RATIO Summary of this function goes here
%   Detailed explanation goes here
    %PSNR = 10 log (C^2 / MSE)
    %MSE = (sum of difference between the two images)/number of elements
  
    C = 1;

    diff = (img1 - img2) .^ 2;
    sigma = sum(diff(:))
    [nelems, ~] = size(img1(:))
    MSE = sigma/nelems;
    
    
    result = 10 * log(C .^ 2 / MSE);
    

end

