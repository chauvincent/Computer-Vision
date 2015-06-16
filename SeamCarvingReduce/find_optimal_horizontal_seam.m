function [ horizontalSeam ] = find_optimal_horizontal_seam( cumEnMap )
% Input: 2D matrix of double from cummulative_minimum_energy_map
% Output: horizontalSeam vector containing the column indices of the pixels
% which for the seam for each row
    
	% transpose
    cumEnMap = cumEnMap';
    
    hOpt = find_optimal_vertical_seam(cumEnMap)
    
    %rotate back
    horizontalSeam = imrotate(hOpt,90)

end