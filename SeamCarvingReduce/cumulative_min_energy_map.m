function  energyMap  = cumulative_min_energy_map( energyImage, seamDirection )
% input : energy image 2D matrix double
% output : cummulative energy map must be a 2D matrix double

    vertical = 'VERTICAL'

    horizontal = 'HORIZONTAL'

    if strcmp(seamDirection,vertical) == 1

        M = energyImage;

        s = size(M);
        
        rows = s(1)
        
        cols = s(2);
        
        %init energymap
        energyMap = zeros(rows,cols, class(M));

        energyMap(1,:) = M(1,:) % Case0: store first row

        %referred to https://piazza.com/class/i7nwoduhfeq4be?cid=112
        for r=2:rows
        
            for c=1:cols
                if (c - 1) >= 1 && (c + 1) <= cols % Case1: in-between

                     energyMap(r,c)= M(r,c)+min([energyMap(r-1,c-1),energyMap(r-1,c),energyMap(r-1,c+1)]);

                elseif (c - 1) < 1 % Case2: First col
            
                    energyMap(r,c)= M(r,c)+min([energyMap(r-1,c),energyMap(r-1,c+1)]);
        
                elseif (c + 1) > cols % Case3: last col
            
                    energyMap(r,c)= M(r,c)+min([energyMap(r-1,c-1),energyMap(r-1,c)]);
                
                end % end if

            end % end inner for
        
        end % end outer for
    
    end % end if vertical
 
    if strcmp(seamDirection,horizontal) == 1

        % transpose
        energyImage = energyImage'
        
        M = energyImage;

        s = size(M);
        
        rows = s(1)
        
        cols = s(2);
        
        %init energymap
        energyMap = zeros(rows,cols, class(M));

        energyMap(1,:) = M(1,:) % Case0: store first row

        %referred to https://piazza.com/class/i7nwoduhfeq4be?cid=112
        for r=2:rows
        
            for c=1:cols
                if (c - 1) >= 1 && (c + 1) <= cols % Case1: in-between

                     energyMap(r,c)= M(r,c)+min([energyMap(r-1,c-1),energyMap(r-1,c),energyMap(r-1,c+1)]);

                elseif (c - 1) < 1 % Case2: First col
            
                    energyMap(r,c)= M(r,c)+min([energyMap(r-1,c),energyMap(r-1,c+1)]);
        
                elseif (c + 1) > cols % Case3: last col
            
                    energyMap(r,c)= M(r,c)+min([energyMap(r-1,c-1),energyMap(r-1,c)]);
                
                end % end if

            end % end inner for
        
        end % end outer for
        
        %transpose back
        energyMap = energyMap';

    end % end if horizontal  
                       
end % end of function