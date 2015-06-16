function [ histEqual, histClustered ] = getHueHists( im,k )
% Input: im (MxNx3 RGB), k cluster
% Output: histEqual: k equally spaced bins(dividing hue values) 
%         histClustered: bins defined by k cluster center membership
%         all pixels belonging to hue cluster i go to ith bin, for i..k        

    % test
    %   im = imread('fish.jpg')
    %   k = 16
    %

    %histEqual
    
    %figure
    
    [row col n] = size(im);
    
    hsvImg = rgb2hsv(im);
    
    hue = reshape( hsvImg(:,:,1), row * col, 1);
    
    [count, centers] = hist(hue, k);
    
    histEqual = [count, centers];
    
    %bar(centers, count, 'hist');
    
    %title('histEqual: ')

    
    %histClustered
    
    figure;
    
    hue = reshape( hsvImg(:,:,1), row * col, 1);
    
    extractBin = sort(unique(hsvImg(:,:,1)),'ascend');
    
    [count, centers] = hist(hue, extractBin);
    
    histClustered(:,1) = extractBin;
    
    %bar(centers, count, 'hist');

    title('histCluster: ')

    
end

