function [ result ] = negative_rate_metric( TP, TN, FP, FN)
%NEGATIVE_RATE_METRIC Summary of this function goes here
%   Detailed explanation goes here
    NR_FN = FN / (FN + TP);
    NR_FP = FP / (FP + TN);
    
    result = (NR_FN + NR_FP) / 2;
end

