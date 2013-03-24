%%ADAPTED FROM: http://stackoverflow.com/questions/10303229/implementing-otsu-binarization-for-faded-images-of-documents

function [result_bin] = otsu(I)

nbins = 256; % Number of bins
counts = imhist(I,nbins)  % Each intensity increments the histogram from 0 to 255
p = counts / sum(counts); % Probabilities

omega1 = 0;
omega2 = 1;
mu1 = 0;
mu2 = mean(I(:));

for t = 1:nbins
    omega1(t) = sum(p(1:t));
    %omega2(t) = sum(p(t+1:end));
    mu1(t) = sum(p(1:t).*(1:t)');
    mu2(t) = sum(p(t+1:end).*(t+1:nbins)');
end


sigma_b_squared_otsu = (mu1(end) .* omega1-mu1) .^2 ./(omega1 .* (1-omega1)); % Eq. (18
[~,thres_level_otsu] = max(sigma_b_squared_otsu);

%% calculate binary image
result_bin = I >= (thres_level_otsu);


