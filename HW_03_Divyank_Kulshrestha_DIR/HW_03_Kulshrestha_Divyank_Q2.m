function HW_03_Kulshrestha_Divyank_Q2()
    % getting the version
    ver;
    
    % make the apples stand out
    im = imread('IMG_20220828_Apples.jpg');
    red = im(:, :, 1);
    im_equalized = histeq(red);  % best result with red channel
    figure;
    imshow(im_equalized);

%     Using imfinfo()
    info = imfinfo('IMG_2523_Matilda_STROOP_EFFECT.JPG');

%     date and color space info
    disp(info);

%     checking for aperture
    disp(info.DigitalCamera.ApertureValue);

%     checking for ISO Speed
    disp(info.DigitalCamera.ISOSpeedRatings);

%     checking for flash
    disp(info.DigitalCamera.Flash);

%     checking for focal length
    disp(info.DigitalCamera.FocalLength);

end

