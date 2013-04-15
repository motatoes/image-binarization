function [  ] = bulk_corner_thresh( images, first_thresh, second_thresh, output_folder )
%BULK_CORNER_THRESH Summary of this function goes here
%   Detailed explanation goes here
    
    [imy,imx] = size(images);
    for i=1:imy
         img = double(rgb2gray(imread(images{i})));

        %initial corner thresholding to find the histogram
        addpath fast
        seed_points = fast9(img,first_thresh);
        rmpath fast
        [y,x] = size(seed_points)
% 
%         for j=1:y
%             xl = seed_points(j,1);
%             yl = seed_points(j,2);
%             orig_img(yl:yl+3,xl:xl+3) =  255 ;
%             result = orig_img;
%         end
           strcat(output_folder,num2str(i) )
        img_bin = use_corners_as_seed_points( img, seed_points, second_thresh);
        imwrite(img_bin, strcat(output_folder,num2str(i),'.tiff'), 'tiff');
    end  
end

