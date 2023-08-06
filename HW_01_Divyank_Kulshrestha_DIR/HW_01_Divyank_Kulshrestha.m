function HW_01_Divyank_Kulshrestha()
% getting the version
    ver;

% finding position ofthe tip of the nose
    image = imread("Dr.Niu.png");
    imshow(image);
    [x,y] = ginput(1);
    disp(x);
    disp(y);
 
% splitting the colour channels    
    red = image(:, :, 1);
    green = image(:, :, 2);
    blue = image(:, :, 3);
    figure;
    imshow(red);
    figure;
    imshow(green);
    figure;
    imshow(blue);

% Using my own photo to turn to greyscale and rotate clockwise
    img = imread("Divyank.jpeg");
    greenChannel = img(:,:,2);
    img = imrotate(greenChannel, 315);
    figure;
    imshow(img);
    imwrite(img, 'HW01_Dynamic_Divyank_Kulshrestha.jpg');

% Plotting the cycles of sine wave with tight axis 
    x = 0 : 1080;    
    y = sin(x*(pi/180));
    figure;
    plot(x, y, 'b')
    xlabel('Degrees', 'Fontsize', 18 );
    ylabel('Sine of Theta', 'Fontsize', 18);
    axis tight;

end