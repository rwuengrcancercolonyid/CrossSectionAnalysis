% Created By: Jessica Jensen
% Created On: 2/7/2020
close all;
clear variables;

% Retrieve Image
dir = 'C:\Users\JJensen\OneDrive\4 Senior\SeniorDesign\Matlab\cellPics\';
picName = "treatment1 pic 1 IgG";
run(dir,picName);

% Run the analysis on the inputted image, plot, and 
function run(dir,picName)
[RGB] = getImage(dir,picName);


% Define Some variables to be used later
adaptiveFilterSensitivity = 0.5;
minObjSize = 100;
connectivity = 4;
%% Running Analysis on Image
tic
% figure
% imshow(RGB)
% title("Original Image")
gray = rgb2gray(RGB);
gray = grayLessShadow(gray,170);
% figure
% imshow(gray)
% title("Grayscale Image With Shadow Lightening")
[invIm] = imBinary(gray,adaptiveFilterSensitivity);
% figure
% imshow(invIm)
% title("Image Binarized")
invIm = binThresh2(invIm,3,3,8);
% figure
% imshow(invIm)
% title("Image Binarized after bin thresholding")
% (excludes objs below minObjSize and connectivitty)
invIm = bwareaopen(invIm,minObjSize,connectivity);
% figure
% imshow(invIm)
% title("Image Small Objects Removed")
% finds boundaries of parent and child objects
[B,L,N,A] = bwboundaries(invIm);

sumRow = getChildMatrix(A);

stats = regionprops(L,invIm,'Area','Centroid');

% Find the area of each detected object, the average area
[area,areaParent,avgParentArea] = getAreaObjects(stats,sumRow);

% figure
% imshow(invIm)
% a = imfill(invIm);
% figure
% imshow(a)

% draw the boundary lines on only the tumor parent objects included in the
%       % calculation and its children
drawBoundary(RGB,B,sumRow,avgParentArea,area,A) 
% toc
% tic
% saveFig(dir, picName)
% toc
end