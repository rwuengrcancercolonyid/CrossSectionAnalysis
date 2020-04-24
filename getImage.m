function [RGB] = getImage(dir,name)
% Purpose: retrieve the image with the inputter directory and file name
	% assumes file is a jpg
    RGB = imread(strcat(dir,name,'.jpg'));
end