% Part 1 (e)
img = imread('fish.jpg');

[qRGB5 mRGB5] = quantizeRGB(img, 5);

%subplot(2,2,1);

%imagesc(qRGB5)

%title('Quantized RGB with k = 5');

[qRGB25 mRGB25] = quantizeRGB(img, 25);

%subplot(2,2,2);

%imagesc(qRGB25)

%title('Quantized RGB with k = 25');

[qHSV5 mHSV25] = quantizeHSV(img, 5);

%subplot(2,2,3);

%imagesc(qHSV5)

%title('Quantized HSV with k = 5');

[qHSV25 mHSV25] = quantizeHSV(img, 25);

%subplot(2,2,4)

%imagesc(qHSV25)

%title('Quantized HSV with k = 25');

ssdRGB5 = computeQuantizationError(img, qRGB5);

ssdRGB25 = computeQuantizationError(img, qRGB25);

ssdHSV5 = computeQuantizationError(img, qHSV5);

ssdHSV25 = computeQuantizationError(img, qHSV25);

[ histEqual histClust] = getHueHists(img, 5);
 
figure; 

bar(histEqual, 'hist');
    
title('histEqual with k = 5 : ');


[ histEqual histClust] = getHueHists(img, 25);
 
figure; 

bar(histEqual, 'hist');
    
title('histEqual with k = 25 : ');



%figure;

%histClust = unique(histClust);

%bar(histClust, 'hist');
    
%title('histCluster k = 25: ')

    
%[ histEqual2 histClust2] = getHueHist(img, 25);
