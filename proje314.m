clc
close all
clear all

a=imread('1.bmp');
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
     
% ref corresponds to 1 cm

ref=ref/8

rad25=fix(ref*1.1)
rad50=fix(ref*1.3)
rad100=fix(ref*1.5)

se = strel('disk',1);      
I2 = imdilate(BW1,se);      
imshow(I2);


d2 = imfill(I2, 'holes');
figure, imshow(d2); 

% reference squares are not used while defining the radii, some approximate
% values are assigned instead.

kr_25=imfindcircles(d2,[10 16],'ObjectPolarity','bright','EdgeThreshold',0.1)

kr_50=imfindcircles(d2,[10 17],'ObjectPolarity','bright','EdgeThreshold',0.1)

tl_1=imfindcircles(d2,[10 20],'ObjectPolarity','bright','EdgeThreshold',0.2) 

ybes=numel(kr_25)/2
elli=numel(kr_50)/2-ybes
bir=numel(tl_1)/2-elli-ybes

total=0.25*ybes+0.50*elli+bir
lira=floor(total)
kurus=100*(total-lira)

fprintf('1 TL: %d\n50 Kr: %d\n25 Kr: %d\nTotal: %d TL and %d Kr\n',bir,elli,ybes,lira,kurus)

