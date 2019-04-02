close all; clear; clc
%The following script reads two images and performs lowpass/highpass
%filtering followed by combining the two images
%-----
%Reading, grayscaling and obtain size of both images
lowim  = imread('woman.png');
highim = imread('man.png');
low_g   = rgb2gray(lowim);
high_g   = rgb2gray(highim);
low_size = size(low_g);
high_size = size(high_g);
%Fourier Transform both images
fft_low = fft2(low_g);
fft_high = fft2(high_g);
%Lowpass and highpass filter creation
lowpass = lowpassfilter(low_size,0.04,1);
highpass = highpassfilter(high_size,0.1,1);
%Matrix multiplication of frequency domain by filters
fft_low_final = fft_low.*lowpass;
fft_high_final = fft_high.*highpass;
%IFT both images for display purposes
final_low = ifft2(fft_low_final);
final_high = ifft2(fft_high_final);
%Perform IFT after adding the frequency domain of both images to produce
%the hybrid image
final_combi = ifft2(fft_low_final+fft_high_final);
%Display the lowpass filtered, highpass filtered and hybrid image
set(gcf, 'Position',  [100, 100, 1200, 400])
subplot(1,3,1);
imagesc(final_low),title('Lowpass Filtered Image');
axis on;
xlabel('Pixel', 'FontSize', 8);
ylabel('Pixel', 'FontSize', 8);
subplot(1,3,2); 
imagesc(final_combi),title('Hybrid Image');
axis on;
xlabel('Pixel', 'FontSize', 8);
ylabel('Pixel', 'FontSize', 8);
subplot(1,3,3);
imagesc(final_high),title('Highpass Filtered Image');
axis on;
xlabel('Pixel', 'FontSize', 8);
ylabel('Pixel', 'FontSize', 8);
colormap(gray);
