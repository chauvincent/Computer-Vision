%   Select your favorite query regions from within 4 frames
%   to demonstrate the retrieved frames when only a portion of the SIFT descriptors
%   are used to form a bag of words. Try to include example(s)
%   where the same object is found in the most similar
%   M frames but amidst different objects or backgrounds,
%   and also include a failure case.
%   Display each query region (marked in the frame as a polygon) and its 
%   M =5 most similar frames
%   Explain the results, including possible reasons for
%   the failure cases

clear;

clc;

addpath('./provided_code/');

% load workspace from visualize vocab
load('kMeans.mat');

% Get a list of all the .mat files in that directory.
% There is one .mat file per image.
fnames = dir([siftdir '/*.mat']);

% NOTE: Change queryID for random images, Results were produced with
% test images: Change queryID to 30, 80, 69, 28
queryID = 30;  

fname = [siftdir '/' fnames(queryID).name];

load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
   
% read in the associated image
query1 = [framesdir '/' imname]; % add the full path
 
qImg = imread(query1);

% get BoW given user select regions    
queryRegion = selectRegion(qImg, positions);

regionDes = descriptors(queryRegion,:);

% http://www.mathworks.com/help/matlab/ref/ismember.html?refresh=true
% mask with boolean where is apart of region
[Lia, LocB] = ismember(regionDes, allDes, 'rows');

% Create region BoW Histogram
histReg = histc(membership(LocB), 1:length(means));

% https://piazza.com/class/i7nwoduhfeq4be?cid=323
% https://piazza.com/class/i7nwoduhfeq4be?cid=312
% Create hist with 100 frames
for i=1:100
   
    hist(:,i) = histc(membership(imgIdx == i), 1:length(means));
    
end % end for
simIdx = []
% compute dot product / norm
for l = 1:100 

    % find similarities
    % <dj , q> 
    
    dj = hist(:,l);

    % region histogram
    q = histReg;
    
    sim = sum(dj .* q); 
    
    % ||dj|| ||q||
    normal = (norm( dj * norm( q )));
    
    % <dj, q> / ||dj|| ||q||
    sim = sim / normal;
    
    simIdx = [simIdx; sim,l];

end % end for

% sort features to get closest
simIdx = flipdim(sortrows(simIdx),1);

figure

subplot(3,3,2);

% rgb2gray was giving errors, use [0 255] instead refered to:
% http://www.mathworks.com/matlabcentral/answers/30784-how-to-convert-a-matrix-to-a-gray-scale-image
imshow(imgAcc(:,:,queryID), [0 255]);

% first 4 matches for all images were black images, possible error due to not filtering out the black frames in data
% skipped over the first 4
for s = 4:9
    
   subplot(3, 3, s);
   
   imagesc(imgAcc(:,:,simIdx(s+1,2))); % add one to filter out an additional black image

end % end for




 