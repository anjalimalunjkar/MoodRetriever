function [face]=faceDetect()

    clear all
    clc
    FDetect = vision.CascadeObjectDetector;
    img =imread('E:\Project\images\images (1).jpg');
    I=rgb2gray(img);
    BB = step(FDetect,I);
    for i = 1:size(BB,1)
        J1= imcrop(I,BB(i,:));
    end
    J = bilinearInterpolation(J1, [331 331]);
    %# Create an ellipse shaped mask
    c = fix(size(J) / 2);   %# Ellipse center point (y, x)
    r_sq = [140,155] .^ 2;  %# Ellipse radii squared (y-axis, x-axis)
    [X, Y] = meshgrid(1:size(J, 2), 1:size(J, 1));
    ellipse_mask = (r_sq(2) * (X - c(2)) .^ 2 + ...
        r_sq(1) * (Y - c(1)) .^ 2 <= prod(r_sq));

    %# Apply the mask to the image
    face = bsxfun(@times, J, uint8(ellipse_mask));    
end