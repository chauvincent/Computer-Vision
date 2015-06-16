function [ centers ] = detectCircles( im, radius, useGradient )
% Where im is the input image, radius specifies the size of circle we are looking for,
%and useGradient is a flag that allows the user to optionally exploit the gradient direction measured
%at the edge points. The output centers is an Nx2 matrix in which each
%row lists the (x,y) position of a detected circle?s center. Save this function
%in a file called detectCircles.m and submit it.

    % 1.    Convert Image to Canny

    img = rgb2gray(im);

    [row col n] = size(img);

    cannyImg = edge(img, 'Canny');

    %imagesc(cannyImg);

    % 2.    initilize Accumulator Array H[d,theta] = 0

    H = zeros(row, col, radius);
    H2 = zeros(row, col);

    % 3.    for every edge pixel(x,y)
    %           for each possible radius value r
    %               for thetha min to tetha max
    
    if(useGradient == false)

        edgeArr = find(cannyImg);

        numEdge = size(edgeArr);

        for i = 1 : numEdge
        
            % Y value for an image position is flipped, get position
            [y , x] = ind2sub([row, col], edgeArr(i));
        
            for r = 1 : radius;
        
                for theta = 0 : 360 

                    % convert to radians
                    % http://www.mathworks.com/matlabcentral/newsreader/view_thread/154258
                    radians = (theta * pi) / 180; 

                    % a = x - rcos(theta);
                        a = (x - r * cos( radians ));
                        a = round(a);
                
                    % b = y + rsin(theta); 
                        b = (y + r * sin( radians ));
                        b = round(b);

                    % H(a,b,r) += 1;
                        if( (a < col && b < row) && (a > 0 && b > 0) )
                            H(b,a,r) = H(b,a,r) + 1; % Accumulator by radius
                            H2(b,a) = H2(b,a) +1; % Accumulator with all radius length
                        end  % end if
    
                end % end theta

            end % end radius
    
        end % end edge
        
    elseif useGradient == true

        edgeArr = find(cannyImg);

        numEdge = size(edgeArr);

        [~, gDir] = imgradient(cannyImg);
        
        for i = 1 : numel(edgeArr)
        
            % Y value for an image position is flipped, get position
            [y , x] = ind2sub([row, col], edgeArr(i));
        
            for r = 1 : radius;
                    
                    theta = gDir(y,x);
        
                    % convert to radians
                    % http://www.mathworks.com/matlabcentral/newsreader/view_thread/154258
                    radians = (theta * pi) / 180; 

                    % a = x - rcos(theta);
                        a = (x - r * cos( radians ));
                        a = round(a);
                
                    % b = y + rsin(theta); 
                        b = (y + r * sin( radians ));
                        b = round(b);

                    % H(a,b,r) += 1;
                        if( (a < col && b < row) && (a > 0 && b > 0) )
                            H(b,a,r) = H(b,a,r) + 1; % vote
                            H2(b,a) = H2(b,a) +1; % Accumulator with all radius length
             
                        end  % end if
    
            end % end radius
    
        end % end edge

    end % end if useGradient

    imagesc(H2);
    
    % 4.    find values of (d, theta) where H[d,theta] is max (most votes)

    %       Post-Processing: Threshold found by 70 percent of the max vote

    maxCols = max(H);

    maxRad = max(maxCols);

    maxVal = max(maxRad);

    threshold = maxVal * .7;  

    [hRow hCol hN] = size(H);

    numCircle = 1;

    %       Reffered to https://piazza.com/class/i7nwoduhfeq4be?cid=258
    %       Threshold by keeping points within 70-100% of max votes  
    for a = 1 : hRow

        for b = 1 : hCol

            for r = 1 : hN

                if H(a, b, r) > threshold

                    xCircle(numCircle,1) = b;

                    yCircle(numCircle,1) = a;

                    rCircle(numCircle,1) = r;

                    hCircle(numCircle,1) = H(a,b,r);

                    numCircle =  numCircle + 1;

                end % end if

            end % end hN
    
        end % end hCol

    end % end hRow

    %       Reffered to https://piazza.com/class/i7nwoduhfeq4be?cid=258
    %       Threshold by keeping %80 
    %       First Sort by Votes
    temp = [xCircle(:,1),yCircle(:,1),rCircle(:,1),hCircle(:,1)];

    [~, idx] = sort(temp(:,4), 'Descend');

    sortedList = temp(idx, :);

    [row col] = size(sortedList);

    xCircle(:,1) = sortedList(:,1);

    yCircle(:,1) = sortedList(:,2);

    rCircle(:,1) = sortedList(:,3);

    hCircle(:,1) = sortedList(:,4);

    %       Keep 80 percent of max votes, Reduce inaccuracy

    amount = numel(xCircle(:,1));

    cutoff = amount * .8;

    for i =1: cutoff

        xFinal(i,1) = xCircle(i,1);
        
        yFinal(i,1) = yCircle(i,1);
    
    end % end for

    %       DEBUG: PLOT CENTERS
    if (size(xCircle,1) > 0)

        figure; 

        imshow(img); 

        hold on; 

        % http://www.mathworks.com/matlabcentral/answers/44917-how-is-the-markersize-of-a-circle-marker-defined

        plot(xFinal(:,1), yFinal(:,1), 'r+', 'MarkerSize', 10);

        plot(xFinal(:,1), yFinal(:,1), 'ro', 'MarkerSize', 2*radius);

    end % end plot

    %       Store Centers
    
    centers = [xFinal(:,1), yFinal(:,1)];
    

end % end detecCircles