%	Raw descriptor matching Allow a user
%	to select a region of interest (see provided selectRegion.m)
%	in one frame, and then match descriptors in that region to descriptors
%	in the second image based on Euclidean distance in SIFT space. Display
%	the selected region of interest in the first image (a polygon),
%	and the matched features in the second image, something like the below
%	example. Use the two images and associated features in the provided file
%	twoFrameData.mat (in the zip file) to demonstrate.
%	Note, no visual vocabulary should be used for this one.

%add path for functions
addpath('./provided_code/');

%load twoFrame
load('twoFrameData.mat');

%Allow select region
region = selectRegion(im1, positions1); 

%https://piazza.com/class/i7nwoduhfeq4be?cid=295
%Transpose for NxM matrix and take dist of descriptors in region
for desRegion=descriptors1(region,:)'
    
    if exist('matchFeatures','var');
        %https://piazza.com/class/i7nwoduhfeq4be?cid=290
        % get minimum distance
        [M, I] = min(dist2(desRegion', descriptors2));
        
        % append row-wise with best matching feature
        matchFeatures = [matchFeatures; M, I];
    
    else
        matchFeatures = [ ];
    
    end % end if
    
end % end for

% threshold matches  
t = mean(matchFeatures,1);

% take 75% of the mean
thresMatch = matchFeatures < (t(1)*.75);

thresMatch = matchFeatures(thresMatch,:);

% display patches 
figure;

imshow(im2);

% parameters: positions, scales, orients, im
displaySIFTPatches(positions2(thresMatch(:,2),:), scales2(thresMatch(:,2),:),orients2(thresMatch(:,2),:), im2);