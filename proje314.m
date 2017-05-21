clc
close all
clear all

a=imread('4.bmp');
I=rgb2gray(a)

BW1 = edge(I,'sobel');
BW2 = imbinarize(I,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);

figure;
imshowpair(I,BW1,'montage')
title('Original                                   Sobel Filter');
figure
imshow(BW2)
title('Binarized')


se = strel('disk',1);      
I2 = imdilate(BW1,se);      
imshow(I2);


d2 = imfill(I2, 'holes');
figure, imshow(d2); 

%rad25=
%rad50=
%rad100=

kr_25=imfindcircles(d2,[10 rad25],'ObjectPolarity','bright')

kr_50=imfindcircles(d2,[10 rad50],'ObjectPolarity','bright')

tl_1=imfindcircles(d2,[10 rad100],'ObjectPolarity','bright') 

ybes=numel(kr_25)
elli=numel(kr_50)-ybes
bir=numel(tl_1)-elli

