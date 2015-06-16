% Given an RGB image quantize the 3D RGB space and map each pixel in the
% input image to its nearest k-means center. That is replace the RGB value
% at each pixel with its nearest cluster's average RGB value.
% Variables:
% origImg, outputImg  (MxNx3 type uint8)
% k specifies the number of colors to quantize to
% meanColors is a (kx3 array of the k centers)
% tip = if variable of origImg is a 3d matrix ontianing a color image with
% numpixel pixels, x = reshape(origImg, numpixels, 3); -> matrix with RGB
% features as its rows.
function [ outputImg meanColors ] = quantizeRGB( origImg, k )
    origImg = double(origImg); 
    
    [row, col, n] = size(origImg);
    
    %Matrix with RGB value as rows
    x = reshape(origImg, (row * col), n);  
    
    x = double(x);
    
    % Error with default k means, max iteration was 100
    %http://www.mathworks.com/matlabcentral/newsreader/view_thread/76474
    options = statset('MaxIter', 1000);
    
    %http://www.mathworks.com/help/stats/kmeans.html#buefthh-2
    [clusterIdx, centroidLoc] = kmeans(x, k, 'Options', options);
    
    %round up values
    centroidLoc = round(centroidLoc);
    
    clusterIdx = uint8(clusterIdx);
    
    outputImg = zeros(row, col, n);
    
    %http://www.mathworks.com/matlabcentral/newsreader/view_thread/307398
    %take clusterIds into same size
    clusterIdx = reshape(clusterIdx, row, col);
    %http://www.mathworks.com/help/images/examples/color-based-segmentation-using-k-means-clustering.html
    
    % apply cluster to image
    for j = 1:1:col;
        
        outputImg(:,j,1) = centroidLoc(clusterIdx(:,j),1);
    
        outputImg(:,j,2) = centroidLoc(clusterIdx(:,j),2);
        
        outputImg(:,j,3) = centroidLoc(clusterIdx(:,j),3);
    
    end % end for

    outputImg = uint8(outputImg);
    
    meanColors = centroidLoc;
     
end %end function

