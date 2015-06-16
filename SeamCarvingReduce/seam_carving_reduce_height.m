	prompt = '(1): Output prague (2): Output Mall\n'

	x = input(prompt)

	if x == 1

	img = imread('inputSeamCarvingPrague.jpg');


	eMat = energy_image(img)

	for i=1:100
	1
		[reducedImg eMat] = reduce_height(img, eMat)
    
		img = reducedImg;
       
    end
    
	imwrite(img, 'outputReduceHeightPrague.jpg')
    
    elseif x == 2
    
    img = imread('inputSeamCarvingMall.jpg');


	eMat = energy_image(img)

	for i=1:100
		
		[reducedImg eMat] = reduce_height(img, eMat)
    
		img = reducedImg;
		
    end
    
	imwrite(img, 'outputReduceHeightMall.jpg')
    
    %clear all

    end %end if