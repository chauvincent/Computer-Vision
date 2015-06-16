function [ error ] = computeQuantizationError( origImg, quantizedImg )
% Output: error: Sum of Squared Distance Error
% Input: origImg(uint8), quantizedImg(uint8 return from quantizedRGB)
    
   % https://piazza.com/class/i7nwoduhfeq4be?cid=187
   error = sum( sum( abs((origImg - quantizedImg).^2 )  ) )

end

