function [invIm] = imBinary(gray,adaptiveFilterSensitivity)
% Purpose: Turn a greyscale image into a binary image
    % inverting the image because mask used finds white area, and purple is
    % originally the darker color (black)
    invIm = uint8(255)-gray;   % Invert image
    invIm = imbinarize(invIm,'adaptive','ForegroundPolarity','dark','Sensitivity',adaptiveFilterSensitivity);
end