function  eMatrix  = energy_image( im )
% Input: im is MxNx3 matrix type uint8  
% Output: im is 2D matrix datatype double
% Use x and y gradients (sqrtdx^2+dy^2))
    
    img = im2double(im); 
	
    grayImg = rgb2gray(img);
    
    [dX dY] = gradient(grayImg);
    
    xGradient = abs(dX);
    
    yGradient = abs(dY);

    eMatrix = sqrt(xGradient.^2 + yGradient.^2);


end

