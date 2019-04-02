close all; clear; clc
%The following script reads an image using imread and outputs the number 
%of objects in the image.
%-----
%This is achieved by grayscaling the image and then determining a suitable
%threshold to produce binary image containing simple connected objects. 
%Black and white is then inverted and the holes in each object is filled. 
%By filling in the holes, a more accurate representation of each basic
%object is achieved. The object is then eroded using a flat-shaped
%structuring element. 
%-----
%A final object count is then taken.

im  = imread('lego1.png');
g   = rgb2gray(im);
bw  = g>150;
bw  = imcomplement (bw);
bw2 = imfill(bw, 'holes');
se  = strel('line',5,5);
bw2 = imerode(bw2,se);

imshow(bw2)
[L,num]=bwlabel(bw2,4);

if num==1
    fprintf('There is %i object in the image\n',num);
else
    fprintf('There are %i objects in the image\n',num);
end
