%%
% MATLAB Code Demonstration 
% Computer Vision CITS4402, Semester 1, 2019 - UWA

close all; clear; clc
% Load an image
I = imread('coins.png');

% Scaling of intensity 
J = imadjust(I);
subplot(1,2,1),imshow(I);
title('Input Image')
subplot(1,2,2), imshow(J)
title('Image after Scaling of Intensity')
%%
%Geometric operations
scale = 1;
angle_rot = 167;
x_shift = -50;
y_shift = -30;

% rotate, and translate Image I
I2 = im_rst(I, scale, angle_rot, x_shift, y_shift);
figure,subplot(1,2,1),imshow(I),title('Input Image')
subplot(1,2,2),imshow(I2),title('Rotated and Translated Image')
%%
% 2D Convolution
filter = [1 0 1; -1 1 0; 0 -1 1]; % 

Iconv = imfilter(I,filter, 'conv');
figure,subplot(1,2,1),imshow(I),title('Input Image')
subplot(1,2,2),imshow(Iconv),title('Image after convolution')
%%
% Fourier series analysis for different harmonics
t = linspace(-2,2,10000);   % time
f = 0*t;                    % creates a zero valued function
n =1; 
for N=3:2:9                        % number of harmonics
for k=-N:1:N
 
    if(k==0)                % skip the zeroth term
        continue;
    end;
 
    % compute the k-th Fourier coefficient of the exponential form
    C_k = ((1)/(pi*1i*k))*(1-exp(-pi*1i*k));    
    f_k = C_k*exp(2*pi*1i*k*t);                 % k-th term of the series
    f = f + f_k;                                % adds the k-th term to f
 
end
subplot(2,2,n), plot(t, f, 'LineWidth', 2);
grid on;
xlabel('t');
ylabel('f(t)');
title(strcat('Fourier synthesis of the square wave function with n=', int2str(N), ' harmonics.' ));
n = n+1;
end
