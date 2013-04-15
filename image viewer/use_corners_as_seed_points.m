function [ img_bin ] = use_corners_as_seed_points( img, points, second_threshold)
%USE_CORNERS_AS_SEED_POINTS Summary of this function goes here
%  given an initial set of seed points. This function uses the
%  second_threshold to calculate another set of seed points
% the final step is to perform the seed filling based on the new set of
% seed points and filter them by the first computed threshold.

    pixelmode_8n = 1;
    darkerToWhite = 1;
  
    [imy,imx] = size(img);
    
    img_bin = ones(imy,imx);



    [y,x] = size(points)
    values = ones(y,1);
    
    
    
    %get the values from the points
    for (j = 1:y)
        xl = points(j,1);
        yl = points(j,2);
        values(j,1) = img(yl,xl);
    end
    
     figure;hist(values)
       % get the binarized values
     returnThreshold = 1;
     threshold = otsu(uint8(values), returnThreshold );

     addpath fast
     low_thresh_seed_points = fast9(img, second_threshold);
     rmpath fast
     [y,x] = size(low_thresh_seed_points)
     %floodfill the corners based on where they are 

     
    for  j = 1:y 
        xl = low_thresh_seed_points(j,1);
        yl = low_thresh_seed_points(j,2);
        xl
        yl
        %only flood foreground pixels that have not alraedy been flooded
        if ( img(yl,xl) < threshold &&  img(yl,xl) ~= 255 )
            tic;
            fg_points = cell_propagate(img, [ xl, yl] , pixelmode_8n, darkerToWhite);
            img_bin(fg_points(:)) = 0;
            toc;
        end
     
        
    end

    result = img_bin;


end

