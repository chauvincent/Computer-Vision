	prompt = '(1): Output prague (2): Output Mall\n'

	x = input(prompt)

	if x == 1

	img = imread('inputSeamCarvingPrague.jpg');


	eMat = energy_image(img)

	for i=1:100
		
		[reducedImg eMat] = reduce_width(img, eMat)
        
		img = reducedImg;
     
    end
    
	imwrite(img, 'outputReduceWidthPrague.jpg')
    
    elseif x == 2
    
    img = imread('inputSeamCarvingMall.jpg');


	eMat = energy_image(img)

	for i=1:100
		
		[reducedImg eMat] = reduce_width(img, eMat)
    
		img = reducedImg;
      
    end
    
	imwrite(img, 'outputReduceWidthMall.jpg')
    
    %clear all

    end %end if