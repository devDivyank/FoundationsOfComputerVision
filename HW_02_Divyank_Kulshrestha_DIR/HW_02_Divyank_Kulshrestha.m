function HW_02_Divyank_Kulshrestha()
% Q1 - finding the version and license number
    ver;

% Q4 - virginia_creeper.jpg
    im = imread('IMG_2742_Virginia_Creeper.jpg');
    im_gray = im2double(im( 2:2:end, 2:2:end, 2) );
    threshold = 0.55;
    binary_im = im2bw(im_gray, threshold);
    figure;
    imshow(binary_im);

% Q5 - contrast enhancement
    im = imread('IMG_2548__Needs_Contrast_Enhancement.jpg');
    im_gray = im2double( im( 2:2:end, 2:2:end, 2) );
    im_equalized = histeq(im_gray);
    figure;
    imshow(im_equalized);

% Q6 - IVY against wild grape vines
    im = imread('IMG_2653_IVY_Against_Wild_Grape_Vines.jpg');
    im_gray = im2double(im( 2:2:end, 2:2:end, 2) );
    threshold = 0.45;
    binary_im = im2bw(im_gray, threshold);
    figure;
    imshow(binary_im);

% Q7 - Deer with ears
    im = imread('IMG_2663_DEER_with_Ears_small.jpg');
    im_db = im2double(im);

% 7(a) trying the red channel
    figure;
    imagesc( im_db(:,:,1) );
    colormap(gray(256));
    axis image;

% 7(b) trying the green channel
    figure;
    imagesc( im_db(:,:,2) );
    colormap(gray(256));
    axis image;

% 7(c) trying the blue channel
    figure;
    imagesc( im_db(:,:,3) );
    colormap(gray(256));
    axis image;

% 7(d) trying rgb2gray
    im_gray = rgb2gray( im_db );
    figure;
    imshow(im_gray);

% 7(e) compute yellowness
    im_yellow = ( im_db(:,:,1) + im_db(:,:,2) - 2 * im_db(:,:,3 ) )/ 2;
    figure;
    imshow(im_yellow);

% 7(f) trying whatever
    im_whatever = ( im_db(:,:,1) + im_db(:,:,3) - 2 * im_db(:,:,2 ) )/ 2;
    figure;
    imshow(im_whatever);

% 7(g) trying whatever
    im_whatever = ( im_db(:,:,2) + im_db(:,:,3) - 2 * im_db(:,:,1 )) / 2;
    figure;
    imshow(im_whatever);
    
end