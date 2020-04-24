function [gray] = grayLessShadow(gray,whiteValue)
% Purpose: turn slightly shaded pixels to pure white 
	% whiteValue is the threshold value that will be turned 
	% to pur white 255
    whiteValue = 170; %%%%% Value of 170 picked by choosing best of several tested values 
    for i = 1:size(gray,1)
        for j = 1:size(gray,2)
            if gray(i,j) >= whiteValue
                gray(i,j) = 255;
            end
        end
    end
end