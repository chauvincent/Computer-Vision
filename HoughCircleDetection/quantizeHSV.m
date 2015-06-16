% Given an RGB image quantize the 3D HSV space and map each pixel in the
% input image to its nearest k-means center. That is replace the HSV value
% at each pixel with its nearest cluster's average HSV value.
% Variables:
% origImg, outputImg  (MxNx3 type uint8)
% k specifies the number of colors to quantize to
% meanHues is a (kx3 array of the k centers)
% tip = if variable of origImg is a 3d matrix ontianing a color image with
% numpixel pixels, x = reshape(origImg, numpixels, 3); -> matrix with HSV
% features as its rows.
function [ outputImg, meanHues ] = quantizeHSV( origImg, k )

    origImg = rgb2hsv(origImg);

    [row , col, n] = size(origImg);

    %Matrix with HSV value as rows
    x = reshape(origImg, (row * col), n);

    x = double(x);

    % Error with default k means, max iteration was 100
    %http://www.mathworks.com/matlabcentral/newsreader/view_thread/76474
    options = statset('MaxIter', 1000);
    
    %http://www.mathworks.com/help/stats/kmeans.html#buefthh-2
    [clusterIdx, centroidLoc] = kmeans(x, k, 'Options', options);

    clusterIdx = uint8(clusterIdx);

    outputImg = zeros(row, col, n);
    
    %http://www.mathworks.com/matlabcentral/newsreader/view_thread/307398
    %take clusterIds into same size
    clusterIdx = reshape(clusterIdx, row, col);
    %http://www.mathworks.com/help/images/examples/color-based-segmentation-using-k-means-clustering.html
    
    % Referred to Yufei Wang's post
    % https://piazza.com/class/i7nwoduhfeq4be?cid=196
    % apply cluster to image
    for j = 1:1:col;

        outputImg(:,j,1) = centroidLoc(clusterIdx(:,j),1);
    
        outputImg(:,j,2) = origImg(:,j,2); % keep it the same
    
        outputImg(:,j,3) = origImg(:,j,3); 
    
    end % end for
    
    % convert back to rgb image
    rgbImg = hsv2rgb(outputImg); 
    
    outputImg = rgbImg * 255;

    outputImg = uint8(outputImg);

    meanHues = centroidLoc;


end %end function

