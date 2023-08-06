function HW07_dk9924_FIND_RASPBERRIES( filename )
    im_in = imread(filename);
%     for faster computations
    im_sub_sampled = im_in( 1:4:end, 1:4:end, : ); 
%     double to perform computations
    im_double = im2double(im_sub_sampled);
%     getting clicks on raspberries from the user
    figure;
    imshow(im_double);
    raspberry_clicks = ginput();
    raspberry_pixels = zeros(size(raspberry_clicks, 1), 3);
    
%     setting value of raspberry pixels from 
%     corresponding raspberry clicks (coordinates)
    for i = 1:size(raspberry_clicks, 1)
        raspberry_pixels(i, 1) = im_double(round(raspberry_clicks(i,2)), ...
                round(raspberry_clicks(i,1)),1);
        raspberry_pixels(i, 2) = im_double(round(raspberry_clicks(i,2)), ...
                round(raspberry_clicks(i,1)),2);
        raspberry_pixels(i, 3) = im_double(round(raspberry_clicks(i,2)), ...
                round(raspberry_clicks(i,1)),3);
    end
    
%     calculating the mahalanobis distance between 
%     image pixels and raspberry pixels
    mahalanobis_dist = mahal(reshape(im_double, [], 3), raspberry_pixels);
    im_out = zeros(size(im_double(:, :, 1)));
    for i = 1:size(im_double, 1)
        for j = 1:size(im_double, 2)
            ind = size(im_double(:,:,1), 1) * (j-1) + i;
            current = mahalanobis_dist(ind);
%             if distance is less than threshold 10, its a raspberry pixel
            if current < 10
                im_out(i, j) = 1;
            end
        end
    end
    imshow(im_out);
end