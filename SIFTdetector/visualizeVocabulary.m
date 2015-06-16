%   Display example image patches associated with two of the visual words.
%   Choose two words that are distinct to illustrate what the different
%   words are capturing, and display enough patch examples so the word
%   content is evident
%   (e.g., say 25 patches per word displayed).
%   Refer to getPatchFromSIFTParameters.m. Explain what you see.
%   Submit visual words in kMeans.mat

addpath('./provided_code/');

framesdir = '/usr/local/189data/frames/';

siftdir = '/usr/local/189data/sift/';

%framesdir = '/Users/vincentchau1/Desktop/PS3/frames/';

%siftdir = '/Users/vincentchau1/Desktop/PS3/sift/';

% Get a list of all the .mat files in that directory.
% There is one .mat file per image.
fname = dir([siftdir '/*.mat']);

% initialize accumulators
allDes = [];

allPos = [];

allScal = [];

allOri = [];

imgIdx = [];

pathIndex = [];

for i = 1:100  %	takes too long when going through all frames. Data set will be 100 frames
   	
    load([siftdir fname(i).name], 'imname', 'descriptors', 'positions', 'scales', 'orients'); 
    
    %   https://piazza.com/class/i7nwoduhfeq4be?cid=303
    %   store row-wise
    imname = [framesdir imname];

    numFeat = size(descriptors,1);
    
    allDes = [allDes; descriptors];
    
    allPos = [allPos; positions];
    
    allScal = [allScal; scales];
    
    allOri = [allOri; orients];
  
    % https://piazza.com/class/i7nwoduhfeq4be?cid=312
    % map image ID to amount of descriptors
    desMap = repmat(i, [1 length(descriptors)]);
    
    %store column-wise
    imgIdx = [imgIdx, desMap];
 
    % map gray image with image id
    imgAcc(:,:,i) = single(rgb2gray(imread(imname)));
    
    % map image path with its numfeature with the images path name for path search
    pathFeats = repmat({imname}, numFeat, 1);

    % store row-wise image path feature look-up
    pathIndex = [pathIndex; pathFeats];

end % end for

% get clusters
k = 1500;

[membership, means] = kmeansML(k, allDes');

% create two random sample
sampleIdx = randperm(k,2);

for h = sampleIdx

    figure;
	
	% https://piazza.com/class/i7nwoduhfeq4be?cid=312
    foundFeatureIdxs = find(membership == h);

    len = length(foundFeatureIdxs);

    % display 25 patches
    for k=1:25

        featureIdx = foundFeatureIdxs(k);
 		
 		%	get path of the feature index
        imPath = pathIndex{featureIdx,:};

        img = imread(imPath);

        % 	convert to gray first
        grayImg = rgb2gray(img);

        %	find patch
        patch = getPatchFromSIFTParameters(allPos(featureIdx,:), ...
                    allScal(featureIdx), allOri(featureIdx), grayImg);

        subplot(5,5,k)

        imshow(patch);

    end
    
end

% save everything, reusing the saved images vector and sift features
save('kMeans.mat');
