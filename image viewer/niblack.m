%%ADAPTED FROM: http://stackoverflow.com/questions/9871084/niblack-thresholding %%
% define parameters
function [result_bin] = niblack(original_img)
filt_radius = 25; % filter radius [pixels]
k_threshold = 0.2; % std threshold parameter

%% load the image
result = double(original_img); 
result = result ./ max(result(:)); % normalyze to [0, 1] range


%% build filter
fgrid = -filt_radius : filt_radius;
[x, y] = meshgrid(fgrid);
filt = sqrt(x .^ 2 + y .^ 2) <= filt_radius;
filt = filt / sum(filt(:));

%% calculate mean, and std
local_mean = imfilter(result, filt, 'symmetric');
local_std = sqrt(imfilter(result .^ 2, filt, 'symmetric'));

%% calculate binary image
result_bin = result >= (local_mean + k_threshold * local_std);


