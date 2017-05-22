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
ref=0
for i=1:40
    for k=1:240
        if (BW1(k,i)==1)
            ref=ref+1
        end
    end
end
     
%ref corresponds to 1 cm
ref=ref/8

rad25=fix(ref*1.1)
rad50=fix(ref*1.3)
rad100=fix(ref*1.5)

se = strel('disk',1);      
I2 = imdilate(BW1,se);      
imshow(I2);


d2 = imfill(I2, 'holes');
figure, imshow(d2); 


kr_25=imfindcircles(d2,[10 rad25],'ObjectPolarity','bright','EdgeThreshold',0.1)

kr_50=imfindcircles(d2,[10 rad50],'ObjectPolarity','bright','EdgeThreshold',0.1)

tl_1=imfindcircles(d2,[10 rad100],'ObjectPolarity','bright','EdgeThreshold',0.1) 

ybes=numel(kr_25)/2
elli=numel(kr_50)/2-ybes
bir=numel(tl_1)/2-elli

[centers, radii]=imfindcircles(d2,[10 20],'ObjectPolarity','bright','EdgeThreshold',0.3)
