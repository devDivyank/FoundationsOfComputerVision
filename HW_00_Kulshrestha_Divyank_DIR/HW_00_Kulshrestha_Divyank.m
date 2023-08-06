function HW_00_Kulshrestha_Divyank(filename)
%     reading and displaying the rgb image
    rgbImage = imread(filename);
    imshow(rgbImage);

%     converting to grey-image and displaying it
    greyImage = rgb2gray(rgbImage);
    figure;
    imshow(greyImage);

%     finding the maximum size of the image and then resizing to 
%     less than 640 col x 480 rows
    shrunkenRGBImage = imresize(rgbImage, 0.2068);
    figure;
    imshow(shrunkenRGBImage);

%     Swapping the red and green channels and displaying the image
    shrunkenRGBImage(:,:,[1 2]) = shrunkenRGBImage(:,:,[2 1]);
    figure;
    imshow(shrunkenRGBImage);

%     inverting the centre half of the image
    invertedImage = rgbImage;
    [rows, cols, ~] = size(invertedImage);
    centerRow = round(rows/2);
    centerCol = round(cols/2);
%     calculating and inverting the centre half
    invertedImage(centerRow-round(rows/4)+1:centerRow+round(rows/4), ...
                centerCol-round(cols/4)+1:centerCol+round(cols/4),:) ...
        = 255 - invertedImage(centerRow-round(rows/4)+1:centerRow+round(rows/4), ...
                centerCol-round(cols/4)+1:centerCol+round(cols/4),:);
    figure;
    imshow(invertedImage)

%     saving the image at quality 90 and then 5 and displaying it
    imwrite(rgbImage, 'temp.jpg', 'Quality', 90);
    image90 = imread('temp.jpg');
    figure;
    imshow(image90);
    imwrite(image90, 'temp.jpg', 'Quality', 5);
    image5 = imread('temp.jpg');
    figure;
    imshow(image5);

%     inverting only one color channel
    rgbImage(:,:,1) = 255 - rgbImage(:,:,1);
    figure;
    imshow(rgbImage);

%     reading two images as double images, resizing and subtracting
    vineetImage = imread('Vineet.jpeg');
    vineetDoubleImage = im2double(vineetImage);
    divyankImage = imread(filename);
    divyankDoubleImage = im2double(divyankImage);

    resizedVineetImage = imresize(vineetDoubleImage, [480, 640]);
    resizedDivyankImage = imresize(divyankDoubleImage, [480, 640]);

    imageDifference = resizedDivyankImage - resizedVineetImage;
    figure;
    imagesc(imageDifference);

%     converting to hsv and playing with it
    hsvImage = rgb2hsv(divyankImage);
    figure;
    imshow(hsvImage);
    hueOnly = hsvImage(:,:,1);
    figure;
    imagesc(hueOnly);
    colormap(hsv(256));
    
%     splitting the channels and displaying at the same time
    im = imread(filename);
    im_small = imrotate( im( 2:3:end, 2:3:end, : ), 0 );
    im_up_right = zeros( size(im_small) );
    im_up_right(:,:,1) = im_small(:,:,1);
    im_down_left = zeros( size(im_small) );
    im_down_left(:,:,2) = im_small(:,:,2);
    im_down_right = zeros( size(im_small));
    im_down_right(:,:,3) = im_small(:,:,3);
    im_composite = [ im_small , im_up_right ;
                im_down_left , im_down_right ];
    figure;
    imagesc( im_composite );

end
