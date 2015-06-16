% Inputs: (a) an MxNx3 matrix im of datatype uint8  
%         (b) a 2D matrix energyImage of datatype double. 
%The input energyImage can be the output of the energy_image function.  The output must return 2 variables: (a) a 3D matrix reducedColorImage
%same as the input image but with its width or height reduced by one pixel; (b) a 2D matrix
%reducedEnergyImage of datatype double same as the input energyImage, but with its width or height reduced by one pixel

function [reducedColorImage reducedEnergyImage] = reduce_height(im, energyImage)

    im = imrotate(im,90)
    
    energyImage = imrotate(energyImage,90)
    
    %get vertical eMap
    verticalMap = cumulative_min_energy_map(energyImage, 'VERTICAL');
    %get optimal
    verticalSeam = find_optimal_vertical_seam(verticalMap);
    
    minCols = verticalSeam(:,2);
    
    s = size(im);
   
    row = s(1);
   
    col = s(2);
   
    n = s(3);
     
    reducedColorImage = zeros(row, (col-1), n, class(im));
    
    r = 1;    
 
    while r ~= row

       if minCols(r) == 1 % case1: first col 

                for i = 1:3 % store RGB

                    reducedColorImage(r,:,i) = im( r, 2:col ,i );
                
                end % end forloop

        
        elseif minCols(r) == col % case2: last col

                for i = 1:3 % shift over for RGB

                    reducedColorImage(r,:,i) = im(r, 1 :( col-1 ), i); 
        
                end % end forloop    



        else  
            % Referred to Dinesh's Post https://piazza.com/class/i7nwoduhfeq4be?cid=136
            if minCols(r) > 1  

               for i = 1:3 
                    
                    reducedColorImage(r,:,i) = [im(r,1:(minCols(r)-1),i) im(r,(minCols(r)+1):col,i)];
                    
                end % end forloop

            end % end if

        
        end % end if
    
        r = r + 1; % increment
    
    end % end while loop

    reducedEnergyImage = imrotate(energy_image(reducedColorImage),90);

    reducedColorImage = imrotate(reducedColorImage,90)
    
end % end function


