%   After testing your code for bag-of-words visual
%   search, choose 3 different frames from the entire
%   video dataset to serve as queries.
%   Display each query frame and its M =5 most similar
%   frames (in rank order) based on the normalized scalar
%   product between their bag of words histograms.

clear;

clc;

addpath('./provided_code/');

load('kMeans.mat');

siftdir = '/usr/local/189data/sift/';
%siftdir = '/Users/vincentchau1/Desktop/PS3/sift/';

% Get a list of all the .mat files in that directory.
% There is one .mat file per image.
sname = dir([siftdir '/*.mat']);

% NOTE: Change queryID for random images, 
% Results were produced with queryID = 10, 30, 80
queryID = 10;

% https://piazza.com/class/i7nwoduhfeq4be?cid=323
% https://piazza.com/class/i7nwoduhfeq4be?cid=312
% Create hist with 100 frames
for i=1:100
   
    hist(:,i) = histc(membership(imgIdx == i), 1:length(means));
    
end % end for
simIdx = [];
% compute dot product / norm
for l = 1: 100 

    % find similarities
    % <dj , q> 
    
    dj = hist(:,l);

    % constant histogram for query image
    q = hist(:,queryID);
    
    sim = sum(dj .* q);
    
    % ||dj|| ||q||
    normal = (norm( dj * norm( q )));
    
    % <dj, q> / ||dj|| ||q||
    sim = sim / normal;
    
    simIdx = [simIdx; sim,l];

end

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

end