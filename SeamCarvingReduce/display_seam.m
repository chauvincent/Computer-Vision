function seamedImg = display_seam( im, seam, seamDirection )
% Input: Takes in an .jpg, seam = horizontal or vertical (optimal),
%        direction: the direction to be displayed
% Output: Outputs the input image with the seam on top of it (plotting)
	
	vertical = 'VERTICAL'
	
	horizontal = 'HORIZONTAL'
	
	if strcmp(seamDirection, vertical) == 1

		imshow(im)

		hold on
	
		plot(seam(:,2), seam(:,1))


	end % end if vertical

	if strcmp(seamDirection, horizontal) == 1
	
		imshow(im)
	
		hold on;
	
		plot(seam(2,:), seam(1,:))

	end % end for horizontal

end

