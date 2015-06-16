function [ verticalSeam ] = find_optimal_vertical_seam( cumEnMap )
% Input: 2D matrix of double from cummulative_minimum_energy_map
% Output: verticalSeam vector containing the column indices of the pixels
% which for the seam for each row
    
    s = size(cumEnMap);
    
    row = s(1);

    col = s(2);

    % initialize verticalSeam 
    verticalSeam = zeros(row,2);

    % find the last col with the minimum value
    [minVal, minCol] = min(cumEnMap(row,:));
    
    %store starting point
    verticalSeam(row, :) = [ row minCol ]

    i = row - 1;
    
    % cases: first col, last col, everything in-between
    while i >= 1
        
        verticalSeam(i,1) = i; % store current row
        
        if minCol == 1 % Case 1: first column
            
            % check the right for min
            if cumEnMap(i, minCol) > cumEnMap(i, minCol + 1)
        
                verticalSeam(i, 2) = minCol + 1; % store right
        
                minCol = minCol + 1; % go next col    
        
            else 
                verticalSeam(i, 2) = minCol; % store current col, right not smaller  
        
            end % endif
        
        elseif minCol + 1 > col % Case 2: last column
            
            % check the left
            if cumEnMap(i, minCol) > cumEnMap(i, minCol - 1) % if optimal 
                
                verticalSeam(i, 2) = minCol - 1;  
                
                minCol = minCol - 1;    

            else   
                verticalSeam(i, 2) = minCol; % store current instead
            
            end % end inner if
       
        else % in between
            
            % find lowest neighbor
            low  = min(min(cumEnMap(i,minCol), cumEnMap(i, minCol -1)),cumEnMap(i,minCol + 1));
            
            % if current optimal
            if cumEnMap(i, minCol) == low 
            
                verticalSeam(i, 2) = minCol;

            % check if left optimal
            elseif cumEnMap(i, minCol - 1) == low
            
                verticalSeam(i,2) = minCol - 1;

                minCol = minCol - 1;
            
            
            % if right optimal
            elseif cumEnMap(i,minCol + 1) == low 
            
                verticalSeam(i, 2) = minCol + 1;
            
                minCol = minCol + 1;
            
            end % end if
        
        end % end if
        
            i = i - 1; % decrement while
    
    end % end while    

end % function

