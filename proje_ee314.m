clc
close all
clear all

a=imread('nonoise3.png');
I=rgb2gray(a)

%Black and white

thresh=245
rows=320
cols=240
for i = 1:rows
    for j = 1:cols
        if I(i,j) >= thresh
            im(i,j) = 255;
        end
    end
end

%Reference square

count=0

for i = 1:30
    for j = 1:100
        if im(i,j)==0
            count=count+1
        end
    end
end

cm=fix(sqrt(count)) %# of pixels eqv to 1 cm

%Image binarization

bin=zeros(320,240)

bin=(~im)
bin=double(bin)

figure;
imshowpair(I,bin,'montage')
title('Original                                   Binarized');

%Edge detection

a= zeros(320,240)

for i=1:rows
    for j=1:cols-1
        if bin(i,j)==1 & bin(i,j+1)==1
            a(i,j+1)=0
        else
            a(i,j+1)=bin(i,j+1)
        end
    end
end




