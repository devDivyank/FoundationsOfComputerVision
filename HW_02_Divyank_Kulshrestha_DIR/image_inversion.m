function image_inversion()
% the grayscale image, using imagesc
    im_db = im2double( imread('cameraman.tif'));
    imagesc( im_db );
    colormap( gray(256) );
    axis image;
% displaying the negative of the image
    imagesc( 1 - im_db ) ;
    axis image;

end