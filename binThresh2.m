function [invImResult] = binThresh2(image,yBinSize,xBinSize,windowThresh)
% Purpose: create a 'bin' method. 
% Aim: Remove just enough pixels to eliminate the webs in the cancer image, but not enough to change the results

% input image is a binary image

% for a yBinSize by xBinSize rectangle, make sure there are at least windowThresh white (cancer) pixels 
% otherwise, make all of the pixels black (not cancer)
	for yBin = 1:size(image,1)-yBinSize+1
		for xBin = 1:size(image,2)-xBinSize+1
			numWhite(yBin,xBin) = sum(sum(image(yBin:yBin+yBinSize-1,xBin:xBin+xBinSize-1)== 1));
			invImResult(yBin:yBin+yBinSize-1,xBin:xBin+xBinSize-1) = numWhite(yBin,xBin)>=windowThresh;
		end
	end

end
