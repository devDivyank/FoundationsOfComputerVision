
function Show_Color_Separations_rgby(input_digital_image)
    im = imread(input_digital_image);
    im = im2double(im);
%     getting all the channels
    red = im(:,:,1);
    green = im(:,:,2);
    blue = im(:,:,3);
    yellow = (im(:,:,1) + im(:,:,2) - 2 * im(:,:,3))/ 2;
    yellow = max(yellow, 0);        % negative values set to zero

    colormap("gray");

    % plotting red channel
    subplot(2, 2, 1);
    imagesc(red);
    title('PIXELS WITH HIGH RED VALUE:');

    % plotting green channel
    subplot(2, 2, 2);
    imagesc(green);
    title('PIXELS WITH HIGH GREEN VALUE:');

    % plotting blue channel
    subplot(2, 2, 3);
    imagesc(blue);
    title('PIXELS WITH HIGH BLUE VALUE:');

    % plotting yellow channel
    subplot(2, 2, 4);
    imagesc(yellow);
    title('PIXELS WITH HIGH YELLOW VALUE:');
    xlabel("negative values set to zero.")

end