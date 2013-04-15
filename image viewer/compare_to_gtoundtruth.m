function [ TP, TN, FP, FN ] = compare_to_gtoundtruth( img_bin, groundtruth)
    %COMPARE_TO_GTOUNDTRUTH Summary of this function goes here
    %   Detailed explanation goes here
    TP = 0;
    TN = 0;
    FP = 0;
    FN = 0;
    
    %both sizes should be equal
    [y,x] = size(img_bin);
    
    
    % 1 is a backgruond color, 0 is a foreground color
    for i=1:y
        for j=1:x
            if     (img_bin(i,j) == 0 && groundtruth(i,j)== 0)
                TP = TP + 1;
            elseif (img_bin(i,j) == 1 && groundtruth(i,j)== 1)
                TN = TN + 1;
            elseif (img_bin(i,j) == 0 && groundtruth(i,j)==1)
                FP = FP + 1;
            elseif (img_bin(i,j) == 1 && groundtruth(i,j)== 1)
                FN = FN + 1;
            end
        end
    end
end

