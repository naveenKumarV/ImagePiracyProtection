close all;
clear;
clc;

N = 32;
SB_size = N*N/8;
SB = randi([0, 255], SB_size, 16, 'uint8');
load('sbox.mat');

%host
rgbimage=imread('host.jpg');
figure;
imshow(rgbimage);
title('Original color image');
[h_LL,h_LH,h_HL,h_HH] = dwt2(rgbimage,'haar');
[h_LL_LL, h_LL_LH, h_LL_HL, h_LL_HH] = dwt2(h_LL, 'haar');
img = h_LL_HH;
red1=dct2(img(:,:,1));
green1=dct2(img(:,:,2));
blue1=dct2(img(:,:,3));
[U_imgr1,S_imgr1,V_imgr1]= svd(red1);
[U_imgg1,S_imgg1,V_imgg1]= svd(green1);
[U_imgb1,S_imgb1,V_imgb1]= svd(blue1);

%watermark
watermark = imread('lenna.jpg');
figure;
imhist(watermark(:, :, 1));
title('Red component of watermark');
figure;
imhist(watermark(:, :, 2));
title('Blue component of watermark');
figure;
imhist(watermark(:, :, 3));
title('Green Component of watermark');
figure;
imshow(watermark);
title('Watermark image');
watermark = uint8(chaotic_blowfish_encryption(watermark, SB, N, sbox));
figure;
imhist(watermark(:, :, 1));
title('Red component of encrypted watermark');
figure;
imhist(watermark(:, :, 2));
title('blue component of encrypted watermark');
figure;
imhist(watermark(:, :, 3));
title('green component of encrypted watermark');
figure;
imshow(watermark);
title('Encrypted Watermark image');
[w_LL,w_LH,w_HL,w_HH]=dwt2(watermark,'haar');
[w_LL_LL, w_LL_LH, w_LL_HL, w_LL_HH] = dwt2(w_LL, 'haar');
img_wat = w_LL_HH;

red2=dct2(img_wat(:,:,1));
green2=dct2(img_wat(:,:,2));
blue2=dct2(img_wat(:,:,3));
[U_imgr2,S_imgr2,V_imgr2]= svd(red2);
[U_imgg2,S_imgg2,V_imgg2]= svd(green2);
[U_imgb2,S_imgb2,V_imgb2]= svd(blue2);

% watermarking
S_wimgr=S_imgr1+0.1*S_imgr2;
S_wimgg=S_imgg1+0.1*S_imgg2;
S_wimgb=S_imgb1+0.1*S_imgb2;

wimgr = idct2(U_imgr1*S_wimgr*V_imgr1');
wimgg = idct2(U_imgg1*S_wimgg*V_imgg1');
wimgb = idct2(U_imgb1*S_wimgb*V_imgb1');

wimg=cat(3,wimgr,wimgg,wimgb);
newhost_LL_HH=(wimg);

%output
newhost_LL = idwt2(h_LL_LL,h_LL_LH,h_LL_HL,newhost_LL_HH,'haar');
rgb2 = idwt2(newhost_LL, h_LH, h_HL, h_HH, 'haar');
imwrite(uint8(rgb2),'Watermarked.jpg');
figure;
imshow(uint8(rgb2));
title('Watermarked Image');


watermarked = uint8(rgb2);
[x_LL, x_LH, x_HL, x_HH] = dwt2(watermarked, 'haar');
[x_LL_LL, x_LL_LH, x_LL_HL, x_LL_HH] = dwt2(x_LL, 'haar');

tmp = x_LL_HH;
tmpr = dct2(tmp(:, :, 1));
tmpg = dct2(tmp(:, :, 2));
tmpb = dct2(tmp(:, :, 3));

[Ur1, Sr1, Vr1] = svd(tmpr);
[Ug1, Sg1, Vg1] = svd(tmpg);
[Ub1, Sb1, Vb1] = svd(tmpb);

Ser = (Sr1 - S_imgr1)*10;
Seg = (Sg1 - S_imgg1)*10;
Seb = (Sb1 - S_imgb1)*10;

r = idct2(U_imgr2*Ser*V_imgr2');
g = idct2(U_imgg2*Seg*V_imgg2');
b = idct2(U_imgb2*Seb*V_imgb2');

ex_LL_HH = cat(3, r, g, b);
ex_LL = idwt2(w_LL_LL, w_LL_LH, w_LL_HL, ex_LL_HH, 'haar');
ex = idwt2(ex_LL, w_LH, w_HL, w_HH, 'haar');
figure;
imshow(uint8(ex));
title('Extracted encrypted watermark');
extracted_watermark = uint8(chaotic_blowfish_decryption(uint8(ex), SB, N, sbox));                       
figure;
imshow(extracted_watermark);                                                                           
title('Extracted watermark');
imwrite(extracted_watermark, 'extracted_watermark.jpg');                                                    